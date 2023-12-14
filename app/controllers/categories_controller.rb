class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category


  def index
    @categories = current_user.categories.order(created_at: :desc)
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to root_path, notice: "Category added successfully!" }
      else
        format.html { redirect_to root_path, alert: @category.errors.full_messages.first }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to root_path, notice: "Category updated successfully!" }
      else
        format.html { redirect_to root_path, alert: @category.errors.full_messages.first }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @category.destroy
        format.html { redirect_to root_path, notice: "Category deleted successfully!" }
      else
        format.html { redirect_to root_path, alert: "Oops! Something went wrong while deleting the category." }
      end
    end
  end

  private
  def set_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit(
      :name
    ).merge(user_id: current_user.id)
  end
end
