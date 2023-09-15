require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { User.create!(name: 'Salma', email: 'namw@gmail.com', password: 'password') }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end
end
