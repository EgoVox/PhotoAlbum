document.addEventListener('DOMContentLoaded', function() {
    const toggleEditModeBtn = document.getElementById('toggle-edit-mode-btn');
    const photoDescriptions = document.querySelectorAll('.photo-description');

    toggleEditModeBtn.addEventListener('click', function(event) {
        event.preventDefault();

        photoDescriptions.forEach(function(description) {
            if (description.style.display === 'none' || description.style.display === '') {
                description.style.display = 'block';
                description.setAttribute('contenteditable', 'true');
            } else {
                description.style.display = 'none';
                description.setAttribute('contenteditable', 'false');
            }
        });
    });

    photoDescriptions.forEach(function(description) {
        description.addEventListener('click', function(event) {
            if (description.getAttribute('contenteditable') === 'true') {
                description.focus();
            }
        });

        description.addEventListener('blur', function(event) {
            const updatedDescription = description.textContent.trim();
            const photoId = description.getAttribute('data-photo-id');
            const albumId = description.getAttribute('data-album-id');

            const url = `/albums/${albumId}/photos/${photoId}`;
            console.log("URL construite pour le fetch:", url);  // Ajout du log pour afficher l'URL

            // Envoie la requête AJAX pour mettre à jour la description sur le serveur
            fetch(url, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                },
                body: JSON.stringify({ photo: { description: updatedDescription } })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('Description mise à jour avec succès.');
                } else {
                    console.error('Erreur lors de la mise à jour de la description.');
                }
            });
        });
    });
});
