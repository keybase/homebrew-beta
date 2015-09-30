class KeybaseDisabled < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-26.tar.gz"
  sha256 "47f29fbce993dcacbfa790476699d8946bded97e2053310744dfff36475f1cba"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-26"

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
    # This is temporary
    system "rm", "-rf", "src/github.com/keybase/go/vendor"

    system "go", "get", "github.com/keybase/client/go/keybase"
    system "go", "build", "-a", "-tags", "release brew", "-o", "keybase", "github.com/keybase/client/go/keybase"

    bin.install "keybase"
  end

  def post_install
    system "#{opt_bin}/keybase", "launchd", "install", "homebrew.mxcl.keybase", "#{opt_bin}/keybase", "service"
  end

  test do
    system "#{bin}/keybase", "version"
  end
end
