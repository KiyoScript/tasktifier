class UserPresenter < ApplicationPresenter

  def initialize(current_user)
    @user = current_user
  end
  def username
    @user.email.split('@')[0]
  end

  def categories
    @user.categories.pluck(:name)
  end
end
