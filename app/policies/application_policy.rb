class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    user.present? && (user.role?(:admin) || scope )
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && (user.role?(:admin) || record.user == user)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (user.role?(:admin) || record.user == user)
  end

  def scope
    record.class
  end
end

