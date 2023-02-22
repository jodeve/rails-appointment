module MyDateConcerns
  extend ActiveSupport::Concern

  included do
    helper_method :text_date
    helper_method :text_datetime
  end

  def text_datetime datetime
    datetime.strftime("%Y-%m-%d-%I")
  end

  def text_date date
    date.strftime("%Y-%m-%d")
  end

  def validate_start_of_week
    return redirect_to root_path(start_of_week: text_date(this_week_date)) if !params[:start_of_week]
    @start_of_week = DateTime.parse(params[:start_of_week])
  end

  def this_week_date
    today = DateTime.now
    today.beginning_of_week
  end

  def end_of_week date
    date.advance(:days => +7)
  end

  # get datetime by day of the week, this week
  def build_date_by_weekday day, i
    today = DateTime.now
    dayI = Date.strptime(day, '%A').wday
    hour = i.to_i
    bow = today.beginning_of_week # day = 0, Sunday
    bow = bow.advance(:days => +dayI, :hours => +hour)
  end

  def is_future? day, i
    date = build_date_by_weekday day, i
    date.future?
  end

end
