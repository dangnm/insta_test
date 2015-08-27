# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  photo_id   :integer
#  message    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
	include SimpleHashtag::Hashtaggable
  belongs_to :user
  belongs_to :photo
  hashtaggable_attribute :message
end
