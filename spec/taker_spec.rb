require 'spec_helper'

describe Taker do
  it { should belong_to :survey }
  it { should belong_to :response }
end
