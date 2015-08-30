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

require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe '#my_photos' do
    before do
      stub_const("Photo::PHOTOS_PER_PAGE", 9)
    end
    let!(:user1) { create(:user, email: 'test@test.com')}
    let!(:user2) { create(:user, email: 'test2@test.com')}
    let!(:photos1) { create_list(:photo, 10, user: user1)}
    let!(:photos2) { create_list(:photo, 5, user: user2)}
    before do  
      @photos_1_page_1 = Photo.my_photos(user1, {page: 1})
      @photos_1_page_2 = Photo.my_photos(user1, {page: 2})
    end
    it "returns 9 photos on the first page" do
      expect(@photos_1_page_1.to_a.size).to eq(9)
    end 

    it "returns 1 photo on the second page" do
      expect(@photos_1_page_2.to_a.size).to eq(1)
    end 

    it "does not contain photos of other users" do
      expect(@photos_1_page_1).not_to include(*photos2)
      expect(@photos_1_page_2).not_to include(*photos2)
    end
  end

  describe '#my_photos_feed' do
    before do
      stub_const("Photo::PHOTOS_FEED_PER_PAGE", 4)
    end
    context "query photo feed of user 2 which follows user 1" do
      let!(:user1) { create(:user, email: 'test@test.com')}
      let!(:user2) { create(:user, email: 'test2@test.com')}
      let!(:user3) { create(:user, email: 'test3@test.com')}
      let!(:photos1) { create_list(:photo, 4, user: user1)}
      let!(:photos2) { create_list(:photo, 3, user: user2)}
      let!(:photos3) { create_list(:photo, 3, user: user3)}
      before do 
        user2.follow!(user1)
        @photos_2_page_1 = Photo.my_photos_feed(user2, {page: 1})
        @photos_2_page_2 = Photo.my_photos_feed(user2, {page: 2})
      end
      it "returns 4 photos of his photos or his follower photos
          on the first page" do
        expect(@photos_2_page_1.to_a.size).to eq(4)
      end

      it "returns 3 photos of his photos or his follower photos
          on the second page" do
        expect(@photos_2_page_2.to_a.size).to eq(3)
      end

      it "does not contain photos of unfollowed users" do 
        expect(@photos_2_page_1).not_to include(*photos3)
        expect(@photos_2_page_2).not_to include(*photos3)
      end
    end
  end

  describe '#search_photo_by_hash_tags' do 
    context "Photos which have been tagged on caption & comments" do
      let!(:user_1) { create(:user, email: 'test@test.com')}
      let!(:photo_1) { create(:photo, user: user_1, caption: 'Good #test')}
      let!(:comment_1_1) { create(:comment, user: user_1, 
                               photo: photo_1,
                               message: 'Good #test')}
      let!(:photo_2) { create(:photo, user: user_1, caption: 'Good #test')}
      let!(:comment_2_1) { create(:comment, user: user_1, 
                               photo: photo_2,
                               message: 'Good #test')}
      it "returns unique photos" do
        photos = Photo.search_photo_by_hash_tags('test')
        expect(photos.to_a.size).to eq(2)
        expect(photos).to include(photo_1)
        expect(photos).to include(photo_2)
      end
    end
end

end
