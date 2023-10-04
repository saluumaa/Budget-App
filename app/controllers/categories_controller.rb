class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @categories = @user.categories
  end

  def show; end

  def new
    if params[:category_id]
      @parent_category = Category.find(params[:category_id])
      @category = @parent_category.children.build
    else
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_params)
    @category.author_id = current_user.id
    if @category.save
      redirect_to categories_path
    else
      redirect_to new_category_path
      flash[:alert] = group.errors.full_messages.join(', ')
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
