class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :full_name
      t.integer :pin_number
      t.boolean :is_teacher
    end
  end
end
