class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # def new?
  #   true
  # end

  def create?
    true
  end

  def show?
    true
  end

  # def edit?
  #   user == record.user
  # end

  def update?
    true
  end

  def destroy?
    true
  end

  def my_products?
    true
  end

  def search?
    true
  end

  def reviews?
    true
  end

  private

  # def user_is_owner_or_admin?
  #   user == record.user || user.admin
  # end
end
