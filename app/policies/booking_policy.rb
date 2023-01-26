class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: @user.id)
    end
  end

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

  def accept?
    true
  end

  def reject?
    true
  end

  private

  # def user_is_owner_or_admin?
  #   user == User.find(record.user_id) || user.admin
  # end
end
