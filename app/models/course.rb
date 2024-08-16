class Course < ApplicationRecord
  belongs_to :author

  has_many :competences
end
