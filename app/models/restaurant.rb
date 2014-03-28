class Restaurant < ActiveRecord::Base
  has_many :score
  has_many :task

  def self.search(name, address)
    r = select(:id, :name, :area, :address, :telephone, :count)
    if !name.empty? && !address.empty?
      r.where("name like ? && address like ?", "%#{name}%", "%#{address}%")
    elsif !name.empty?
      r.where("name like ? ", "%#{name}%")
    elsif !address.empty?
      r.where("address like ?", "%#{address}%")
    end
  end

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
end