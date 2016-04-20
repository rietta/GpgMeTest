require 'spec_helper'

describe EncryptedMessage do
  context 'Testing if PGP Encrypted' do
    it 'When starts and ends with a block' do
      msg = "-----BEGIN PGP MESSAGE-----\nVersion: GnuPG v1\n7KwvSSEyADeT7sQHUEs7ZLgHs4/Qo3sq5wb6ryjukj8fKhYqn8fX+peoaiypwtHv\nkfKAu6lgyiCbjd4TaS+xRzZsiQsvekc=\n=slXk\n-----END PGP MESSAGE-----\n"
      expect(EncryptedMessage.pgp_message?(msg)).to eq true
    end

    it 'When starts but does not end with a block' do
      msg = "-----BEGIN PGP MESSAGE-----\nVersion: GnuPG v1\n7KwvSSEyADeT7sQHUEs7ZLgHs4/Qo3sq5wb6ryjukj8fKhYqn8fX+peoaiypwtHv\nkfKAu6lgyiCbjd4TaS+xRzZsiQsvekc=\n=slXk"
      expect(EncryptedMessage.pgp_message?(msg)).to eq false
    end

    it 'When does not start, but ends with a block' do
      msg = "Version: GnuPG v1\n7KwvSSEyADeT7sQHUEs7ZLgHs4/Qo3sq5wb6ryjukj8fKhYqn8fX+peoaiypwtHv\nkfKAu6lgyiCbjd4TaS+xRzZsiQsvekc=\n=slXk\n-----END PGP MESSAGE-----\n"
      expect(EncryptedMessage.pgp_message?(msg)).to eq false
    end

  end # testing PGP encrypted


  context 'Expiring Messages' do
    before(:each) do
      @base_attr = {
              plaintext_description: "Hello message.",
              type: 'Post',
              delete_at: Date.today,
              encrypted_body: "-----BEGIN PGP MESSAGE-----\nVersion: GnuPG v1\n\nhQIMA4Ybj5/9AZITAQ//XbsQE6NYE87q0uYw4GLXveOCLicp3E3lh+GgQujDy0ao\nMvcSvAzOED+Ii+U/NqhXo3sjYGDqd/U00bh/IYRlm7aAkFnAIgrDFI2Ci/RLM\ncaYGKCEFl4HAupATWdyQa/1P3R+3O67hL2SC\n=BEK/\n-----END PGP MESSAGE-----\n",
       encrypted_structured_body: "-----BEGIN PGP MESSAGE-----\nVersion: GnuPG v1\n\nhQIMA4Ybj5/9AZITARAAjUxVHFNBTkSMiVx5Pa9bNJXyxYMJ+0DHIepOk5h3/6GA\nlBlGvNJsYKyOmVw0Xbag8vDMSBkrAFuaynBn6BqAWZ8KBMA1Q5cKpFzX8YtL0\n03LsMbbxAxc31XqMdAYd8GfEPZIwdCLrOCuJVA==\n=11c2\n-----END PGP MESSAGE-----\n"
         }

    end # each


    it 'Deleting cases expired before today' do
      messages = [
        EncryptedMessage.new(@base_attr.merge(delete_at: Date.today - 2.days)),
        EncryptedMessage.new(@base_attr.merge(delete_at: Date.today - 1.days)),
        EncryptedMessage.new(@base_attr.merge(delete_at: Date.today)),
        EncryptedMessage.new(@base_attr.merge(delete_at: Date.today + 1.days)),
        EncryptedMessage.new(@base_attr.merge(delete_at: Date.today + 2.days)),
      ]

      EncryptedMessage.transaction do
        messages.each do |m|
          m.save(validate: false)
        end

        expect(EncryptedMessage.count).to eq 5
        expect(EncryptedMessage.expired.count).to eq 2
        expect(EncryptedMessage.delete_expired
        expect(EncryptedMessage.count).to eq 3
        expect(EncryptedMessage.expired.count).to eq 0

        EncryptedMessage.delete_all
      end
    end # delete

  end #

end
