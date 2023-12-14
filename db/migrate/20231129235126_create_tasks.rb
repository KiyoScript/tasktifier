class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :due_date
      t.text :notes
      t.integer :mark_as_done, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :category, null: true, foreign_key: true, default: nil

      t.timestamps
    end
  end
end

