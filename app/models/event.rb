class Event < ApplicationRecord
  belongs_to :admin, class_name: 'User'
  has_many :attendances
  has_many :guests, class_name: 'User', through: :attendances
  validates :start_date, presence: true, comparison: { greater_than: DateTime.now }
  validates :duration, presence: true, numericality: { divisible_by: 5, greater_than: 0 }
  validates :title, presence: true, length: 5..140
  validates :description, presence: true, length: 20..10000
  validates :price, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10000 }
  validates :location, presence: true
  has_one_attached :picture
end
