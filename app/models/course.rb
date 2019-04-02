class Course < ApplicationRecord
  has_many :questions 
  validates :name, presence: true, length: { minimun: 5, maximum: 50 }
  validates :description, presence: true, length: { minimun: 10, maximum: 300 }
end
