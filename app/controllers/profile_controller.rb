class ProfileController < ApplicationController
	before_action :authenticate_user!
  def index
    @photos = Photo.my_photos(current_user, :page => params[:page])
    @page = 2
  end

  def show_more_photos
    @photos = Photo.my_photos(current_user, :page => params[:page])
    @page = params[:page].to_i + 1
    respond_to do |format|
      format.js
    end
  end

  def edit
  	@user = current_user
  	respond_to do |format|
			format.js
		end
  end
end
