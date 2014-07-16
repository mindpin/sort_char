module SortChar
  module Owner
    def self.included(base)
      base.extend ClassMethods
    end

    def __scope_items
      if self.class.sort_char_scope.blank?
        return self.class.order("position asc").all
      end

      self.send(self.class.sort_char_scope)
        .send(self.class.name.split("::").last.downcase.pluralize)
        .order("position asc").all
    end

    def _set_position_value
      obj = __scope_items.last
      if obj.blank?
        self.position = SortChar::Generator.g(nil, nil)
      else
        self.position = SortChar::Generator.g(obj.position, nil)
      end
    end

    def insert_at(left_position, right_position)
      if !left_position.blank?
        item = __scope_items.where(:position => left_position).last
        raise DataItem::UnKnownPositionError.new if item.blank?
      end
      
      if !right_position.blank?
        item = __scope_items.where(:position => right_position).last
        raise DataItem::UnKnownPositionError.new if item.blank?
      end
      self.position = SortChar::Generator.g(left_position, right_position)
      self.save
    end

    module ClassMethods
      # sort_char :scope => :todo_list
      def sort_char(options)
        field :position, :type => String
        default_scope ->{order("position asc")}
        self.instance_variable_set(:@sort_char_scope, options[:scope])
        if !sort_char_scope.blank?
          belongs_to sort_char_scope
        end
        before_create :_set_position_value
      end

      def sort_char_scope
        self.instance_variable_get(:@sort_char_scope) || nil
      end

    end
  end
end