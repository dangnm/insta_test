# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  caption    :string(255)
#  data       :integer
#  created_at :datetime
#  updated_at :datetime
#

class Photo < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  belongs_to :user
  mount_uploader :data, PhotoUploader
  crop_uploaded :data  
  
  has_many :comments, dependent: :destroy
  hashtaggable_attribute :caption

  def self.my_photos(user, params = {:page => 1})
    @photos = Photo.paginate(:page => params[:page], :per_page => 9)
                   .where(:user_id => user.id)
  end

  def self.search_photo_by_hash_tags(tags)
    @photos = []
    @hash_tags = SimpleHashtag::Hashtag.where(name: tags)
    @hash_tags.each do |hash_tag|
      hash_tag.hashtaggables.each do |tag_object|
        if tag_object.class == Photo
          @photos.push(tag_object) unless @photos.include?(tag_object)
        elsif tag_object.class == Comment
          @photos.push(tag_object.photo) unless @photos.include?(tag_object.photo)
        end
      end
    end
    @photos
  end

end
