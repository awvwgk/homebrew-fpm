class Flang < Formula
  desc "Fortran frontend for LLVM"
  homepage "https://flang.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/flang-13.0.0.src.tar.xz"
  sha256 "13bc580342bec32b6158c8cddeb276bd428d9fc8fd23d13179c8aa97bbba37d5"
  license "Apache-2.0" => { with: "LLVM-exception" }

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "llvm@13"

  def install
    # Apple's libstdc++ is too old to build LLVM
    ENV.libcxx if ENV.compiler == :clang

    cmake_args = std_cmake_args
    cmake_args << "-DLLVM_ENABLE_LLD=ON" if ENV.compiler == :clang
    cmake_args << "-DLLVM_ENABLE_ASSERTIONS=OFF"
    cmake_args << "-DLLVM_ENABLE_THREADS=ON"
    cmake_args << "-DLLVM_LINK_LLVM_DYLIB=ON"

    system "cmake", *cmake_args, "-GNinja", "-Bbuild", "-Wno-dev"
    system "cmake", "--build", "build"
    begin
      system "cmake", "--build", "build", "--", "check-flang"
    rescue RuntimeError
      nil
    end
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/flang", "--version"
    (testpath/"hello.f90").write <<~EOS
      program hello
        print *, "Hello, World!"
      end
    EOS
    system "#{bin}/flang", testpath/"hello.f90", "-o", testpath/"hello"
    assert_predicate testpath/"hello", :exist?
    system testpath/"hello"
  end
end
