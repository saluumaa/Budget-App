class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def index
    @user = current_user
    @expenses = Expense.order(created_at: :desc)
    @category = Category.find(params[:category_id])
    @total_amount = @category.total_amount
  end

  def new
    @category = Category.find(params[:category_id])
    @expense = Expense.new
    @user = current_user
    @categories = current_user.categories
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.author_id = current_user.id
    if @expense.save
      puts 'Expense saved successfully'
      redirect_to category_expenses_path(category_id: params[:category_id]),
                  notice: 'Expense was successfully created.'
    else
      puts 'Expense not saved'
      render :new
    end
  end

  def edit
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to category_expenses_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to category_expenses_path
  end

  private

  def set_group
    @category = Category.find(params[:category_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, category_ids: [])
  end
end
