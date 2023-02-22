module SchedulesHelper

  def is_start_of_week_beginning_of_week?
    @start_of_week == DateTime.now.beginning_of_week
  end

  def last_week_date
    beginning_of_week = @start_of_week.beginning_of_week
    beginning_of_week.ago(1.week)
  end

  def next_week_date
    beginning_of_week = @start_of_week.beginning_of_week
    beginning_of_week.advance(:days => +7)
  end

  def last_week_date_text
    text_date last_week_date
  end

  def next_week_date_text
    text_date next_week_date
  end

  def readable_date date
    "#{date.day.ordinalize} #{date.strftime('%b')}"
  end

  def get_datetime day, hour
    @start_of_week.advance(:days => +day, :hours => +hour)
  end


  def new_schedule_state schedule, datetime
    has_upcoming_popups = Popup.upcoming_on? datetime
    return "not-available" if !schedule
    return "popup" if has_upcoming_popups
    return "booked" if schedule.limit?
    return "disabled" if !is_future? schedule.day, schedule.start
    return "available"
  end

  def name day, i
    "#{day} #{i}-#{i+1}"
  end

  def is_future? datetime
    date = build_date_by_weekday day, i
    date.future?
  end

end
