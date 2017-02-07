require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "Example", email: "example@example.com", password_digest: "helloworld")
    @user.save
  end

   describe "attributes" do
     it "should have name, email, and password_digest attributes" do
       expect(@user).to have_attributes(name: @user.name, email: @user.email, password_digest: @user.password_digest)
     end
   end
end
