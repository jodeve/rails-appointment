def create_schedule day, i
  Schedule.create(
    day: day,
    start: i,
    close: i + 1
  )
end

def create_seed
  Date::DAYNAMES.each do |day|
      if day != "Sunday" && day != "Saturday"
        (8..16).each do |i|
          create_schedule day, i
        end
      end
    end

  (8..11).each do |i|
    create_schedule "Saturday", i
  end
end
