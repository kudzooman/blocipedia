class Wiki < ActiveRecord::Base

  belongs_to :user
  
  #has_many :collaborators
  #has_many :users through: => :collaborators

  # wiki.users => collorators
  # wiki.user => owner/creator

end
