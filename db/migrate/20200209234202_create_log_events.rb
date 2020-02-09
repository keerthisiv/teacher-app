class CreateLogEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :log_events do |t|
      t.references :teacher, foreign_key: true, index: true
      t.datetime :event_time, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.string :description
      t.string :event_type, null: false, index: true

      t.timestamps
    end
  end
end
