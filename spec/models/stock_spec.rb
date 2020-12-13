require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should belong_to(:shop) }
  it { should belong_to(:book) }
end
