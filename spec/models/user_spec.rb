require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = User.new(
        account_name: "unique_test_user_#{Time.current.to_i}",
        password: "password123",
        password_confirmation: "password123"
      )
      expect(user).to be_valid
    end

    it "is invalid without account_name" do
      user = User.new(password: "password123")
      expect(user).not_to be_valid
    end

    it "is invalid with short password" do
      user = User.new(account_name: "test_user", password: "12345")
      expect(user).not_to be_valid
    end
  end

  describe "associations" do
    it "has many experience_posts" do
      association = User.reflect_on_association(:experience_posts)
      expect(association.macro).to eq :has_many
    end
  end
end
