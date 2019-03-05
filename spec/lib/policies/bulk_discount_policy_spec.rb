RSpec.describe BulkDiscountPolicy do
  let(:atv_1) { Item.new(:atv).tap { |i| i.default_price = 100_00 } }
  let(:atv_2) { Item.new(:atv).tap { |i| i.default_price = 100_00 } }
  let(:atv_3) { Item.new(:atv).tap { |i| i.default_price = 100_00 } }
  let(:atv_4) { Item.new(:atv).tap { |i| i.default_price = 100_00 } }
  let(:atv_5) { Item.new(:atv).tap { |i| i.default_price = 100_00 } }
  let(:ipd_1) { Item.new(:ipd).tap { |i| i.default_price = 100_00 } }
  let(:mbp_1) { Item.new(:mbp).tap { |i| i.default_price = 100_00 } }
  let(:vga_1) { Item.new(:vga).tap { |i| i.default_price = 100_00 } }

  # in this test if you buy three atvs you'll get them for $70 instead of $100
  subject { described_class.new(item_key: :atv, minimum_quantity: 3, discount_price: 70_00) }
  before { subject.apply(item_array) }

  describe "#apply" do
    context "when the sales requirement is not met" do
      let(:item_array) { ItemArray.new([ipd_1, mbp_1, atv_1, vga_1].shuffle) }

      it "doesn't do anything" do
        expect(item_array.map(&:accounted_for?)).to all be_falsey
        expect(item_array.map(&:price)).to all be_nil
      end
    end

    context "when exactly matching the policy" do
      let(:item_array) { ItemArray.new([atv_1, atv_2, atv_3, vga_1].shuffle) }

      it "applies the discount" do
        expect(item_array.filter(&:accounted_for?).size).to eq 3
        expect(item_array.filter { |i| i.price == 70_00 }.size).to eq 3
        expect(item_array.filter { |i| i.price.nil? }.size).to eq 1
      end
    end

    context "when more than minimun requirement" do
      let(:item_array) { ItemArray.new([atv_1, atv_2, atv_3, vga_1, atv_4, mbp_1].shuffle) }

      it "applies the discount" do
        expect(item_array.filter(&:accounted_for?).size).to eq 4
        expect(item_array.filter { |i| i.price == 70_00 }.size).to eq 4
        expect(item_array.filter { |i| i.price.nil? }.size).to eq 2
      end
    end
  end
end
