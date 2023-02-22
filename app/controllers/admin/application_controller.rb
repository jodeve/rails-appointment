module Admin
  class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    include MyDateConcerns

    helper_method :is_future?
    helper_method :build_date_by_weekday

    def validate_admin_start_of_week
      p = {}
      start_of_week = params[:start_of_week]
      datetime = params[:datetime]

      if !start_of_week || !datetime
        p[:start_of_week] = text_date(this_week_date)
        p[:datetime] = DateTime.now
        return redirect_to admin_root_path(p)
      end
      @params = params.permit!
      @start_of_week = DateTime.parse(start_of_week)
      @datetime = DateTime.parse(datetime)
    end
  end

end
