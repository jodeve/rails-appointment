class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.datetime :on_at
      t.timestamps
    end
  end
end
