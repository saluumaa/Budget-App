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
    @category = Category.new(category_params.except(:icon))
    @category.author_id = current_user.id
    uploaded_icon = params[:category][:icon]
    if uploaded_icon.present?
      file_path = Rails.root.join('app', 'assets', 'images', uploaded_icon.original_filename)
      File.binwrite(file_path, uploaded_icon.read)
      @category.icon = uploaded_icon.original_filename
    end
    if @category.save
      redirect_to categories_path
    else
      render :new
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
