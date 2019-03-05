RSpec.describe ItemArray do
  let(:ipd_1) { Item.new(:ipd) }
  let(:ipd_2) { Item.new(:ipd) }
  let(:mbp) { Item.new(:mbp) }
  let(:atv) { Item.new(:atv) }
  let(:vga) { Item.new(:vga) }
  subject { described_class.new([ipd_1, ipd_2, mbp, atv].shuffle) }

  describe "#include_all?" do
    it "returns true when the keys are exatly like the items array" do
      expect(subject.include_all?([:ipd, :ipd, :mbp, :atv].shuffle)).to be_truthy
    end

    it "returns true when the keys contain the items array" do
      expect(subject.include_all?([:ipd, :ipd, :atv].shuffle)).to be_truthy
    end

    it "returns true when the keys doesn't contain the items array" do
      expect(subject.include_all?([:ipd, :ipd, :ipd, :atv].shuffle)).to be_falsy
      expect(subject.include_all?([:ipd, :vga, :atv].shuffle)).to be_falsy
    end
  end

  describe "#eject" do
    it "returns an empty array when the keys are exatly like the items array" do
      expect(subject.eject([:ipd, :ipd, :mbp, :atv].shuffle)).to be_empty
    end

    it "returns an empty array when the keys are exatly like the items array" do
      expect(subject.eject([:ipd, :ipd, :ipd, :mbp, :atv, :atv].shuffle)).to be_empty
    end

    it "returns the correct array when the keys contain the items array" do
      expect(subject.eject([:ipd, :ipd, :atv].shuffle).map(&:key)).to match_array([:mbp])
    end

    it "returns the correct array when the keys doesn't contain the items array" do
      expect(subject.eject([:ipd, :ipd, :ipd, :atv].shuffle).map(&:key)).to match_array([:mbp])
      expect(subject.eject([:ipd, :vga, :atv].shuffle).map(&:key)).to match_array([:ipd, :mbp])
    end
  end

  describe "#intersection" do
    it "returns the correct array when the keys are exatly like the items array" do
      expect(subject.intersection([:ipd, :ipd, :mbp, :atv].shuffle).map(&:key)).to match_array([:ipd, :ipd, :mbp, :atv])
    end

    it "returns the correct array when the keys contain the items array" do
      expect(subject.intersection([:ipd, :ipd, :atv].shuffle).map(&:key)).to match_array([:ipd, :ipd, :atv])
      expect(subject.intersection([:atv]).map(&:key)).to match_array([:atv])
    end

    it "returns the correct array when the keys doesn't contain the items array" do
      expect(subject.intersection([:ipd, :ipd, :ipd, :atv].shuffle).map(&:key)).to match_array([:ipd, :ipd, :atv])
      expect(subject.intersection([:ipd, :vga, :atv].shuffle).map(&:key)).to match_array([:ipd, :atv])
    end
  end
end
