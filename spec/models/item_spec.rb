require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = User.new(name: "Example", email: "example@example.com", password_digest: "helloworld")
    @user.save
    @list = List.new(title: "Grocery List", private: false, user: @user)
    @list.save
    @item = Item.new(description: "3 bananas", completed: false, list: @list)
    @item.save
  end

  describe "attributes" do
    it "should have title, private, and user attributes" do
      expect(@item).to have_attributes(description: @item.description, completed: @item.completed, list: @item.list)
    end
  end
end
