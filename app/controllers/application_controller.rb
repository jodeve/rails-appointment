class ApplicationController < ActionController::Base
  include MyDateConcerns

  helper_method :is_future?
  helper_method :build_date_by_weekday

end
