document.addEventListener('DOMContentLoaded', function() {
  // Récupère la modale, l'image dans la modale, et le bouton de fermeture
  var modal = document.getElementById("imageModal");
  var modalImg = document.getElementById("modalImage");
  var closeBtn = document.getElementsByClassName("close")[0];

  // Fonction pour ouvrir la modale avec l'image cliquée
  function openModal(imageSrc) {
    modal.style.display = "flex";
    modalImg.src = imageSrc;
  }

  // Ajoute un écouteur d'événement sur l'image principale du carrousel
  var mainImage = document.querySelector('.main-image img');
  if (mainImage) {
    mainImage.addEventListener('click', function() {
      openModal(mainImage.src);
    });
  }

  // Ajoute un écouteur d'événement sur chaque image de la vue album
  var albumImages = document.querySelectorAll('.photo-fullsize');
  albumImages.forEach(function(img) {
    img.addEventListener('click', function() {
      openModal(img.src);
    });
  });

  // Ferme la modale lorsqu'on clique sur le bouton de fermeture
  closeBtn.addEventListener('click', function() {
    modal.style.display = "none";
  });

  // Ferme la modale si l'utilisateur clique en dehors de l'image
  modal.addEventListener('click', function(event) {
    if (event.target === modal) {
      modal.style.display = "none";
    }
  });
});
