require 'spec_helper'

describe Openlibrary::Lists do
  # TODO: List is easy, I'm having trouble with the collection of Lists obtained from a Person or Seed
  # -- should lists be returned from a Person or Seed class?
  # TODO: is there a better way than testing with live users?
 
  context "base lists collection" do
    subject { Openlibrary::Lists.new }
    it { should respond_to(:entries) }
    it { should respond_to(:links) }
    it { should respond_to(:size) }
    #it { should respond_to(:each) }
    it "should respon to method 'each'" do
      pending "Need to make Lists an Enumerable"
    end
  end
   
  context "user has lists" do
    before { @lists = Openlibrary::Lists.find_by_user('hornc') }
    it "should have attributes of the correct types" do
      @lists.entries.should be_an_instance_of(Array)
      @lists.size.should be_an_instance_of(Fixnum)
      @lists.links.should be_an_instance_of(Hash)
    end

    it "should have (size) entries" do
      @lists.entries.size.should == @lists.size
    end
  end

  context "user does not exist" do
    subject { Openlibrary::Lists.find_by_user('this_is_a_non_existant_user') }
    it {should be_nil}
  end

  context "user has no lists" do
    before { @no_lists = Openlibrary::Lists.find_by_user('Roxy8') }
    it "should have size 0" do
      @no_lists.size.should be 0
      @no_lists.entries.size.should be 0
    end
  end

  describe ".find_by_user" do
  	  subject { Openlibrary::Lists.find_by_user('hornc') }
      it { should be_an_instance_of(Openlibrary::Lists) }
  end

  describe ".find_by_seed" do
  	  subject { Openlibrary::Lists.find_by_seed('some_seed') }
  	  it "should return a Lists collection"
      # it { should be_an_instance_of(Openlibrary::Lists) }
  end
end

describe Openlibrary::List do
  before do
    @single_list = Openlibrary::List.new
  end

  subject { @single_list }

  it { should respond_to(:links) }
  it { should respond_to(:meta) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:seed_count) }
  it { should respond_to(:edition_count) }

  it { should respond_to(:seeds) } 
  it { should respond_to(:editions) }
  it { should respond_to(:subjects) }
end