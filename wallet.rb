require 'openssl'

class Wallet

  def initialize
    @private_key = OpenSSL::PKey::RSA.new(2048)
    @public_key = @private_key.public_key
  end

  def address
    @public_key.to_s
  end

  def sign(message)
    digest = OpenSSL::Digest::SHA256.new
    @private_key.sign(digest, message)
  end

end

def verify_signature(wallet_address, message, signature)
  public_key = OpenSSL::PKey::RSA.new(wallet_address)
  digest = OpenSSL::Digest::SHA256.new
  public_key.verify(digest, signature, message) 
end