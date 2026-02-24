class Event < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :attendances
  has_many :participants, through: :attendances, source: :user

  validates :start_date, presence: true
  validate  :start_date_cannot_be_in_the_past

  validates :duration, presence: true, numericality: { greater_than: 0 }
  validate  :duration_multiple_of_5

  validates :title, presence: true, length: { minimum: 5, maximum: 140 }

  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }

  validates :location, presence: true

  def end_date
    start_date + duration.minutes
  end

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Time.now
      errors.add(:start_date, "ne peut pas être dans le passé")
    end
  end

  def duration_multiple_of_5
    if duration.present? && duration % 5 != 0
      errors.add(:duration, "doit être un multiple de 5")
    end
  end
end
