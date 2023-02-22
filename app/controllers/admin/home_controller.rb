require "admin/application_controller"
module Admin
  class HomeController < ApplicationController
    before_action :validate_admin_start_of_week

    def index
      @books_today = Book.where("on_at >= ?", @datetime.beginning_of_day)
                          .where("on_at < ?", @datetime.end_of_day)
                          .count
      @books_week_query = Book.where("on_at >= ?", @datetime.beginning_of_week)
                          .where("on_at < ?", @datetime.end_of_week)

      @books_week =  @books_week_query.count

      @books_month = Book.where("on_at >= ?", @datetime.beginning_of_month)
                          .where("on_at < ?", @datetime.end_of_month)
                          .count
      #@schedules = Schedule.all
      @books = Book.upcoming_on @datetime
      @overview = @books_week_query.group_by_day_of_week(:on_at, format: "%A").count
    end
  end
end
