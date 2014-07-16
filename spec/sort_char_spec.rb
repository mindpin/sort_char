require 'spec_helper'

module A
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, :type => String
    has_many :books
  end

  class Book
    include Mongoid::Document
    include Mongoid::Timestamps
    include SortChar::Owner

    field :name, :type => String
    sort_char :scope => :user
  end
end


describe SortChar::Owner do
  before{
    @user1 = A::User.create!(:name => "user1")
    @user2 = A::User.create!(:name => "user2")

    @user1book1 = @user1.books.create!(:name => "user1book1")
    @user1book2 = @user1.books.create!(:name => "user1book2")
    @user1book3 = @user1.books.create!(:name => "user1book3")
  }
  specify {
    expect(@user1.books.map(&:name)).to eq(["user1book1", "user1book2", "user1book3"])
  }

  describe 'insert_at old' do
    before{
      @user1book3.insert_at(@user1book1.position, @user1book2.position)
      @user1book3.reload
      @user1.reload
    }

    specify {
      expect(@user1.books.map(&:name)).to eq(["user1book1", "user1book3", "user1book2"])   
    }

    describe 'insert_at new' do
      before{
        @user1book4 = @user1.books.create!(:name => "user1book4")
        @user1book4.insert_at(@user1book3.position, @user1book2.position)
        @user1book4.reload
        @user1.reload
      }

      specify {
        expect(@user1.books.map(&:name)).to eq(["user1book1", "user1book3", "user1book4", "user1book2"])
      }      
    end
  end
end
