class AddUrlFieldToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :url, :string
  end
end
