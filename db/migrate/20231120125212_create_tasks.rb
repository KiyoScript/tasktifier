class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :due_date
      t.text :notes
      t.integer :repeat, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
