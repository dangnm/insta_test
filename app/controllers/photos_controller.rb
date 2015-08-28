class PhotosController < ApplicationController
  before_action :authenticate_user!
  def create
    @photo = Photo.new
    @photo.caption = params[:photo][:caption]
    @photo.user_id = params[:photo][:user_id]
    @photo.data = params[:photo][:data]
    @width = @photo.data.geometry[:width]
    @height = @photo.data.geometry[:height]
    
    @photo.save

    respond_to do |format|
      format.js
    end
  end

  def update
    @photo = Photo.find params[:id]
    @photo.data_crop_x = params[:photo][:data_crop_x]
    @photo.data_crop_y = params[:photo][:data_crop_y]
    @photo.data_crop_w = params[:photo][:data_crop_w]
    @photo.data_crop_h = params[:photo][:data_crop_h]
    @photo.data = @photo.data.file
    @photo.save
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
    @photo = Photo.where(:id => params[:id]).first
  end

end
