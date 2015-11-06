class Keybase < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client/archive/v1.0.0-45.tar.gz"
  sha256 "51385ea2823affb8f4a94d462ad96052ebe4b20c05518276096236d45a3c9653"

  head "https://github.com/keybase/client.git"
  version "1.0.0-45"

  depends_on "go" => :build

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "1216a7d3a1b51ca31ae7e57c723b4901c0e50e0dd4ee6c2e10210e98ffead38c" => :yosemite
    sha256 "20e0842a415633b01131eda3a387a5576e4626f7a675686fdd80f5615a0203da" => :el_capitan
    root_url "https://github.com/keybase/client/releases/download/v1.0.0-45"
  end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"
    system "mkdir", "-p", "src/github.com/keybase/client/"
    system "mv", "go", "src/github.com/keybase/client/"

    system "go", "build", "-a", "-tags", "production brew", "github.com/keybase/client/go/keybase"

    bin.install "keybase"
  end

  def post_install
    system "#{opt_bin}/keybase", "launchd", "install", "homebrew.mxcl.keybase", "#{opt_bin}/keybase", "service"
  end

  test do
    system "#{bin}/keybase", "version"
  end
end
