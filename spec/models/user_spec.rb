require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "requires password" do 
      @user = User.create(email: "test@test.com", name: "Rachel", password: nil)

      expect(@user.errors.full_messages_for(:password)).to  include "Password can't be blank"
    end

    it "requires password to be >= 8 characters" do 
      @user = User.create(email: "test@test.com", name: "Rachel", password: "short")

      expect(@user.errors.full_messages_for(:password)).to  include "Password is too short (minimum is 8 characters)"
    end

    it "allows a longer password" do 
      @user = User.create(email: "test@test.com", name: "Rachel", password: "pasworddddddddddd")

      expect(@user.errors.full_messages_for(:password)).to be_empty
    end

    it "requires name" do 
      @user = User.create(email: "test@test.com", name: nil, password: "passwordd")

      expect(@user.errors.full_messages_for(:name)).to include "Name can't be blank"
    end

    it "won't save users with non-unique emails" do 
      @user = User.create(email: "test@test.com", name: "Rachel", password: "passwordd")

      @second_user = User.create(email: "test@test.com", name: "Rachel", password: "passwordd")

      expect(@second_user.errors.full_messages_for(:email)).to include "Email has already been taken"
    end
  end

  describe '.authenticate_with_credentials' do
    it "authenticate method returns nil for user that doesn't exist" do 
      @result = User.authenticate_with_credentials("test@testers.com", "somepassword")
      expect(@result).to eq nil
    end

    it "authenticate method returns user instance for if it can authenticate" do 
      @user = User.create(email: "test@testers.com", name: "Rachel", password: "somepassword")
      @result = User.authenticate_with_credentials("test@testers.com", "somepassword")
      expect(@result).to eq @user
    end

    it "authenticate method returns user instance even if there's extra whitespace around the email" do 
      @user = User.create(email: "test@testers.com", name: "Rachel", password: "somepassword")
      @result = User.authenticate_with_credentials("  test@testers.com ", "somepassword")
      expect(@result).to eq @user
    end

    it "authenticate method returns user instance regardless of email case" do 
      @user = User.create(email: "tEst@tESTers.com", name: "Rachel", password: "somepassword")
      @result = User.authenticate_with_credentials("TesT@testerS.COM", "somepassword")
      expect(@result).to eq @user
    end

  end
end
