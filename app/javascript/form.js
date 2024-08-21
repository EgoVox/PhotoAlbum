document.addEventListener('DOMContentLoaded', function() {
  const toggleFormBtn = document.getElementById('toggle-form-btn');
  const formContainer = document.getElementById('photo-form-container');
  const toggleDeleteModeBtn = document.getElementById('toggle-delete-mode-btn');
  const deletePhotosSubmit = document.getElementById('delete-photos-submit');
  const photoCheckboxes = document.querySelectorAll('.photo-checkbox');

  // Gestion du basculement du formulaire d'ajout de photos
  if (toggleFormBtn && formContainer) {
    toggleFormBtn.addEventListener('click', function(event) {
      event.preventDefault();
      formContainer.style.display = formContainer.style.display === 'none' || formContainer.style.display === '' ? 'block' : 'none';
    });
  }

  // Gestion du mode de suppression des photos
  if (toggleDeleteModeBtn && deletePhotosSubmit) {
    toggleDeleteModeBtn.addEventListener('click', function(event) {
      event.preventDefault();

      // Affiche ou masque les cases à cocher et le bouton de suppression
      const isDeleteMode = deletePhotosSubmit.style.display === 'block';
      deletePhotosSubmit.style.display = isDeleteMode ? 'none' : 'block';

      photoCheckboxes.forEach(function(checkbox) {
        checkbox.style.display = isDeleteMode ? 'none' : 'block';
      });
    });
  }
});
