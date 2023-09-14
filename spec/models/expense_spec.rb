require 'rails_helper'

RSpec.describe Expense, type: :model do
    describe 'validations' do
        let(:user) { User.create!(name: 'Salma', email: 'name@gmai.com', password: 'password') }
        subject { Expense.create!(name: 'Food', amount: 10, author_id: user.id) }

        it 'is valid with valid attributes' do
            expect(subject).to be_valid
        end

        it 'is not valid without a name' do
            subject.name = nil
            expect(subject).to_not be_valid
        end

        it 'is not valid without an amount' do
            subject.amount = nil
            expect(subject).to_not be_valid
        end
    end
end