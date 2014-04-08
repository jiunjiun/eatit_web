class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates :url, :format => URI::regexp(%w(http https))

  def self.search(url)

  end
end
