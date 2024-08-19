document.addEventListener('DOMContentLoaded', function() {
  console.log('DOM is loaded');

  const albumsShowElement = document.querySelector('[data-controller="albums-show"]');
  if (!albumsShowElement) {
    return;
  }

  const thumbnails = document.querySelectorAll('.thumbnail');
  const mainImage = document.getElementById('main-image');
  const mainImageDescription = document.getElementById('main-image-description');
  const leftControl = document.querySelector('.control-left');
  const rightControl = document.querySelector('.control-right');

  const thumbnailsPerPage = 4;
  let currentIndex = 0;
  let startThumbnailIndex = 0;

  // Fonction pour afficher les miniatures en fonction de l'index de départ
  function updateThumbnails() {
    thumbnails.forEach((thumbnail, index) => {
      // Calcul de l'index réel dans le défilement circulaire
      const circularIndex = (startThumbnailIndex + index) % thumbnails.length;
      if (index < thumbnailsPerPage) {
        thumbnails[circularIndex].style.display = 'block';
      } else {
        thumbnails[circularIndex].style.display = 'none';
      }
    });
  }

  function updateMainImage(index) {
    const selectedThumbnail = thumbnails[index];
    if (selectedThumbnail) {
      mainImage.src = selectedThumbnail.querySelector('img').src;

      const description = selectedThumbnail.dataset.description;
      if (description && description.trim() !== "") {
        mainImageDescription.textContent = description;
      } else {
        mainImageDescription.textContent = '';
      }

      thumbnails.forEach((thumbnail, idx) => {
        if (idx === index) {
          thumbnail.classList.add('active-thumbnail');
        } else {
          thumbnail.classList.remove('active-thumbnail');
        }
      });
    }
  }

  function showNextThumbnails() {
    startThumbnailIndex = (startThumbnailIndex + 1) % thumbnails.length;
    updateThumbnails();
    currentIndex = (currentIndex + 1) % thumbnails.length;
    updateMainImage(currentIndex);
  }

  function showPreviousThumbnails() {
    startThumbnailIndex = (startThumbnailIndex - 1 + thumbnails.length) % thumbnails.length;
    updateThumbnails();
    currentIndex = (currentIndex - 1 + thumbnails.length) % thumbnails.length;
    updateMainImage(currentIndex);
  }

  rightControl.addEventListener('click', function(event) {
    event.preventDefault();
    showNextThumbnails();
  });

  leftControl.addEventListener('click', function(event) {
    event.preventDefault();
    showPreviousThumbnails();
  });

  thumbnails.forEach((thumbnail, index) => {
    thumbnail.addEventListener('click', function() {
      currentIndex = index;
      updateMainImage(currentIndex);
      startThumbnailIndex = index; // Synchronisation de l'index de départ avec l'image sélectionnée
      updateThumbnails();
    });
  });

  // Initialiser les miniatures et l'image principale
  updateThumbnails();
  updateMainImage(currentIndex);
});
