RSpec.describe Checkout do
  let(:ipd_1) { Item.new(:ipd) }
  let(:ipd_2) { Item.new(:ipd) }
  let(:ipd_3) { Item.new(:ipd) }
  let(:ipd_4) { Item.new(:ipd) }
  let(:ipd_5) { Item.new(:ipd) }
  let(:mbp_1) { Item.new(:mbp) }
  let(:atv_1) { Item.new(:atv) }
  let(:atv_2) { Item.new(:atv) }
  let(:atv_3) { Item.new(:atv) }
  let(:vga_1) { Item.new(:vga) }

  subject { described_class.new(DefaultPricingRule.new) }

  describe "#total" do
    context "SKUs Scanned: atv, atv, atv, vga Total expected: $249.00" do
      it "works" do
        subject.scan(atv_1)
        subject.scan(atv_2)
        subject.scan(atv_3)
        subject.scan(vga_1)
        expect(subject.total).to eq 249_00
      end
    end

    context "SKUs Scanned: atv, ipd, ipd, atv, ipd, ipd, ipd Total expected: $2718.95" do
      it "works" do
        subject.scan(atv_1)
        subject.scan(ipd_1)
        subject.scan(ipd_2)
        subject.scan(atv_2)
        subject.scan(ipd_3)
        subject.scan(ipd_4)
        subject.scan(ipd_5)
        expect(subject.total).to eq 2_718_95
      end
    end

    context "mbp, vga, ipd Total expected: $1949.98" do
      it "works" do
        subject.scan(mbp_1)
        subject.scan(vga_1)
        subject.scan(ipd_1)
        expect(subject.total).to eq 1_949_98
      end
    end
  end
end
