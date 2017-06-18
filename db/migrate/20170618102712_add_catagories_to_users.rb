class AddCatagoriesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :categories, :string
  end
end
