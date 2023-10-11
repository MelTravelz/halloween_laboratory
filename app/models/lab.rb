class Lab < ApplicationRecord
  has_many :scientists

  validates :name, presence: true
end