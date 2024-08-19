class AlbumController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy, :edit_inline]

  def index
    @albums = Album.all
  end

  def show
    @photos = @album.photos
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to @album, notice: 'Album was successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @album.update(album_params)
      redirect_to @album, notice: 'Album was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @album.destroy
    redirect_to albums_url, notice: 'Album was successfully destroyed.'
  end

  def edit_inline
    respond_to do |format|
      format.js
    end
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name)
  end
end
