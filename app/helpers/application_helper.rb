module ApplicationHelper


  def date_from_day day
    @datetime.beginning_of_month.advance(:days => +(day - 1)) if day != nil
  end

  def path_with param, value
    @params[param] = value
    admin_root_path(@params)
  end

end
