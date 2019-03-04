class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      table.string :full_name
      table.integer :pin_number
    end
  end
end
