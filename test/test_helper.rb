class MiniTest::Unit::TestCase

  def fixture(filename)
    File.expand_path "../fixtures/#{filename}", __FILE__
  end

end
