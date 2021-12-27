class Fypp < Formula
  include Language::Python::Virtualenv

  desc "Python powered Fortran preprocessor"
  homepage "https://fypp.readthedocs.io/en/stable/"
  url "https://github.com/aradi/fypp/archive/refs/tags/3.1.tar.gz"
  sha256 "0f66e849869632978a8a0623ee510bb860a74004fdabfbfb542656c6c1a7eb5a"
  license "BSD-2-Clause"
  head "https://github.com/aradi/fypp.git", branch: "master"

  bottle do
    root_url "https://github.com/awvwgk/homebrew-fpm/releases/download/fypp-3.1"
    sha256 cellar: :any_skip_relocation, big_sur:  "4df9140ca392b4e246281ef980914d8ba97a5cceb521146de79e6771c35514ba"
    sha256 cellar: :any_skip_relocation, catalina: "0e130c3e46041ef6efe8cbbbbf21b1cd80f21aac2f4901489702e2fd1ea32719"
  end

  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/fypp", "--version"
  end
end
