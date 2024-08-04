class HicolorIconTheme < Formula
  desc "Fallback theme for FreeDesktop.org icon themes"
  homepage "https://wiki.freedesktop.org/www/Software/icon-theme/"
  url "https://icon-theme.freedesktop.org/releases/hicolor-icon-theme-0.18.tar.xz"
  sha256 "db0e50a80aa3bf64bb45cbca5cf9f75efd9348cf2ac690b907435238c3cf81d7"
  license "GPL-2.0-only"
  head "https://gitlab.freedesktop.org/xdg/default-icon-theme.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "d787c770005c2fddf276e0b17b62d1068fc6fc97b778ab376a72814be126b106"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fca72dd306b23edae0d4d66b0bd485e66f53f175ba1ca87a6167309d73533bc8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1153e436e03439c74a2eae87b6b5fbb6c8192607420dd5b01d0295a8ef29d2e5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "16e984b4dc9809fb223592f9b2c8a45cc49e796bd3b03f0b9507e80953167292"
    sha256 cellar: :any_skip_relocation, sonoma:         "d787c770005c2fddf276e0b17b62d1068fc6fc97b778ab376a72814be126b106"
    sha256 cellar: :any_skip_relocation, ventura:        "fca72dd306b23edae0d4d66b0bd485e66f53f175ba1ca87a6167309d73533bc8"
    sha256 cellar: :any_skip_relocation, monterey:       "1153e436e03439c74a2eae87b6b5fbb6c8192607420dd5b01d0295a8ef29d2e5"
    sha256 cellar: :any_skip_relocation, big_sur:        "f4cd50751f22d1aae6156ce3e552dbe0afb21ce1aaa5a7cc7ce284c867a20865"
    sha256 cellar: :any_skip_relocation, catalina:       "8ba8d6065b652396583c55a0e73cff0007f96064a330ac20499ff1d887771eb8"
    sha256 cellar: :any_skip_relocation, mojave:         "5ba4bb6a7e89f5fb0d43504d68d657a536be9540d4cc72552bd5965e15a82b91"
    sha256 cellar: :any_skip_relocation, high_sierra:    "b33f58b98a6ca6bb72777eaf7b7a4bb393d5cc9ced6954dd7a7e52e18c214799"
    sha256 cellar: :any_skip_relocation, sierra:         "cd8699f3944eb87b76fc89e4ca69f19df5d66aa8a4c89d636660d299e807f5b0"
    sha256 cellar: :any_skip_relocation, el_capitan:     "cd8699f3944eb87b76fc89e4ca69f19df5d66aa8a4c89d636660d299e807f5b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1153e436e03439c74a2eae87b6b5fbb6c8192607420dd5b01d0295a8ef29d2e5"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_predicate share/"icons/hicolor/index.theme", :exist?
  end
end
