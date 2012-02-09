module Tips

  def self.routes
    Raptor.routes(self) do
      root :render => "new", :present => :one
    end
  end

  class PresentsMany
  end

  class PresentsOne
  end

end
