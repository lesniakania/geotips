module Tips

  def self.routes
    Raptor.routes(self) do
      root :text => ""
    end
  end

end
