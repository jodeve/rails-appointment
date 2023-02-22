class Popup < ApplicationRecord
  include UpcomingConcern

  scope :upcoming, -> { where("popups.on_at >= ? ", DateTime.now) }

end
