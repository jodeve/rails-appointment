require "admin/application_controller"

module Admin
  class PopupsController < ApplicationController

    # POST /popups or /popups.json
    #def create
    #  day = @schedule.day
    #  i = @schedule.start
    #  on_at = build_date_by_weekday day, i
    #  @popup = @schedule.popups.build on_at: on_at
    #  if @popup.save
    #    redirect_to admin_root_path, notice: "Popup successfully created."
    #  else
    #    render :new, status: :unprocessable_entity
    #  end
    #end

    def create
      datetime = params[:datetime]
      on_at = DateTime::parse(datetime)
      @popup = Popup.new on_at: on_at
      if @popup.save
        redirect_to admin_root_path(datetime: on_at, start_of_week: on_at.beginning_of_week), notice: "Popup successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

      def set_schedule
        @schedule = Schedule.find(params[:schedule_id])
      end

  end

end
