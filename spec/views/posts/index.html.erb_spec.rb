# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    @user = User.find_by id: 1
    post1 = Post.create(caption: 'I am the first seeded picture', user_id: 1)
    post1.picture.attach(io: File.open(Rails.root + 'app/assets/images/test1.jpg'), filename: 'test1.jpg')

    post2 = Post.create(caption: 'I am the second', user_id: 1)
    post2.picture.attach(io: File.open(Rails.root + 'app/assets/images/test2.jpg'), filename: 'test2.jpg')
    assign(:posts, [post1, post2])
  end

  context "it renders a list of posts" do

    it 'contains the text caption' do
      render
      assert_select "tr>td", text: "I am the first seeded picture".to_s, count: 1
      assert_select "tr>td", text: "I am the second".to_s, count: 1
    end

    it 'contains the uploaded images' do
      render
      assert_select "tr>td>img:match('src', ?)", /test1.jpg/
      assert_select "tr>td>img:match('src', ?)", /test2.jpg/
    end

    it 'contains the username of the uploader' do
      render
      assert_select "tr>td", text: 'bob', count: 2
    end
  end
end
