class KeybaseDisabled < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  BIN_NAME = "keybase"
  VERSION = "1.0.0-21"

  url "https://github.com/keybase/client-beta/archive/v#{VERSION}.tar.gz"
  sha256 "e081c154ad2c270f849850337969891059b1c2a86f17761de178f75fa78750d5"

  head "https://github.com/keybase/client-beta.git"
  version VERSION

  # bottle do
  #   cellar :any_skip_relocation
  #   root_url "https://github.com/keybase/client-beta/releases/download/v#{VERSION}/"
  #   sha256 "215b27eb171d15c70ce4c8b486ee5ed666a21d8d850b106c4928c05a3eafb8f4" => :yosemite
  # end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "get", "github.com/keybase/client/go/keybase"
    system "go", "build", "-tags", "release brew", "-o", BIN_NAME, "github.com/keybase/client/go/keybase"

    bin.install BIN_NAME
  end

  def post_install
    system "#{opt_bin}/#{BIN_NAME}", "launchd", "install", "homebrew.mxcl.keybase", "#{opt_bin}/#{BIN_NAME}"
  end

  test do
    system "#{bin}/#{BIN_NAME}", "version", "-d"
  end
end
