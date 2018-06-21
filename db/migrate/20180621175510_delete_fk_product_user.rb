class DeleteFkProductUser < ActiveRecord::Migration[5.1]
  def change
    if foreign_key_exists?(:products, :users)
      remove_foreign_key :products, :users
    end
  end
end
