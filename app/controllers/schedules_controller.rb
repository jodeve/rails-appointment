class SchedulesController < ApplicationController
  before_action :validate_start_of_week
  before_action :set_schedule, only: %i[ show edit update destroy ]

  def index
    @schedules = Schedule.all
  end

end
