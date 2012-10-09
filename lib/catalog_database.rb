class Catalog

  # Create a catalog view that combines book and transactions

  def self.get_catalog
    @catalog = Book.includes(:transactions)
    return @catalog
  end
end
