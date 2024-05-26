require "test_helper"

class WatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
 

  def setup
    @watch = Watch.new(
      name: 'Rolex GMT-Master', 
      description: 'Men\'s Rolex GMT-Master Stainless Steel 40mm Black Dial Pepsi Bezel Watch',
      category: 'premium+',
      price: "46 268,00",
      url: "https://www.chrono24.pl/rolex/rolex-gmt-master-pepsi-bezel-40mm-1989--id26694476.htm?searchHash=6ab41804_uAEvUy&pos=15"
    )
  end

  test 'valid watch' do
    assert @watch.valid?
  end

  test 'invalid without name' do
    @watch.name = nil
    refute @watch.valid?, @watch.errors[:name]
  end

  test 'invalid without category' do
    @watch.category = nil
    refute @watch.valid?, @watch.errors[:category]
  end

  test 'invalid category' do
    @watch.category = 'superfalse'
    refute @watch.valid?, 'Category passed with wrong name'
  end

  test 'invalid without price' do
    @watch.price = nil
    refute @watch.valid?, @watch.errors[:price]
  end
  
end
