require 'rails_helper'


RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'Creates a new user with correct fields' do

      @user = User.create(name: 'Marco', email: 'marco@email.com', password:'1234567', password_confirmation: '1234567')
      @user.valid?
      expect(@user.errors.full_messages).to eq([])

    end

    it 'Must have same password and password confirmation' do
      
      @user = User.create(name: 'Marco', email: 'marco@email.com', password:'1234567', password_confirmation: 'qwerty123')
      @user.valid?
      expect(@user.errors.full_messages).to eq(["Password confirmation doesn't match Password"])

    end

    it 'Must have unique email, not case sensitive' do
      
      @user1 = User.create(name: 'Marco', email: 'POLO@EMAIL.com', password:'1234567', password_confirmation: '1234567')
      @user1.valid?
      @user2 = User.create(name: 'Marco', email: 'polo@email.COM', password:'1234567', password_confirmation: '1234567')
      @user2.valid?
      expect(@user2.errors.full_messages).to eq(['Email has already been taken'])

    end

    it 'Must require email' do
      
      @user = User.create(name: 'Marco', email: nil, password:'1234567', password_confirmation: '1234567')
      @user.valid?
      expect(@user.errors.full_messages).to eq(["Email can't be blank"])

    end

    it 'Must require first name' do
      
      @user = User.create(name: nil, email: 'polo@email,com', password:'1234567', password_confirmation: '1234567')
      @user.valid?
      expect(@user.errors.full_messages).to eq(["Name can't be blank"])

    end

    it 'Must has a password with a minimum length of 6' do

      @user = User.create(name: 'Marco', email: 'marco@email.com', password:'12345', password_confirmation: '12345')
      @user.valid?
      expect(@user.errors.full_messages).to eq(['Password is too short (minimum is 6 characters)'])

    end
  

  end

  describe '.authenticate_with_credentials' do

    it 'Should return user with correct email and password' do

      User.create(name: 'Marco', email: 'marco@email.com', password:'1234567', password_confirmation: '1234567')
      @user = User.authenticate_with_credentials('marco@email.com', '1234567')
      expect(@user).to eq(User.find_by_email('marco@email.com'))

    end

    it 'Should still be authenticated successfully when a visitor types in a few spaces before and/or after their email address' do

      User.create(name: 'Marco', email: 'marco@email.com', password:'1234567', password_confirmation: '1234567')
      @user = User.authenticate_with_credentials('    marco@email.com    ', '1234567')
      expect(@user).to eq(User.find_by_email('marco@email.com'))

    end

    it 'Should still be authenticated successfully when a visitor types in the wrong case for their email' do

      User.create(name: 'Marco', email: 'marco@email.com', password:'1234567', password_confirmation: '1234567')
      @user = User.authenticate_with_credentials('MarCo@eMaiL.coM', '1234567')
      expect(@user).to eq(User.find_by_email('marco@email.com'))

    end

    it 'Should fail when typed wrong email' do

      User.create(name: 'Marco', email: 'marco@email.com', password:'1234567', password_confirmation: '1234567')
      @user = User.authenticate_with_credentials('polo@email.com', '1234567')
      expect(@user).not_to eq(User.find_by_email('marco@email.com'))

    end

    it 'Should fail when user type wrong password' do

      User.create(name: 'Marco', email: 'marco@email.com', password:'1234567', password_confirmation: '1234567')
      @user = User.authenticate_with_credentials('marco@email.com', '123456')
      expect(@user).not_to eq(User.find_by_email('marco@email.com'))

    end

  end
end