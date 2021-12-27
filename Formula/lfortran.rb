class Lfortran < Formula
  desc "Modern interactive LLVM-based Fortran compiler"
  homepage "https://lfortran.org"
  url "https://lfortran.github.io/tarballs/release/lfortran-0.14.0.tar.gz"
  sha256 "fc3c1d592c56ae2636065ec0228db747f154f65a0867f6311bc8091efd5c13a7"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/awvwgk/homebrew-fpm/releases/download/lfortran-0.14.0"
    sha256 cellar: :any, big_sur:  "62887d014d1dce8cda6ed56bea8e99944b192c34fb686699f307771379c6a277"
    sha256 cellar: :any, catalina: "61755f1a198de4096d715c507a3845a76e94f0dcbaf9674c4418edde6494128e"
  end

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
