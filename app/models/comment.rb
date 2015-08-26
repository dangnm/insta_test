class Comment < ActiveRecord::Base
	include SimpleHashtag::Hashtaggable
  belongs_to :user
  belongs_to :photo
  hashtaggable_attribute :message
end
