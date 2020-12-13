require 'rails_helper'

RSpec.describe Shop, type: :model do
  it { should have_many(:books) }
  it { should have_many(:stock) }
end
