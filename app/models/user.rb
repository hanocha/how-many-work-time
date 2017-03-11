class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  before_save :encrypt_code
  attr_writer :code

  CIPHER = 'aes-256-cbc'

  def code
    decrypt(encrypted_code) if encrypted_code
  end

  def encrypt_code
    self.encrypted_code = encrypt(@code)
  end

  private

  def encrypt(str)
    crypter = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.crypter_key , cipher: CIPHER)
    crypter.encrypt_and_sign(str)
  end

  def decrypt(str)
    crypter = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.crypter_key , cipher: CIPHER)
    crypter.decrypt_and_verify(str)
  end
end
