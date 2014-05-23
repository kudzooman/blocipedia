class Wiki < ActiveRecord::Base

  has_many :collaborators

  has_many :users, through: :collaborators

  belongs_to :user

  def public?
    self.where(public: true)
  end
  
  # wiki.users => collorators
  # wiki.user => owner/creator

end
