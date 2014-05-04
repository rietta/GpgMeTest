class CreateEncryptedMessages < ActiveRecord::Migration
  def change
    create_table :encrypted_messages do |t|
      t.string :type
      t.text :body
      t.text :structured_body

      t.timestamps
    end
  end
end
