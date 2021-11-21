class Fpm < Formula
  desc "Fortran Package Manager (fpm)"
  homepage "https://fpm.fortran-lang.org"
  url "https://github.com/fortran-lang/fpm/releases/download/v0.5.0/fpm-0.5.0.zip"
  sha256 "e4a06956d2300f9aa1d06bd3323670480e946549617582e32684ded6921a921e"
  license "MIT"

  bottle do
    root_url "https://github.com/awvwgk/homebrew-fpm/releases/download/fpm-0.4.0"
    sha256 cellar: :any, catalina: "3f39ca08f36badaf46b18e2e5f21909efe7cb49554f0d1aef52a21a076bf1887"
  end

  depends_on "curl" => :build
  depends_on "gcc" # for gfortran
  fails_with gcc: "4"
  fails_with gcc: "5"
  fails_with gcc: "6"
  fails_with :clang

  def install
    # ENV.fc is not defined and setting it up with ENV.fortran will yield default gfortran
    ENV["FC"] = ENV.cc.gsub(/gcc/, "gfortran")
    # Compile arguments need some tweaking
    system "./install.sh", "--prefix=#{prefix}"
  end

  test do
    system "#{bin}/fpm", "--version"
  end
end
