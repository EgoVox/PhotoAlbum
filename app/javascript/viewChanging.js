document.addEventListener('DOMContentLoaded', function() {
  const toggleViewBtn = document.getElementById('toggle-view-btn');

  if (toggleViewBtn) {
    toggleViewBtn.addEventListener('click', function(event) {
      event.preventDefault();

      // Détermine la vue actuelle
      const currentView = new URLSearchParams(window.location.search).get('view');
      const newView = currentView === 'full' ? '' : 'full';

      // Met à jour dynamiquement l'URL sans recharger la page
      const newUrl = newView ? `${window.location.pathname}?view=${newView}` : window.location.pathname;
      history.pushState(null, '', newUrl);

      // Recharge le contenu de la page via AJAX (ou toute autre méthode)
      // Exemple simple : recharger la page partielle
      window.location.href = newUrl;
    });
  }
});
