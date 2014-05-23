class WikiPolicy
attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    true
  end

  class Scope

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.role?(:admin)
        scope.all
      elsif user.role?(:premium)
        all = scope.all
        wikis = []
        all.each do |wiki|
          if wiki.public? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki
          end
        end
        wikis
      else
        all = scope.all
        wikis = []
        all.each do |wiki|
          if wiki.public? || wiki.users.include?(user)
            wikis << wiki
          end
        end
        wikis
      end
    end
  end
end
