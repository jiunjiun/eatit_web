class Restaurant < ActiveRecord::Base
  has_many :score
  has_many :task
end
