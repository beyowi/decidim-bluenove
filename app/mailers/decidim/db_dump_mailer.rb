# frozen_string_literal: true

module Decidim
  # A custom mailer for sending db dump to selected emails
  class DbDumpMailer < Decidim::ApplicationMailer
    def send_dump(file_name, file_path) # rubocop:disable Metrics/ParameterLists
      # Need to get organization for smtp configuration
      @organization = Decidim::Organization.find(1)
      return unless ENV["DB_DUMP_EMAILS"] && ENV["DB_DUMP_EMAILS"].split(";").size > 0

      attachments[file_name] = File.read(file_path)
      ENV["DB_DUMP_EMAILS"].split(";").each do |email|
        mail(to: email, subject: "Decidim Database Dump #{Date.today}")
      end
    end
  end
end