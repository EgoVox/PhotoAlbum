class PhotosController < ApplicationController
  # Avant d'exécuter les actions create et destroy, on exécute la méthode set_album
  before_action :set_album

  # l'action create est responsable de la création d'une nouvelle photo en utilisant les paramètres du formulaire
  def create
    image_urls = photo_params[:images] || []
    errors = []

    image_urls.each do |image_url|
      next if image_url.blank?

      photo = @album.photos.build(image: image_url)
      if photo.save
        puts "Photo ajoutée avec succès : #{photo.image}"
      else
        errors << photo.errors.full_messages
      end
    end

    if errors.any?
      redirect_to album_path(@album), alert: "Photos n'ont pas été ajoutées : #{errors.join(', ')}"
    else
      redirect_to album_path(@album), notice: "Photos ajoutées avec succès."
    end
  end

  # l'action destroy est responsable de la suppression d'une photo
  def destroy
    @photo = @album.photos.find(params[:id])
    @photo.destroy
    redirect_to @photo.album, notice: 'La photo a bien été supprimée.'
  end

  def update
    @photo = Photo.find(params[:id])
    Rails.logger.debug "Mise à jour de la photo avec les paramètres: #{photo_params.inspect}"

    if @photo.update(photo_params)
      Rails.logger.debug "Mise à jour réussie de la photo: #{@photo.inspect}"
      render json: { success: true, message: 'Description mise à jour avec succès.' }
    else
      Rails.logger.debug "Échec de la mise à jour de la photo: #{@photo.errors.full_messages.join(', ')}"
      render json: { success: false, message: @photo.errors.full_messages.join(', ') }
    end
  end

  # On définit les méthodes privées de la classe
  private

  #  On définit la méthode set_album qui récupère l'album à partir de l'id passé dans les paramètres
  def set_album
    Rails.logger.info "Album slug from params: #{params[:album_id]}"
    @album = Album.find_by!(slug: params[:album_id])
  end

  # Méthode pour définir les paramètres autorisés pour la création d'une photo
  def photo_params
    params.require(:photo).permit({images: []}, :description)
  end
end
