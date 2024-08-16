class Course < ApplicationRecord
  belongs_to :author

  has_and_belongs_to_many :competences

  validates :title, presence: true
end
