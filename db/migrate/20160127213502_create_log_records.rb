class CreateLogRecords < ActiveRecord::Migration
  def change
    create_table :log_records do |t|
      t.timestamps null: false

      t.string :file_name, null: false
      t.string :file_path, null: false

      # The remaining data
      t.string :extra, null: false
    end
  end
end
