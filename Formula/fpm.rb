class Fpm < Formula
  desc "Fortran Package Manager (fpm)"
  homepage "https://fpm.fortran-lang.org"
  url "https://github.com/fortran-lang/fpm/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "6c1574273164f859591547b7aae3b2d39471cf8a1d901cf1e453e607fbe9757a"
  license "MIT"

  bottle do
    root_url "https://github.com/awvwgk/homebrew-fpm/releases/download/fpm-0.3.0"
    sha256 cellar: :any, catalina: "eff695480a2406e2af14146000812467ce561cab465eeb848292372b672be1a7"
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
