class Kbstage < Formula
  desc "Keybase (Staging)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client/archive/v1.0.0-45.tar.gz"
  sha256 "51385ea2823affb8f4a94d462ad96052ebe4b20c05518276096236d45a3c9653"

  head "https://github.com/keybase/client.git"
  version "1.0.0-45"

  depends_on "go" => :build

  bottle do
    cellar :any_skip_relocation
    sha256 "bc9432e476c402b0be1c4ba92a657d31039b46062f0a9f2a837d8fbaf95bb063" => :yosemite
    root_url "https://github.com/keybase/client/releases/download/v1.0.0-45"
  end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"
    system "mkdir", "-p", "src/github.com/keybase/client/"
    system "mv", "go", "src/github.com/keybase/client/"

    system "go", "build", "-a", "-tags", "staging brew", "-o", "kbstage", "github.com/keybase/client/go/keybase"

    bin.install "kbstage"
  end

  def post_install
    system "#{opt_bin}/kbstage", "launchd", "install", "homebrew.mxcl.keybase.staging", "#{opt_bin}/kbstage", "service"
  end

  test do
    system "#{bin}/kbstage", "version"
  end
end
