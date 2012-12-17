require "spec_helper"
class Dummy
  include CounterCachier
  def id
    4
  end

  def baz
    10
  end

  counter_cachier :foo do |foo|
    foo.baz
  end
end

describe CounterCachier::Mounter do
  let(:dummy) {Dummy.new}
  describe "class methods" do
    it "should have cachiers accessor" do
      Dummy.should respond_to :cachiers
    end

    it "should call later if later specified" do
      Dummy.should_receive(:later).with("recalc_bar", queue: :bar)

      Dummy.counter_cachier :bar, async: true, queue: :bar do
        10
      end
    end
  end

  describe "instance methods" do
    it "should respond to foo" do
      dummy.should respond_to(:foo)
    end

    it "should respond to recalc_foo" do
      dummy.should respond_to(:recalc_foo)
    end

    it "should run the block when calling recalc_foo" do
      CounterCachier.redis.should_receive :set
      dummy.recalc_foo.should == 10
    end
  end
end