class Vals < Formula
  desc "Helm-like configuration values loader with support for various sources"
  homepage "https://github.com/helmfile/vals"
  url "https://github.com/helmfile/vals/archive/refs/tags/v0.39.0.tar.gz"
  sha256 "cf96c8f554260ed2ef64bd551625809189bae8a40db57b4776d11826c20721cb"
  license "Apache-2.0"
  head "https://github.com/helmfile/vals.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7b123990f001f8e2cae6ec8637f015b8c3ed4b32d03d07c240ccd9e43b57686e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7b123990f001f8e2cae6ec8637f015b8c3ed4b32d03d07c240ccd9e43b57686e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7b123990f001f8e2cae6ec8637f015b8c3ed4b32d03d07c240ccd9e43b57686e"
    sha256 cellar: :any_skip_relocation, sonoma:        "66a34120258e384a46545bc2c48def43d970ed7608bbd97b5e3efdbedeedfaf5"
    sha256 cellar: :any_skip_relocation, ventura:       "66a34120258e384a46545bc2c48def43d970ed7608bbd97b5e3efdbedeedfaf5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ab09a9f757cf6440be09a0154b376bfcb97f289c2890625795338e9b3b05152"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version} -X main.commit=#{tap.user}"), "./cmd/vals"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vals version")

    (testpath/"test.yaml").write <<~YAML
      foo: "bar"
    YAML
    output = shell_output("#{bin}/vals eval -f test.yaml")
    assert_match "foo: bar", output

    (testpath/"secret.yaml").write <<~YAML
      apiVersion: v1
      kind: Secret
      metadata:
        name: test-secret
      data:
        username: dGVzdC11c2Vy # base64 encoded "test-user"
        password: dGVzdC1wYXNz # base64 encoded "test-pass"
    YAML

    output = shell_output("#{bin}/vals ksdecode -f secret.yaml")
    assert_match "stringData", output
    assert_match "username: test-user", output
    assert_match "password: test-pass", output
  end
end
