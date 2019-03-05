RSpec.describe DefaultPricingRules do
  let(:atv_1) { Item.new(:atv) }
  let(:atv_2) { Item.new(:atv) }
  let(:atv_3) { Item.new(:atv) }
  let(:atv_4) { Item.new(:atv) }
  let(:atv_5) { Item.new(:atv) }
  let(:atv_6) { Item.new(:atv) }
  let(:ipd_1) { Item.new(:ipd) }
  let(:ipd_2) { Item.new(:ipd) }
  let(:ipd_3) { Item.new(:ipd) }
  let(:ipd_4) { Item.new(:ipd) }
  let(:mbp_1) { Item.new(:mbp) }
  let(:mbp_2) { Item.new(:mbp) }
  let(:vga_1) { Item.new(:vga) }
  let(:vga_2) { Item.new(:vga) }

  subject { described_class.new }
  before { subject.account_for(item_array) }

  describe "#account_for" do
    context "when the sales requirement is not met" do
      let(:item_array) { ItemArray.new([ipd_1, atv_1, vga_1].shuffle) }

      it "sets the default prices" do
        expect(item_array.map(&:accounted_for?)).to all be_truthy
        expect(item_array.map(&:price)).to match_array([30_00, 109_50, 549_99])
      end
    end

    context "when the free apple tv rule applies" do
      let(:item_array) { ItemArray.new([atv_1, atv_2, atv_3].shuffle) }

      it "sets the default prices" do
        expect(item_array.map(&:accounted_for?)).to all be_truthy
        expect(item_array.map(&:price)).to match_array([109_50, 109_50, 0])
      end
    end

    context "when the free vga rule applies" do
      let(:item_array) { ItemArray.new([mbp_1, vga_1, atv_3].shuffle) }

      it "sets the default prices" do
        expect(item_array.map(&:accounted_for?)).to all be_truthy
        expect(item_array.map(&:price)).to match_array([1_399_99, 109_50, 0])
      end
    end

    context "when the minimum 4 ipad rule applies" do
      let(:item_array) { ItemArray.new([mbp_1, ipd_1, ipd_2, ipd_3, ipd_4].shuffle) }

      it "sets the default prices" do
        expect(item_array.map(&:accounted_for?)).to all be_truthy
        expect(item_array.map(&:price)).to match_array([1_399_99, 499_99, 499_99, 499_99, 499_99])
      end
    end

    context "when the free vga rule applies twice" do
      let(:item_array) { ItemArray.new([mbp_1, vga_1, mbp_2, vga_2].shuffle) }

      it "sets the default prices" do
        expect(item_array.map(&:accounted_for?)).to all be_truthy
        expect(item_array.map(&:price)).to match_array([1_399_99, 1_399_99, 0, 0])
      end
    end

    context "when the free apple tv rule applies twice" do
      let(:item_array) { ItemArray.new([atv_1, atv_2, atv_3, atv_4, atv_5, atv_6].shuffle) }

      it "sets the default prices" do
        expect(item_array.map(&:accounted_for?)).to all be_truthy
        expect(item_array.map(&:price)).to match_array([0, 0, 109_50, 109_50, 109_50, 109_50])
      end
    end
  end
end
