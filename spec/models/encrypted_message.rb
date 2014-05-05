require 'spec_helper'

describe EncryptedMessage do
  context 'Testing if PGP Encrypted' do
    it 'When starts and ends with a block' do
      msg = "-----BEGIN PGP MESSAGE-----\nVersion: GnuPG v1\n7KwvSSEyADeT7sQHUEs7ZLgHs4/Qo3sq5wb6ryjukj8fKhYqn8fX+peoaiypwtHv\nkfKAu6lgyiCbjd4TaS+xRzZsiQsvekc=\n=slXk\n-----END PGP MESSAGE-----\n"
      EncryptedMessage.pgp_message?(msg).should be_true
    end

    it 'When starts but does not end with a block' do
      msg = "-----BEGIN PGP MESSAGE-----\nVersion: GnuPG v1\n7KwvSSEyADeT7sQHUEs7ZLgHs4/Qo3sq5wb6ryjukj8fKhYqn8fX+peoaiypwtHv\nkfKAu6lgyiCbjd4TaS+xRzZsiQsvekc=\n=slXk"
      EncryptedMessage.pgp_message?(msg).should be_false
    end

    it 'When does not start, but ends with a block' do
      msg = "Version: GnuPG v1\n7KwvSSEyADeT7sQHUEs7ZLgHs4/Qo3sq5wb6ryjukj8fKhYqn8fX+peoaiypwtHv\nkfKAu6lgyiCbjd4TaS+xRzZsiQsvekc=\n=slXk\n-----END PGP MESSAGE-----\n"
      EncryptedMessage.pgp_message?(msg).should be_false
    end

  end # testing PGP encrypted
end