
class Kbstage < Formula
  desc "Keybase (Staging)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-36.tar.gz"
  sha256 "656c8cbfad3c346716ffa8733acae2e32cdcb3b29a67877420438983fb27b5bf"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-36"

  depends_on "go" => :build

  bottle do
    cellar :any_skip_relocation
    sha256 "dcd9ad4e68d6f5ff4f500cf1bc32c77762fc5803c22a4dd18b580f70b8c8b0cb" => :yosemite
    root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-36/"
  end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

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
