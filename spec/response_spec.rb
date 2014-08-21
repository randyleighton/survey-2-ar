require 'spec_helper'

describe Response do
  it { should belong_to :choice}
  it { should belong_to :question}
  it { should have_many :takers}
end
