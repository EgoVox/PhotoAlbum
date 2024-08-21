document.addEventListener('DOMContentLoaded', function() {
  const themeToggleButton = document.getElementById('theme-toggle-btn');
  const bodyElement = document.body;

  themeToggleButton.addEventListener('click', function() {
    // Bascule la classe "dark-theme" sur l'élément body
    bodyElement.classList.toggle('dark-theme');

    // Change le texte du bouton en fonction du thème
    if (bodyElement.classList.contains('dark-theme')) {
      themeToggleButton.textContent = 'Mode clair';
    } else {
      themeToggleButton.textContent = 'Mode sombre';
    }
  });
});
