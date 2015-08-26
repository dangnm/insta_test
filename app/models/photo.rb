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
end
