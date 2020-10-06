require 'zip'
require 'fileutils'

namespace :dataexport do
  desc 'export db in CSV'
  task :full_db => :environment do
    models = ActiveRecord::Base.connection.tables
    dump_file_name = "decidim_#{Date.today}"
    folder = "export/" + dump_file_name
    input_filenames = []

    FileUtils.mkdir_p(folder) unless Dir.exist?(folder)

    # Dump all tables in csv
    conn = ActiveRecord::Base.connection.raw_connection
    models.map do |model_name|
      # Some tables are not containing decidim specific informations
      if model_name.include? "decidim"
        file = "#{model_name}.csv"
        input_filenames << file
        file_path = folder + "/" + file
        File.open(file_path, 'w') do |f|
          conn.copy_data "COPY (SELECT * FROM #{model_name}) TO STDOUT WITH (FORMAT CSV, HEADER TRUE, FORCE_QUOTE *);" do
            while line = conn.get_copy_data do
              f.write line.force_encoding('UTF-8')
            end
          end
        end
      end
    end

    # Create archive
    zipfile_path = folder + ".zip"

    Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
      input_filenames.each do |filename|
        # Two arguments:
        # - The name of the file as it will appear in the archive
        # - The original file, including the path to find it
        zipfile.add(filename, File.join(folder, filename))
      end
    end

    # Delete generated csv
    FileUtils.rm_rf(folder)

    # Send emails
    Decidim::DbDumpMailer.send_dump(dump_file_name + ".zip", zipfile_path)
  end
end