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

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#photo_comments' do 
    before do
      stub_const("Comment::COMMENTS_PER_PAGE", 4)
    end
    context "The photo has more than 4 comments" do
      let!(:user_1) { create(:user, email: 'test2@test.com')}
      let!(:photo_1) { create(:photo, user: user_1, caption: 'Good')}
      let!(:comments_1) do 
        7.times.collect {|i| create(:comment, user: user_1, 
                          photo: photo_1,
                          message: "test_#{i}") }
      end

      before do
        @comments_page_1 = Comment.photo_comments(photo_1, page: 1)
        @comments_page_2 = Comment.photo_comments(photo_1, page: 2)
      end

      it "returns 4 last comments in normal order of timeline
          on the first page" do
        expect(@comments_page_1.to_a.size).to eq(4)
        expect(@comments_page_1.to_a[0]).to eq(comments_1[3])
        expect(@comments_page_1.to_a[1]).to eq(comments_1[4])
        expect(@comments_page_1.to_a[2]).to eq(comments_1[5])
        expect(@comments_page_1.to_a[3]).to eq(comments_1[6])
      end

      it "returns more comments previous to 4 last 
          comments in normal order of timeline on the next page" do
        expect(@comments_page_2.to_a.size).to eq(3)
        expect(@comments_page_2.to_a[0]).to eq(comments_1[0])
        expect(@comments_page_2.to_a[1]).to eq(comments_1[1])
        expect(@comments_page_2.to_a[2]).to eq(comments_1[2])
      end
    end

  end
end
