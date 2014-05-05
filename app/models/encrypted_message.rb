# == Schema Information
#
# Table name: encrypted_messages
#
#  id                        :integer          not null, primary key
#  type                      :string(255)      not null
#  plaintext_description     :string(255)
#  delete_at                 :date             not null
#  encrypted_body            :text
#  encrypted_structured_body :text
#  created_at                :datetime
#  updated_at                :datetime
#

class EncryptedMessage < ActiveRecord::Base
  MUST_IMPLEMENT = 'Must be implemented by a subclass.'

  # The database does not let these fields be nil, so the presence is needed.
  validates :delete_at, presence: true
  validates :type, presence: true

  ##
  # Encrypt the text to the authorized recipients using GnuPG.
  # The keys need to be present in the local GPG keyring.
  def encrypt_text(text)
    crypto = GPGME::Crypto.new(armor: true)
    crypto.encrypt(text, recipients: recipient_keys).to_s
  end

  #############################
  protected

  ##
  # The keys of the parties to receive this data
  #
  # This could presumably be specified in a database, rather than hard coded.
  # The choice is left to the developer who is adopting this test to their own purposes. In business environment, typically three or more keys are used. The recipients who are authorized and a backup key for the company, that is kept under seal.
  def recipient_keys
    [
      '0x0CD8B255', # Frank Rietta
      '0x91C8FEBF', # Brandon Dees
      '0xFD019213', # Security Team, Serving as the Backup Key
    ]
  end

  def structured_plaintext
    raise MUST_IMPLEMENT
  end

  def body_plaintext
    raise MUST_IMPLEMENT
  end
end
