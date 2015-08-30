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

  PHOTOS_PER_PAGE = 9

  PHOTOS_FEED_PER_PAGE = 4

  def add_comment(commenter, message)
    comment = Comment.new
    comment.user = commenter
    comment.photo = self
    comment.message = message
    comment.save
    comment
  end

  def self.my_photos(user, params = {:page => 1})
    paginate(:page => params[:page], :per_page => PHOTOS_PER_PAGE)
                   .where(:user_id => user.id)
  end

  def self.my_photos_feed(user, params = {:page => 1})
    paginate(:page => params[:page], :per_page => PHOTOS_FEED_PER_PAGE)
                   .where(:user_id => user.followed_users.pluck(:id).push(user.id))
                   .order(created_at: :desc)
  end

  def self.search_photo_by_hash_tags(tags)
    photos = []
    hash_tags = SimpleHashtag::Hashtag.where(name: tags)
    hash_tags.each do |hash_tag|
      hash_tag.hashtaggables.each do |tag_object|
        if tag_object.class == Photo
          photos.push(tag_object) unless photos.include?(tag_object)
        elsif tag_object.class == Comment
          photos.push(tag_object.photo) unless photos.include?(tag_object.photo)
        end
      end
    end
    photos
  end

end
