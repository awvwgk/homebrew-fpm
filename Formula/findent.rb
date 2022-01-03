class Findent < Formula
  desc "Indents/beautifies/converts Fortran sources"
  homepage "https://sourceforge.net/projects/findent/"
  url "https://downloads.sourceforge.net/project/findent/findent-3.1.7.tar.gz"
  sha256 "42bbf3fd80c14bb44fd18fa73aa53596829f4fb2bacabe57733eb8a9e4f00bb2"
  license "BSD-3-Clause"

  depends_on "bison" => :build
  depends_on "flex" => :build

  def install
    system "./configure", "--prefix=#{prefix}", "--with-flex", "--with-bison"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    system "#{bin}/findent", "--version"
  end
end
