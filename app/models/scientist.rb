class Scientist < ApplicationRecord
  belongs_to :lab
  has_many :scientist_experiments
  has_many :experiments, through: :scientist_experiments

  validates :name, presence: true
  validates :specialty, presence: true
  validates :university, presence: true

  def find_total_experiments
    experiments.size
  end
end