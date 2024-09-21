class Uv < Formula
  desc "Extremely fast Python package installer and resolver, written in Rust"
  homepage "https://github.com/astral-sh/uv"
  url "https://github.com/astral-sh/uv/archive/refs/tags/0.4.15.tar.gz"
  sha256 "fb9d134ccac8ce4088060705ccd5678d7825a22ca9951364efd5e7474d577602"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/astral-sh/uv.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dc3a5c1f0455bd776bbf837eaf39e39d27a555eea9742f2b9ef75659c23903d5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d67406b4bbb51c9f481fca52dc5f8c220196a77c1d4b1a71544fbdf1b7d2b5ef"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e248a63a4eabda39d0513b5cb9864f227638530ea557a9edef32d7ebd9bd7996"
    sha256 cellar: :any_skip_relocation, sonoma:        "f1dea03ec13536030ab7ddccdfde53b2c0d5e4cb2fe0a249c96c6799ab7e9bad"
    sha256 cellar: :any_skip_relocation, ventura:       "5c91668fb2def34b21ccf424553d4b3e3536f9ede785dbe565184e4b4282015d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f561e7dc68dccc3b96bc06ea91981f2345a9aa51b4e15ecb801acfc43eb48634"
  end

  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  uses_from_macos "python" => :test
  uses_from_macos "xz"

  on_linux do
    # On macOS, bzip2-sys will use the bundled lib as it cannot find the system or brew lib.
    # We only ship bzip2.pc on Linux which bzip2-sys needs to find library.
    depends_on "bzip2"
  end

  def install
    ENV["UV_COMMIT_HASH"] = ENV["UV_COMMIT_SHORT_HASH"] = tap.user
    ENV["UV_COMMIT_DATE"] = time.strftime("%F")
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "crates/uv")
    generate_completions_from_executable(bin/"uv", "generate-shell-completion")
    generate_completions_from_executable(bin/"uvx", "--generate-shell-completion", base_name: "uvx")
  end

  test do
    (testpath/"requirements.in").write <<~EOS
      requests
    EOS

    compiled = shell_output("#{bin}/uv pip compile -q requirements.in")
    assert_match "This file was autogenerated by uv", compiled
    assert_match "# via requests", compiled

    assert_match "ruff 0.5.1", shell_output("#{bin}/uvx -q ruff@0.5.1 --version")
  end
end
