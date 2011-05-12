class Hash
  def deep_merge(tree)
    merger = proc { |key,v1,v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    self.merge(tree, &merger)
  end
end

class HashStorage

  def initialize
    @opts = {}
  end

  def add options
    tree = Hash.new { |h,k| h[k] = Hash.new(&tree.default_proc) }
    tree = options

    @opts = @opts.deep_merge tree
  end

  def to_s
    @opts.to_json
  end

end

module HashStorageHelpers
  def add_jsvars options
    @hash_storage ||= HashStorage.new
    @hash_storage.add options
  end

  def return_jsvars prefix = nil
    if @hash_storage
      if prefix
        content_tag :script, :type => "text/javascript" do
          "#{prefix} = #{raw @hash_storage.to_s};".html_safe
        end
      else
        @hash_storage.to_s
      end
    end
  end
end

::ActionView::Base.send(:include, HashStorageHelpers)
