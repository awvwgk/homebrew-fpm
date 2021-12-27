class FpmSearch < Formula
  desc "List available packages in the fpm-registry"
  homepage "https://github.com/brocolis/fpm-search"
  url "https://github.com/brocolis/fpm-search/archive/refs/tags/v0.18.0.tar.gz"
  sha256 "1f60212171119454970ee84af7554b762946fbaffc0cff8186c50378e4e64276"
  license "MIT"

  bottle do
    root_url "https://github.com/awvwgk/homebrew-fpm/releases/download/fpm-search-0.18.0"
    sha256 cellar: :any, big_sur:  "0604372deca21d2ad8861ad2e24307ae6456b22b1a7e7c4b6d602b1db349adbd"
    sha256 cellar: :any, catalina: "e29a8340bb467c130595e31907467f304570b310bf467a68b3b7b2a23ce682dc"
  end

  depends_on "curl"
  depends_on "fpm"
  depends_on "gcc" # for gfortran
  fails_with gcc: "4"
  fails_with gcc: "5"
  fails_with gcc: "6"
  fails_with :clang

  def install
    # ENV.fc is not defined and setting it up with ENV.fortran will yield default gfortran
    ENV["FC"] = ENV.cc.gsub(/gcc/, "gfortran")
    system "fpm", "install", "--profile=release", "--prefix=#{prefix}"
  end

  test do
    system "fpm", "search", "--version"
    system "fpm", "search", "--help"
  end
end
