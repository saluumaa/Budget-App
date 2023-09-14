class Category < ApplicationRecord
    belongs_to :user, foreign_key: "author_id"
    has_many :expenses_categories, class_name: 'ExpensesCategory', dependent: :destroy, foreign_key: "category_id"
    has_many :expenses, through: :expenses_categories

    validates :name, presence: true
    validates :icon, presence: true

    def total_amount
        expenses.sum(:amount)
    end
end
