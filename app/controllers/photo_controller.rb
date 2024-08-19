class PhotoController < ApplicationController

  def create
    @photo = @album.photos.build(photo_params)
    if @photo.save
      redirect_to @photo.album, notice: 'Photo was successfully created.'
    else
      redirect_to @photo.album, alert: 'Photo was not created.'
    end
  end

  def destroy
    @photo = @album.photos.find(params[:id])
    @photo.destroy
    redirect_to @photo.album, notice: 'Photo was successfully destroyed.'
  end

  private

  def set_album
    @album = Album.find(params[:album_id])
  end

  def photo_params
    params.require(:photo).permit(:image, :description)
  end

end
