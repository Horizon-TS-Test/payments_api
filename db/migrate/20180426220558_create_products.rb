class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :pricing # scale numero de decimales y 10 numero de caracteres
      t.text :description
      t.references :user, foreign_key: true
      t.attachment :avatar
      t.timestamps
    end
  end
end
