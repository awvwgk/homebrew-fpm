class Lfortran < Formula
  desc "Modern interactive LLVM-based Fortran compiler"
  homepage "https://lfortran.org"
  url "https://lfortran.github.io/tarballs/release/lfortran-0.14.0.tar.gz"
  sha256 "fc3c1d592c56ae2636065ec0228db747f154f65a0867f6311bc8091efd5c13a7"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "llvm@11"
  depends_on "zlib"

  def install
    system "cmake", *std_cmake_args, "-G", "Ninja", "-B", "build"
    system "cmake", "--build", "build"
    system "ctest", "--test-dir", "build", "--output-on-failure"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/lfortran", "--version"
  end
end
