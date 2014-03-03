class Restaurant < ActiveRecord::Base
  has_many :score
  has_many :task

  def self.search(name, address)
    if !name.empty? && !address.empty?
      Restaurant.select(:id, :name, :address).where("name like ? && address like ?", "%#{name}%", "%#{address}%")
    elsif !name.empty?
      Restaurant.select(:id, :name, :address).where("name like ? ", "%#{name}%")
    elsif !address.empty?
      Restaurant.select(:id, :name, :address).where("address like ?", "%#{address}%")
    end
  end
end
