class Lfortran < Formula
  desc "Modern interactive LLVM-based Fortran compiler"
  homepage "https://lfortran.org"
  url "https://lfortran.github.io/tarballs/release/lfortran-0.14.0.tar.gz"
  sha256 "fc3c1d592c56ae2636065ec0228db747f154f65a0867f6311bc8091efd5c13a7"
  license "BSD-3-Clause"
  revision 1

  bottle do
    root_url "https://github.com/awvwgk/homebrew-fpm/releases/download/lfortran-0.14.0_1"
    sha256 cellar: :any, big_sur:  "e05cfad4c21c3dca5308ff7eb0e689c2479114b89550b054f954c8a06c18e777"
    sha256 cellar: :any, catalina: "b6522d92bd8d861aad0146cf5076db90208bd2670ecf5c8bb62d809211db1b8d"
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "llvm@11"
  depends_on "zlib"

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DCMAKE_CXX_FLAGS_RELEASE=-O3 -funroll-loops -DNDEBUG"
    cmake_args << "-DWITH_LLVM=ON"
    system "cmake", *cmake_args, "-G", "Ninja", "-B", "build"
    system "cmake", "--build", "build"
    system "ctest", "--test-dir", "build", "--output-on-failure"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/lfortran", "--version"
    (testpath/"hello.f90").write <<~EOS
      program hello
        print *, "Hello, World!"
      end
    EOS
    system "#{bin}/lfortran", testpath/"hello.f90", "-o", testpath/"hello"
    assert_predicate testpath/"hello", :exist?
    system testpath/"hello"
  end
end
