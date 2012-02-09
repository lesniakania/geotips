module Tips

  def self.routes
    Raptor.routes(self) do
      root :render => "tips/index", :present => :many
      index
      new
    end
  end

  class PresentsMany
  end

  class PresentsOne
  end

  class Record
    def self.all
    end
  end

end
