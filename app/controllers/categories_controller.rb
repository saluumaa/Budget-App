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
    icon_upload = params[:category][:icon]
    if icon_upload.present?
      file_path = Rails.root.join('app', 'assets', 'images', icon_upload.original_filename)
      File.binwrite(file_path, icon_upload.read)
      @category.icon = icon_upload.original_filename
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
    params.require(:category).permit(:name, :icon, :author_id)
  end
end
