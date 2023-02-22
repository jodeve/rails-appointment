class Schedule < ApplicationRecord
  has_many :books
  has_many :popups

  def self.at day, i
    find_by day: day, start: i, close: i + 1
  end

  def is_full_on? datetime
    slots_left(datetime) == 0
  end

  def slots_left datetime
    bs = Book.upcoming_on datetime
    limit - bs.count
  end

  def has_upcoming_popups?
    popups.upcoming.count > 0
  end


end
