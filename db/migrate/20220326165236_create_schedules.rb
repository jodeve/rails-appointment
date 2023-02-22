class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.string :day
      t.integer :start
      t.integer :close
      t.integer :limit, default: 3
      t.timestamps
    end
  end
end
