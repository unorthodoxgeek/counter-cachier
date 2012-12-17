require "spec_helper"
Redis ||= Class.new

describe CounterCachier do
  let(:a){double(id: 1, class: "Foo")}
  let(:b){double(id: 2, class: "Bar")}
  let(:cachier){double(name: "foo")}

  before :each do
    Redis.stub!(:new).and_return(double)
  end
  
  describe :write do
    it "should write the new counter cache" do
      CounterCachier.redis.should_receive(:set)
      CounterCachier.write(a, :b, 4)
    end
  end

  describe :read do
    it "should read the counter cache" do
      CounterCachier.redis.should_receive(:get).and_return(1)
      CounterCachier.read(a, cachier)
    end

    it "should recalc the counter cache if the read yields nil" do
      CounterCachier.redis.should_receive(:get)
      cachier.should_receive(:write).and_return(5)
      CounterCachier.read(a, cachier).should == 5
    end
  end

  describe :key do
    it "should return a string" do
      CounterCachier.key(a, :a).should be_a String
    end

    it "should return a valid unique key for each object" do
      CounterCachier.key(a, :a).should_not == CounterCachier.key(b, :a)
    end
  end

end