require 'acts_as_votable'
require 'spec_helper'

describe ActsAsVotable::Votable do

  before(:each) do
    clean_database
  end

  describe "voting on a votable object" do

    before(:each) do
      clean_database
      @voter = Voter.new(:name => 'i can vote!')
      @voter.save

      @voter2 = Voter.new(:name => 'a new person')
      @voter2.save

      @votable = Votable.new(:name => 'a voting model')
      @votable.save
    end

    it "should vote with liked_by and disliked_by" do
      @votable.liked_by @voter
      @votable.find_votes.count.should == 1

      @votable.liked_by @voter2
      @votable.find_votes.count.should == 2
    end

    it "should unvote with unliked_by and undisliked_by" do
      @votable.liked_by @voter
      @votable.find_votes.count.should == 1
      @votable.unliked_by @voter
      @votable.find_votes.count.should == 0

      @votable.disliked_by @voter
      @votable.find_votes.count.should == 1
      @votable.undisliked_by @voter
      @votable.find_votes.count.should == 0
    end

  end

end
