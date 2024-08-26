class ShareableLinksController < ApplicationController
  def show
    @shareable_link = ShareableLink.find_by!(token: params[:token])

    if @shareable_link.expires_at > Time.current
      @album = @shareable_link.album
      render 'albums/show'
    else
      redirect_to root_path, alert: 'Le lien de partage a expiré.'
    end
  end
end
