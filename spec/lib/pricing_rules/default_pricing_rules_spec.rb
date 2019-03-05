RSpec.describe DefaultPricingRules do
  let(:atv_1) { Item.new(:atv) }
  let(:atv_2) { Item.new(:atv) }
  let(:atv_3) { Item.new(:atv) }
  let(:atv_4) { Item.new(:atv) }
  let(:atv_5) { Item.new(:atv) }
  let(:ipd_1) { Item.new(:ipd) }
  let(:ipd_2) { Item.new(:ipd) }
  let(:ipd_3) { Item.new(:ipd) }
  let(:ipd_4) { Item.new(:ipd) }
  let(:mbp_1) { Item.new(:mbp) }
  let(:vga_1) { Item.new(:vga) }

  subject { described_class.new }
  let(:results) { subject.account_for(item_array) }

  describe "#account_for" do
    context "when the sales requirement is not met" do
      let(:item_array) { ItemArray.new([ipd_1, atv_1, vga_1].shuffle) }

      it "sets the default prices" do
        expect(results.size).to eq 3
        expect(results.map(&:accounted_for?)).to all be_truthy
        expect(results.map(&:price)).to match_array([30_00, 109_50, 549_99])
      end
    end

    context "when the free apple tv rule applies" do
      let(:item_array) { ItemArray.new([atv_1, atv_2, atv_3].shuffle) }

      it "sets the default prices" do
        expect(results.size).to eq 3
        expect(results.map(&:accounted_for?)).to all be_truthy
        expect(results.map(&:price)).to match_array([109_50, 109_50, 0])
      end
    end

    context "when the free vga rule applies" do
      let(:item_array) { ItemArray.new([mbp_1, vga_1, atv_3].shuffle) }

      it "sets the default prices" do
        expect(results.size).to eq 3
        expect(results.map(&:accounted_for?)).to all be_truthy
        expect(results.map(&:price)).to match_array([1_399_99, 109_50, 0])
      end
    end

    context "when the minimum 4 ipad rule applies" do
      let(:item_array) { ItemArray.new([mbp_1, ipd_1, ipd_2, ipd_3, ipd_4].shuffle) }

      it "sets the default prices" do
        expect(results.size).to eq 5
        expect(results.map(&:accounted_for?)).to all be_truthy
        expect(results.map(&:price)).to match_array([1_399_99, 499_99, 499_99, 499_99, 499_99])
      end
    end
  end
end
