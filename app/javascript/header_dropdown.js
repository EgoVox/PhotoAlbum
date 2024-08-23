document.addEventListener('DOMContentLoaded', function() {
  const toggle = document.getElementById('header-albums-toggle');
  const dropdown = document.getElementById('header-albums-list');

  // Cache la liste au départ
  dropdown.style.display = 'none';

  // Ajoute un écouteur d'événement pour le clic
  toggle.addEventListener('click', function(event) {
    event.preventDefault();

    // Bascule l'affichage de la liste déroulante
    dropdown.style.display = dropdown.style.display === 'none' ? 'block' : 'none';
  });

  // Fermer la liste déroulante si on clique en dehors
  document.addEventListener('click', function(event) {
    if (!toggle.contains(event.target) && !dropdown.contains(event.target)) {
      dropdown.style.display = 'none';
    }
  });
});
