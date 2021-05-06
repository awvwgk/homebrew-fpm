class Fpm < Formula
  desc "Fortran Package Manager (fpm)"
  homepage "https://fpm.fortran-lang.org"
  url "https://github.com/fortran-lang/fpm/releases/download/v0.2.0/fpm-0.2.0.f90"
  sha256 "79d5041f5cebd1adff999017b3b5f88d8814267dbd0faaa0f7c720411ede463e"
  license "MIT"

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
    system fc, *fflags, "fpm-0.2.0.f90", "-o", "fpm"
    bin.install "fpm"
  end

  test do
    system "#{bin}/fpm", "--version"
  end
end
