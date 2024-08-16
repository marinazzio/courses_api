class Competence < ApplicationRecord
  has_and_belongs_to_many :courses

  validates :title, presence: true
end
