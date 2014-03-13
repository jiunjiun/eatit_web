class Score < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  before_save :save_score_attributes

  def self.sum(restaurant)
    result = {overall: 0, delicious: 0, service: 0, queues: 0, feel: 0}
    scores = self.where(restaurant: restaurant)
    scores.each do |score|
      result[:overall]   += score.overall
      result[:delicious] += score.delicious
      result[:service]   += score.service
      result[:queues]    += score.queues
      result[:feel]      += score.feel
    end

    result.each do |key, val|
      result[key] /= scores.length if scores.length > 0
    end
    return result
  end

  def self.comment(restaurant)
    self.select(:user_id, :comment).where(restaurant: restaurant)
  end

  private
  def save_score_attributes
    self.delicious = 0 if delicious.blank?
    self.service = 0 if service.blank?
    self.queues = 0 if queues.blank?
    self.feel = 0 if feel.blank?
  end
end
