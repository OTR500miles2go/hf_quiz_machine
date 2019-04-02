class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :course_id
      t.text :body
      t.integer :format_type
      t.integer :difficult_level

      t.timestamps
    end
  end
end
