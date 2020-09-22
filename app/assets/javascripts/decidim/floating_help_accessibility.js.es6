window.addEventListener('load', () => {
  const floatingHelperTip =  document.getElementById('floating-helper-tip');
  const floatingHelperContent = document.getElementById('floating-helper-block');
  const floatingHelperClose = document.getElementsByClassName('floating-helper__content-close')[0]

  floatingHelperTip.addEventListener("click", () => {
    floatingHelperContent.focus();
    floatingHelperTip.blur();
  });

  floatingHelperClose.addEventListener("click", () => {
    floatingHelperTip.focus();
    floatingHelperContent.blur();
  });
});