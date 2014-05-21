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
      if user.role == :admin
        scope.all
      elsif user.role == :premium
        all = scope.all
        res = []
        all.each do |s|
          if s.public? || s.user == user || s.users.include? :user
            res << s
          end
        end
        res
      else
        # mortal users
      end
    end
  end
end