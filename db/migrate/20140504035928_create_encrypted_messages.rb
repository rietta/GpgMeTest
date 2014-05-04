class CreateEncryptedMessages < ActiveRecord::Migration
  def change
    create_table :encrypted_messages do |t|
      # Non-secure data, that is visible in the database.
      t.string :type, null: false
      t.string :plaintext_description
      
      # Data retention policy enforcement, delete this message after
      # If your project does not require a data retention delete date,
      # comment out the null: false.
      t.date :delete_at, null: false
      
      # Encrypted data fields, where the PGP-encrypted blobs will go
      t.text :encrypted_body
      t.text :encrypted_structured_body

      t.timestamps
    end
    
    add_index :encrypted_messages, :type
    add_index :encrypted_messages, :delete_at
  end
end
