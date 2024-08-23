document.addEventListener('DOMContentLoaded', function() {
  const addPhotoBtn = document.getElementById('add-photo-btn');
  const urlFieldsContainer = document.getElementById('url-fields-container');
  const descriptionField = document.querySelector('textarea[name="photo[description]"]');

  if (addPhotoBtn && urlFieldsContainer && descriptionField) {
    addPhotoBtn.addEventListener('click', function(event) {
      event.preventDefault();

      // Récupère tous les champs URL actuellement présents
      const allFields = urlFieldsContainer.querySelectorAll('input[name="photo[images][]"]');
      const lastField = allFields[allFields.length - 1];  // Sélectionne le dernier champ

      // Vérifie si le dernier champ est rempli
      if (lastField && lastField.value.trim() !== '') {
        // Grise le champ description
        descriptionField.disabled = true;
        descriptionField.style.backgroundColor = '#e9ecef'; // Gris clair

        // Crée un nouveau champ URL
        const newField = document.createElement('div');
        newField.classList.add('form-group');
        newField.innerHTML = `
          <label class="form-label">Ajouter une image</label>
          <input type="text" name="photo[images][]" class="form-input">
        `;
        urlFieldsContainer.appendChild(newField);
      } else {
        alert('Veuillez remplir le champ avant d\'ajouter un autre.');
      }
    });
  }
});
