class DropLineItems < ActiveRecord::Migration[5.2]
  def change
    drop_table :line_items
  end
end
