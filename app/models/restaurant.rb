class Restaurant < ActiveRecord::Base
  has_many :score
  has_many :task

  def self.search(name, address)
    r = select(:id, :name, :address)
    if !name.empty? && !address.empty?
      r.where("name like ? && address like ?", "%#{name}%", "%#{address}%")
    elsif !name.empty?
      r.where("name like ? ", "%#{name}%")
    elsif !address.empty?
      r.where("address like ?", "%#{address}%")
    end
  end
end
