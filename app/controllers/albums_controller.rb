class AlbumsController < ApplicationController
  # Avant d'exécuter les actions show, edit, update, destroy et edit_inline, on exécute la méthode set_album
  before_action :set_album, only: [:show, :edit, :update, :destroy, :edit_inline, :edit_photos, :delete_photos, :create_shareable_link]
  before_action :load_albums

  # On récupère tous les albums et on les stocke dans la variable @albums
  def index
    if current_user&.admin?
      @albums = Album.all.order(:created_at)
    else
      # Affiche les albums publics + ceux déverrouillés
      @albums = Album.where(private: false).or(Album.where(id: session[:unlocked_albums_ids]))
      Rails.logger.info "Albums visibles: #{@albums.map(&:name)}"
    end
  end

  def add_photos
    @album = Album.find(params[:id])

    if params[:photo][:images].present?  # Correspond au nom dans le formulaire
      params[:photo][:images].each do |url|
        @album.photos.create(image: url) unless url.blank?
      end
      redirect_to album_path(@album), notice: "Photos ajoutées avec succès."
    else
      redirect_to album_path(@album), alert: "Veuillez entrer au moins une URL d'image."
    end
  end

  def private_albums
    @albums = Album.where(private: true)
  end


  def unlock_private_albums
    @unlocked_albums = []

    Album.where(private: true).each do |album|
      if correct_password(album, params[:password])
        @unlocked_albums << album
        session[:unlocked_albums_ids] ||= []
        session[:unlocked_albums_ids] << album.id unless session[:unlocked_albums_ids].include?(album.id)
        Rails.logger.info "Album déverrouillé: #{album.name} (ID: #{album.id})"
      end
    end

    if @unlocked_albums.any?
      Rails.logger.info "Albums déverrouillés: #{@unlocked_albums.map(&:name)}"
      redirect_to albums_path, notice: 'Albums privés déverrouillés.'
    else
      Rails.logger.info "Mot de passe incorrect"
      redirect_to root_path, alert: "Mot de passe incorrect"
    end
  end

  # On récupère les photos de l'album et on les stocke dans la variable @photos pour les afficher dans la show
  def show
    @album = Album.find_by!(slug: params[:id])
    @photos = @album.photos.order(:created_at).page(params[:page]).per(20)

    if current_user&.admin?
      @albums = Album.all
    else
      @albums = Album.where(private: false).or(Album.where(id: session[:unlocked_albums_ids]))
    end
  end

  # On crée une nouvelle instance d'album. @album sera utilisée dans le formulaire de création d'album
  def new
    @album = Album.new
  end

  # l'action create est responsable de la création d'un nouvel album en utilisant les paramètres du formulaire

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to @album, notice: 'Album was successfully created.'
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
      redirect_to @album, notice: 'L\'album a été mis à jour.'
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
    redirect_to albums_url, notice: 'Les photos ont été supprimées.'
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
    redirect_to album_path(@album, view: 'full'), notice: 'Les photos ont été supprimées.'
  end

def create_shareable_link
  expires_at = params[:expires_at] || 1.week.from_now
  @shareable_link = @album.shareable_links.create!(expires_at: expires_at)

  # Utilisez l'URL générée en utilisant le slug de l'album
  redirect_to album_path(@album.slug), notice: "Lien de partage créé : #{album_shareable_link_url(@album.slug, @shareable_link.token)}"
end

  # les méthodes privées sont accessible uniquement à l'intérieur du controlleur
  private

  def correct_password(album, password_attempt)
    album.authenticate(password_attempt)
  end

  def set_album
    @album = Album.find_by!(slug: params[:id])
  end

  def album_params
    params.require(:album).permit(:name, :year, :slug, :private, :password)
  end

  def load_albums
    @albums = Album.all unless request.path == albums_path
  end
end
