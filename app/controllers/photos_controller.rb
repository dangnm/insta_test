class PhotosController < ApplicationController
	def create
		@photo = Photo.new
		@photo.caption = params[:photo][:caption]
		@photo.user_id = params[:photo][:user_id]
		@photo.data = params[:photo][:data]
		@photo.save
		respond_to do |format|
			format.js
		end
	end
end
