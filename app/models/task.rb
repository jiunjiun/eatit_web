class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

end
