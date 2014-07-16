# SortChar

mongoid model 排序插件

## 安装

```ruby
# Gemfile
gem 'sort_char', 
  :git => 'git://github.com/mindpin/sort_char.git',
  :tag => '0.0.1'
```

## 使用举例
```ruby
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, :type => String
    has_many :books
  end
```

```ruby
  class Book
    include Mongoid::Document
    include Mongoid::Timestamps
    include SortChar::Owner

    field :name, :type => String
    sort_char :scope => :user
  end
```

```ruby
user = User.create!(:name => "user")
book1 = user.books.create!(:name => "book1")
book2 = user.books.create!(:name => "book2")
book3 = user.books.create!(:name => "book3")

user1.books.map(&:name) # => ["book1", "book2", "book3"]

book3.insert_at(book1.position, book2.position)
user1.reload

user1.books.map(&:name) # => ["book1", "book3", "book2"]
```
