require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should belong_to(:publisher) }
  it { should have_many(:shops) }
  it { should have_many(:stock) }
end
