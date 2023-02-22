require "admin/application_controller"

module Admin
  class SchedulesController < ApplicationController
    before_action :set_schedule, only: %i[ show edit update destroy ]

    # GET /schedules or /schedules.json
    def index
      @schedules = Schedule.all
    end

    # GET /schedules/1 or /schedules/1.json
    def show
    end

    # GET /schedules/new
    def new
      @schedule = Schedule.new
    end

    # POST /schedules or /schedules.json
    #def create
    #  params[:days].each do |day|
    #    start = params[:start].to_i
    #    close = params[:close].to_i
    #    (start..close).each do |i|
    #      Schedule.create day: day, start: i, close: i + 1
    #    end
    #  end
    #  redirect_to admin_root_path, notice: "Schedule was successfully created."
    #end

    def create
      Schedule.create day: params[:day], start: params[:start], close: params[:start].to_i + 1
      redirect_to admin_root_path, notice: "Schedule was successfully created."
    end

    # DELETE /schedules/1 or /schedules/1.json
    def destroy
      @schedule.destroy
      redirect_to schedules_url, notice: "Schedule was successfully destroyed."
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_schedule
        @schedule = Schedule.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def schedule_params
        params.require(:schedule).permit(:day, :start, :close)
      end
  end

end
