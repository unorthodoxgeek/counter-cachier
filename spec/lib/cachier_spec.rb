require "spec_helper"

describe CounterCachier::Cachier do
  
  describe :cachier do

    let :cachier do
      CounterCachier::Cachier.new(:foo){ |bar| 10 * bar}
    end

    it "should save a block for recalculation" do
      cachier.recalc(4).should == 40
    end

    it "should write the counter cache to the store" do
      CounterCachier.should_receive(:write)
      cachier.write(4)
    end
  end

end