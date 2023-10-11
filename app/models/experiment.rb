class Experiment < ApplicationRecord
  has_many :scientist_experiments
  has_many :scientists, through: :scientist_experiments

  validates :name, presence: true
  validates :objective, presence: true
  validates :num_months, presence: true
end
