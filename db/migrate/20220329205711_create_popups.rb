class CreatePopups < ActiveRecord::Migration[6.1]
  def change
    create_table :popups do |t|
      t.datetime :on_at
      t.timestamps
    end
  end
end
