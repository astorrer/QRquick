class CreateQuickCodes < ActiveRecord::Migration
  def change
    create_table :quick_codes do |t|
      t.string :name
      t.string :content
      t.integer :size
      t.string :level
      t.integer :offset
      t.integer :unit
      t.string :fill
      t.string :color

      t.timestamps
    end
  end
end
