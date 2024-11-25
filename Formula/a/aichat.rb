class Aichat < Formula
  desc "All-in-one AI-Powered CLI Chat & Copilot"
  homepage "https://github.com/sigoden/aichat"
  url "https://github.com/sigoden/aichat/archive/refs/tags/v0.24.0.tar.gz"
  sha256 "a7ec96bb2e7fd84f19447d252949ee9baf8326ee37c06f3149a4b6a189c4e7f8"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/sigoden/aichat.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4266d008f9e9005fcbe89869d1261e476c87bc4a840faa33c58604d0de174938"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "63348481cbaef58182930040552c45dc5dc11e95a942e667735439a395ecc675"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d90626570b1b9fe582f9b934dfe914aabaace81e68417faef654c0d4e5e48946"
    sha256 cellar: :any_skip_relocation, sonoma:        "0f11510b4a768f932e28965accc3eff19cdc5b17b3a030fad80bffbe5e6f9254"
    sha256 cellar: :any_skip_relocation, ventura:       "65f823dce534a1f357e345e64174858463cf1f1929b97575aa107212b144670d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c1952ec74b5d5f6ac7c0c50e34ac1e98cf90a636ea661588757efb73cf1950c6"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    bash_completion.install "scripts/completions/aichat.bash" => "aichat"
    fish_completion.install "scripts/completions/aichat.fish"
    zsh_completion.install "scripts/completions/aichat.zsh" => "_aichat"
  end

  test do
    ENV["AICHAT_PLATFORM"] = "openai"
    ENV["OPENAI_API_KEY"] = "sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    output = shell_output("#{bin}/aichat --dry-run math 3.2x4.8")
    assert_match "math 3.2x4.8", output
  end
end
