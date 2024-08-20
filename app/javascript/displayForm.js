document.addEventListener('DOMContentLoaded', function() {
  const toggleFormBtn = document.getElementById('toggle-form-btn');
  const formContainer = document.getElementById('photo-form-container');

  toggleFormBtn.addEventListener('click', function() {
    // Bascule l'affichage du formulaire
    if (formContainer.style.display === 'none' || formContainer.style.display === '') {
      formContainer.style.display = 'block';
      toggleFormBtn.textContent = 'Masquer le formulaire';
    } else {
      formContainer.style.display = 'none';
      toggleFormBtn.textContent = 'Ajouter une photo';
    }
  });
});
