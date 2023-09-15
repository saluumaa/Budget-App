class ExpensesCategory < ApplicationRecord
  belongs_to :expense, class_name: 'Expense', foreign_key: 'expense_id'
  belongs_to :category, class_name: 'Category', foreign_key: 'category_id'

  validates :expense_id, presence: true
  validates :category_id, presence: true
end
