module Tips

  def self.routes
    Raptor.routes(self) do
      root :render => "root", :present => :many
    end
  end

  class PresentsMany
  end

end
