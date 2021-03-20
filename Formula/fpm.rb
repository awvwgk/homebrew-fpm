class Fpm < Formula
  desc "Fortran Package Manager (fpm)"
  homepage "https://fpm.fortran-lang.org"
  url "https://github.com/fortran-lang/fpm/releases/download/v0.1.4/fpm-0.1.4.f90"
  sha256 "06c139b16cf871e06cd3ea3be93c1ddbb5a94e4546a0c64822d10dc87333ac0c"
  license "MIT"

  depends_on "gcc" # for gfortran
  fails_with :gcc => "4"
  fails_with :gcc => "5"
  fails_with :gcc => "6"
  fails_with :clang

  def install
    # ENV.fc is not defined and setting it up with ENV.fortran will yield default gfortran
    ENV["FC"] = ENV.cc.gsub /gcc/, "gfortran"
    # Compile arguments need some tweaking
    system ENV["FC"], "fpm-0.1.4.f90", "-o", "fpm"
    bin.install "fpm"
  end

  test do
    system "#{bin}/fpm", "--version"
  end
end
