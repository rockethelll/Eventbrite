class Event < ApplicationRecord
  has_many :attendances
  has_many :users through: :attendances
  validates :start_date, presence: true, comparison: { greater_than: DateTime.now }
  validates :duration, presence: true, numericality: { equal_to: %5 = 0 && > 0}
  validates :title, presence: true, length: 5..140
  validates :description, presence: true, length: 20..10000
  validates :price, presence: true, length: 1..10000
  validates :location, presence: true
end