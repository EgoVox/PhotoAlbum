document.addEventListener('DOMContentLoaded', function() {

  const themeToggleBtn = document.getElementById('theme-toggle-btn');

  if (themeToggleBtn) {
    themeToggleBtn.addEventListener('click', function(event) {
      event.preventDefault();
      document.body.classList.toggle('dark-mode');
      themeToggleBtn.innerHTML = document.body.classList.contains('dark-mode') ? '<i class="fas fa-sun"></i>' : '<i class="fas fa-moon"></i>';
    });
  } else {
    console.log('Theme toggle button not found.');
  }
});
