require './wallet'

RSpec.describe Wallet do
  it do 
    w1 = Wallet.new
    message = 'foobar'
    signature = w1.sign(message)
    puts signature
    expect(verify_signature(w1.address, message, signature)).to be true
  end
end