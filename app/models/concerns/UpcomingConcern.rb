module UpcomingConcern
  extend ActiveSupport::Concern

  included do

    def self.upcoming_on datetime
      i = datetime.strftime("%k")
      nextHour = datetime.advance(:hours => +1)
      where("on_at >= ?", datetime)
      .where("on_at < ?", nextHour)
    end

    def self.upcoming_on? datetime
      upcoming_on(datetime)
      .count > 0
    end

  end

end
