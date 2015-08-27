class SearchController < ApplicationController
	before_action :authenticate_user!
  def index
  end

  def search
  	@tags = params[:search][:text].split(',')
  	@photos = Photo.search_photo_by_hash_tags(@tags)
  	respond_to do |format|
			format.js
		end
  end
end
