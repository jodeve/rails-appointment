class AddColumnsNameRefPhoneAndCourseToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :name, :string
    add_column :books, :phone, :string
  end
end
