class AddColumnToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :location, :string
  end
end
