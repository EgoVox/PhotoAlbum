class PhotosController < ApplicationController
  # Avant d'exécuter les actions create et destroy, on exécute la méthode set_album
  before_action :set_album

  # l'action create est responsable de la création d'une nouvelle photo en utilisant les paramètres du formulaire
  def create
    # On crée une nouvelle instance de photo pour l'album. On préfère un .build à un .new pour que l'association au bon album soit faite via album.photos
    @photo = @album.photos.build(photo_params)
    if @photo.save
      redirect_to @photo.album, notice: 'La photo a bien été ajoutée.'
    else
      redirect_to @photo.album, alert: 'La photo n\'a pas été ajoutée.'
    end
  end

  # l'action destroy est responsable de la suppression d'une photo
  def destroy
    @photo = @album.photos.find(params[:id])
    @photo.destroy
    redirect_to @photo.album, notice: 'La photo a bien été supprimée.'
  end

  # On définit les méthodes privées de la classe
  private

  #  On définit la méthode set_album qui récupère l'album à partir de l'id passé dans les paramètres
  def set_album
    @album = Album.find_by!(slug: params[:album_id])
  end

  # Méthode pour définir les paramètres autorisés pour la création d'une photo
  def photo_params
    params.require(:photo).permit(:image, :description)
  end

end
