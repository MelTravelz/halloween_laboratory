class Experiment < ApplicationRecord
  has_many :scientist_experiments
  has_many :scientists, through: :scientist_experiments

  validates :name, presence: true
  validates :objective, presence: true
  validates :num_months, presence: true

  def self.find_long_experiments
    where("num_months > ?", 6).order(num_months: :desc)
  end

end
