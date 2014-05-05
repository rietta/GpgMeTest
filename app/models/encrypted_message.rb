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
  MUST_IMPLEMENT  = 'Must be implemented by a subclass.'
  PGP_ERROR       = 'Must be an OpenPGP encrypted message.'
  PGP_OPENING     = '-----BEGIN PGP MESSAGE-----'
  PGP_ENDING      = '-----END PGP MESSAGE-----'

  # The validation won't pass unless the ciphertext blocks are set to OpenPGP
  before_validation :prepare_cipher_text

  # The database does not let these fields be nil, so the presence is needed.
  validate  :validate_ciphertext_is_not_plain, :expiration_is_in_the_future
  validates :delete_at, presence: true
  validates :type, presence: true
  validates :encrypted_body, presence: true
  validates :encrypted_structured_body, presence: true

  ##
  # Prepare the ciphertext for the encrypted record
  def prepare_cipher_text
    self.encrypted_body             = encrypt_text(body_plaintext)
    self.encrypted_structured_body  = encrypt_text(structured_plaintext.to_json)
    return
  end

  ##
  # Encrypt the text to the authorized recipients using GnuPG.
  # The keys need to be present in the local GPG keyring.
  def encrypt_text(text)
    crypto = GPGME::Crypto.new(armor: true)
    crypto.encrypt(text, recipients: recipient_keys).to_s
  end

  def self.pgp_message?(ciphertext)
    lines = ciphertext.to_s.strip.split("\n")
    if lines.length > 1 and PGP_OPENING == lines.first and PGP_ENDING == lines.last
      true
    else
      false
    end
  end # pgp_message?

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

  ##############################
  private

  def validate_ciphertext_is_not_plain
    unless EncryptedMessage.pgp_message?(encrypted_body)
      errors.add(:encrypted_body, PGP_ERROR)
    end

    unless EncryptedMessage.pgp_message?(encrypted_structured_body)
      errors.add(:encrypted_structured_body, PGP_ERROR)
    end
  end # validate_ciphertext_is_not_plain

  def expiration_is_in_the_future
    if delete_at and delete_at.past?
      errors.add(:delated_at, 'Cannot be in the Past.')
    end
  end


end # EncryptedMessage
