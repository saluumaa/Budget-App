require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    let(:user) { User.create!(name: 'Salma', email: 'name@name.com', password: 'password') }
    subject { Category.create!(name: 'Food', icon: 'fas fa-utensils', author_id: user.id) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an icon' do
      subject.icon = nil
      expect(subject).to_not be_valid
    end
  end
end
