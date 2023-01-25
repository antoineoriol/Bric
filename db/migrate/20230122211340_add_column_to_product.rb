class AddColumnToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :start_date, :date
    add_column :products, :end_date, :date
    add_column :products, :available, :boolean, default: true
  end
end
