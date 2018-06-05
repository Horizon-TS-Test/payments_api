class CreateLinkAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :link_attachments do |t|
      t.references :link, foreign_key: true
      t.datetime :expiration_date
      t.references :attachment, foreign_key: true

      t.timestamps null: false
    end
  end
end
