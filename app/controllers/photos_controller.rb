class PhotosController < ApplicationController
  before_action :authenticate_user!
  def create
    @photo = Photo.new
    @photo.caption = params[:photo][:caption]
    @photo.user_id = current_user.id
    @photo.data = params[:photo][:data]
    @width = @photo.data.geometry[:width]
    @height = @photo.data.geometry[:height]
    
    @photo.save

    respond_to do |format|
      format.js
    end
  end

  def crop
    @photo = current_user.crop_photo(Photo.new(:id => params[:id]), 
                                     params[:photo][:data_crop_x],
                                     params[:photo][:data_crop_y],
                                     params[:photo][:data_crop_w],
                                     params[:photo][:data_crop_h])
    redirect_to root_path
  end

  def show_more_feed
    @photos = Photo.my_photos_feed(current_user, :page => params[:page])
    @page = params[:page].to_i + 1

    respond_to do |format|
      format.js
    end
  end

  def show
    @photo = Photo.find_by_id(params[:id])
  end

  def show_and_mark_read
    @activity = Activity.find_by_id(params[:activity_id])
    @activity.mark_as_read! :for => current_user
    redirect_to photo_path(@activity.recipient.photo.id)
  end

end
