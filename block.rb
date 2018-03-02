require 'pp'
require 'digest'

class Block

  attr_reader :index, :timestamp, :data, :previous_hash, :hash

  def initialize(data, previous_block=nil)
    @index = previous_block ? previous_block.index+1 : 0
    @data = data
    @timestamp = Time.now
    @previous_hash = previous_block ? previous_block.hash : '0'
    @hash = calc_hash
  end

  def self.first(data='Genesis')
    Block.new(data)
  end

  def self.next(previous_block, data='')
    Block.new(data, previous_block)
  end

  def calc_hash
    sha256 = Digest::SHA256.new
    sha256.hexdigest(@data + @timestamp.to_s + @previous_hash + @index.to_s)
  end

end

b0 = Block.first
b1 = Block.next( b0, "Transaction Data..." )
b2 = Block.next( b1, "Transaction Data......" )
b3 = Block.next( b2, "More Transaction Data..." )

blockchain = [b0, b1, b2, b3]

pp blockchain

######
#  will pretty print (pp) something like:
#
# [#<Block:0x1eed2a0
#   @data="Genesis",
#   @hash="edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b",
#   @index=0,
#   @previous_hash="0",
#   @timestamp=2017-09-15 20:52:38 +0200>,
#  #<Block:0x1eec9a0
#   @data="Transaction Data...",
#   @hash="eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743",
#   @index=1,
#   @previous_hash="edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b",
#   @timestamp=2017-09-15 20:52:38 +0200>,
#  #<Block:0x1eec838
#   @data="Transaction Data......",
#   @hash="be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4",
#   @index=2,
#   @previous_hash="eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743",
#   @timestamp=2017-09-15 20:52:38 +0200>,
#  #<Block:0x1eec6d0
#   @data="More Transaction Data...",
#   @hash="5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d",
#   @index=3,
#   @previous_hash="be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4",
#   @timestamp=2017-09-15 20:52:38 +0200>]