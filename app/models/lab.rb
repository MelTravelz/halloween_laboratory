class Lab < ApplicationRecord
  has_many :scientists

  validates :name, presence: true

  def find_scientists_by_experiment_total
    scientists
    .left_joins(:scientist_experiments)
    .select("scientists.*, COUNT(scientist_experiments.id) as experiment_count")
    .group("scientists.id")
    .order("experiment_count DESC")
  end
end