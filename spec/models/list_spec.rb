require 'rails_helper'

RSpec.describe List, type: :model do
  before do
    @user = User.new(name: "Example", email: "example@example.com", password_digest: "helloworld")
    @user.save
    @list = List.new(title: "Grocery List", private: false, user: @user)
    @list.save
  end

  describe "attributes" do
    it "should have title, private, and user attributes" do
      expect(@list).to have_attributes(title: @list.title, private: @list.private, user: @list.user)
    end
  end
end
