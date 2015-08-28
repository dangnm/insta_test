class HomeController < ApplicationController
	before_action :authenticate_user!
  def index
  	@photos = Photo.my_photos_feed(current_user, :page => params[:page])
  end
end
