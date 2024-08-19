class AlbumsController < ApplicationController
  # Avant d'exécuter les actions show, edit, update, destroy et edit_inline, on exécute la méthode set_album
  before_action :set_album, only: [:show, :edit, :update, :destroy, :edit_inline, :edit_photos, :delete_photos]

  # On récupère tous les albums et on les stocke dans la variable @albums
  def index
    @albums = Album.all
  end

  # On récupère les photos de l'album et on les stocke dans la variable @photos pour les afficher dans la show
  def show
    @photos = @album.photos
  end

  # On crée une nouvelle instance d'album. @album sera utilisée dans le formulaire de création d'album
  def new
    @album = Album.new
  end

  # l'action create est responsable de la création d'un nouvel album en utilisant les paramètres du formulaire
  def create
    # On crée un nouvel album avec les paramètres du formulaire
    @album = Album.new(album_params)
    # Si l'album est sauvegardé, on redirige vers la page de l'album avec un message de succès
    if @album.save
      redirect_to @album, notice: 'Album was successfully created.'
    # Sinon, on redirige vers la page de création d'album permettant de corriger les erreurs
    else
      render 'new'
    end
  end

  def edit
    # Comme 'before_action :set_album' est défini, on a déjà récupéré l'album dans la méthode set_album
  end

  # l'action update est responsable de la mise à jour d'un album en utilisant les paramètres du formulaire
  def update
    # Si l'album est mis à jour avec succès, on redirige vers la page de l'album avec un message de succès
    if @album.update(album_params)
      redirect_to @album, notice: 'Album was successfully updated.'
    else
      # Sinon, on redirige vers la page d'édition de l'album permettant de corriger les erreurs
      render 'edit'
    end
  end

  # l'action destroy est responsable de la suppression d'un album
  def destroy
    # On supprime l'album de la base de données
    @album.destroy
    # On redirige vers la page des albums avec un message de succès
    redirect_to albums_url, notice: 'Album was successfully destroyed.'
  end

  # l'action edit_inline est responsable de l'édition en ligne d'un album sans recharge de la page
  def edit_inline
    # ouvre un bloc pour répondre à différentes requêtes
    respond_to do |format|
      # indique que la réponse sera du javascript, ce qui exécutera un fichier js.erb pour manipuler la page via AJAX
      format.js
    end
  end

  def edit_photos
    @photos = @album.photos
  end

  def delete_photos
    @photos = @album.photos.where(id: params[:photo_ids])
    @photos.destroy_all
    redirect_to edit_photos_album_path(@album), notice: 'Photos deleted successfully.'
  end

  # les méthodes privées sont accessible uniquement à l'intérieur du controlleur
  private

  # On récupère l'album en fonction de l'id passé dans les paramètres
  def set_album
    @album = Album.find(params[:id])
  end

  # On définit les paramètres autorisés pour la création et la mise à jour d'un album
  def album_params
    params.require(:album).permit(:name)
  end
end
