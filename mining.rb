require 'digest'

def dumb_hash(message)
  Digest::SHA256.hexdigest(message)
end

def mine(message, difficulty=1)
  raise 'Difficulty cannot be less than 1' if difficulty < 1
  i = 0
  prefix = '1' * difficulty
  puts "Mining message '#{message}' with difficulty of #{difficulty}..."
  loop do
    nounce = i.to_s
    digest = dumb_hash(message + nounce)
    if digest.start_with?(prefix)
      puts "Took #{i} iterations. Nouce: #{nounce}"
      return nounce
    end
    i += 1
  end
end

mine('hello', 1)
mine('hello', 2)
mine('hello', 3)
mine('hello', 4)