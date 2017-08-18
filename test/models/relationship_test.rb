require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:rodion).id,
                                     followed_id: users(:noadmin).id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test "should follow and unfollow a user" do
    rodion = users(:rodion)
    noadmin  = users(:noadmin)
    assert_not rodion.following?(noadmin)
    rodion.follow(noadmin)
    assert rodion.following?(noadmin)
    assert noadmin.followers.include?(rodion)
    rodion.unfollow(noadmin)
    assert_not rodion.following?(noadmin)
  end
end
