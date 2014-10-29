require 'spec_helper'

describe "Kid - Instance Methods"
  describe "#pig_out" do
    before(:each) do
      # make the kid a bucket
      @pail = Bucket.create(:kid_id => kid.id)

      # add 10 candies to the bucket
      candy_array.each do |candy_hash|
        candy_hash[:bucket_id] = @pail.id
        c = Candy.create(candy_hash)
      end
    end

    it "eats the one of candy when given in the argument of 1" do
      original_num = kid.bucket.candies.count
      kid.pig_out(1)
      found_kid = Kid.find_by(:name => "Stephanie")
      expect(found_kid.bucket.candies.count).to eq(original_num - 1)
    end

    it "eats the four candies when given in the argument of 4" do
      original_num = kid.bucket.candies.count
      kid.pig_out(4)
      found_kid = Kid.find_by(:name => "Stephanie")
      expect(found_kid.bucket.candies.count).to eq(original_num - 4)
    end

    it "gets happy when eating one or two candies" do
      kid.pig_out(1)
      found_kid = Kid.find_by(:name => "Stephanie")
      expect(found_kid.feeling).to eq("Happy")

      kid.update(:feeling => nil)

      kid.pig_out(2)
      found_kid = Kid.find_by(:name => "Stephanie")
      expect(found_kid.feeling).to eq("Happy")
    end

    it "gets sick if they eat three or more candies" do
      kid.pig_out(3)
      found_kid = Kid.find_by(:name => "Stephanie")
      expect(found_kid.feeling).to eq("Sick")

      kid.update(:feeling => nil)

      kid.pig_out(4)
      found_kid = Kid.find_by(:name => "Stephanie")
      expect(found_kid.feeling).to eq("Sick")
    end

  end

end
