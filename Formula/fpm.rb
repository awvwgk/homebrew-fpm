class Fpm < Formula
  desc "Fortran Package Manager (fpm)"
  homepage "https://fpm.fortran-lang.org"
  url "https://github.com/fortran-lang/fpm/releases/download/v0.3.0/fpm-0.3.0.F90"
  sha256 "a0670253a27a8b3745e694279d1c5feacbb111a932537c5932edde0c0f3ffa8b"
  license "MIT"

  bottle do
    root_url "https://github.com/awvwgk/homebrew-fpm/releases/download/fpm-0.3.0"
    sha256 cellar: :any, catalina: "eff695480a2406e2af14146000812467ce561cab465eeb848292372b672be1a7"
  end

  depends_on "gcc" # for gfortran
  fails_with gcc: "4"
  fails_with gcc: "5"
  fails_with gcc: "6"
  fails_with :clang

  def install
    # ENV.fc is not defined and setting it up with ENV.fortran will yield default gfortran
    fc = ENV.cc.gsub(/gcc/, "gfortran")
    fflags = ["-g", "-fbacktrace", "-O3"]
    # Compile arguments need some tweaking
    system fc, *fflags, "fpm-0.3.0.F90", "-o", "fpm"
    bin.install "fpm"
  end

  test do
    system "#{bin}/fpm", "--version"
  end
end
