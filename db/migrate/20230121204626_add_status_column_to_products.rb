class AddStatusColumnToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :status, :string, default: "available"
  end
end
