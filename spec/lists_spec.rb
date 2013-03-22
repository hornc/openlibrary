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
    it { should respond_to(:each) }
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
  before(:all) do
    @entry = {
          "url" => "/people/hornc/lists/OL15227L",
          "full_url" => "/people/george08/lists/OL43L/Top_100_Works_in_World_Literature_(in_progress)",
          "name" => "Top 100 Works in World Literature (in progress)",
          "last_update" => "2010-12-21T04:17:33.140325",
          "seed_count" => 28,
          "edition_count" => 2105
    }
    @single_list = Openlibrary::List.new(@entry)
  end

  context "base List" do
    subject { @single_list }

    it { should be_an_instance_of(Openlibrary::List) }

    it { should respond_to(:url) }
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

  context "list exists" do
    it "should return a url" do
      @single_list.url.should == @entry["url"]
    end

    it "should return a populated name" do
      @single_list.name.should be_an_instance_of(String)
      @single_list.name.should_not be_empty
    end

    it "should return a populated description" do
      @single_list.description.should be_an_instance_of(String)
      @single_list.description.should_not be_empty
    end

    it "should return a populated list of seeds when queried" do
      seeds = @single_list.seeds
      seeds.should_not be_empty
    end
  end
end