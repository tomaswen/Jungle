require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      user = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: 'a@a.com',
        password: 'a12345678',
        password_confirmation: 'a12345678'
       )
      expect(user).to be_valid
    end

    it "is not valid with no first name, last name" do
      user = User.new(
        first_name: nil,
        last_name: nil,
        email: 'a@a.com',
        password: 'a12345678',
        password_confirmation: 'a12345678'
       )
      expect(user).to_not be_valid
      expect(user.errors.full_messages[0]).to eq "First name can't be blank"
      expect(user.errors.full_messages[1]).to eq "Last name can't be blank"
      
    end

    it "is not valid with no email" do
      user = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: nil,
        password: 'a12345678',
        password_confirmation: 'a12345678'
       )
      expect(user).to_not be_valid
      expect(user.errors.full_messages[0]).to eq "Email can't be blank"
    end

    it "is not valid with no password" do
      user = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: 'a@a.com',
        password: nil,
        password_confirmation: 'a12345678'
       )
      expect(user).to_not be_valid
      expect(user.errors.full_messages[0]).to eq "Password can't be blank"
    end

    it "is not valid with no password confirmation" do
      user = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: 'a@a.com',
        password: 'a12345678',
        password_confirmation: nil
       )
      expect(user).to_not be_valid
      expect(user.errors.full_messages[0]).to eq "Password confirmation can't be blank"
    end

    it "is not valid with no matching password and password confirmation" do
      user = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: 'a@a.com',
        password: 'a12345678',
        password_confirmation: "12345678910a"
       )
      expect(user).to_not be_valid
      expect(user.errors.full_messages[0]).to eq "Password confirmation doesn't match Password"
    end

    it "is not valid when email is taken(case sensitive) " do
      user1 = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: 'TEST@TEST.com',
        password: 'a12345678',
        password_confirmation: 'a12345678'
       )
       user1.save!

       user2 = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: 'test@test.COM',
        password: 'a12345678',
        password_confirmation: 'a12345678'
       )
      expect(user2).to_not be_valid
      expect(user2.errors.full_messages[0]).to eq "Email has already been taken"
    end

    it "is not valid with password length less than 8" do
      user = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: 'a@a.com',
        password: 'a1',
        password_confirmation: 'a1'
       )
      expect(user).to_not be_valid
      expect(user.errors.full_messages[0]).to eq 'Password is too short (minimum is 8 characters)'
    end
  end

  describe '.authenticate_with_credentials' do

    it 'authenticates user with correct password' do
      user = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: 'test@test.com',
        password: 'a12345678',
        password_confirmation: 'a12345678'
       )
       user.save!
      
      expect(User.authenticate_with_credentials('test@test.com', 'a12345678')).to eq(user)
    end

    it 'authenticates user with correct password and whitespaces' do
      user = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: 'test@test.com',
        password: 'a12345678',
        password_confirmation: 'a12345678'
       )
       user.save!
      
      expect(User.authenticate_with_credentials(' test@test.com ', 'a12345678')).to eq(user)
    end

    it 'authenticates user with correct password and whitespaces' do
      user = User.new(
        first_name: 'Alice',
        last_name: 'Al',
        email: 'test@test.com',
        password: 'a12345678',
        password_confirmation: 'a12345678'
       )
       user.save!
      
      expect(User.authenticate_with_credentials(' tEst@TeSt.cOm ', 'a12345678')).to eq(user)
    end
  end
end
