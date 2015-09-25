class Kbdev < Formula
  desc "Keybase (Dev)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-25.tar.gz"
  sha256 "47f29fbce993dcacbfa790476699d8946bded97e2053310744dfff36475f1cba"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-25"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "get", "github.com/keybase/client/go/keybase"
    # No release or staging tag is a (default) devel build
    system "go", "build", "-a", "-tags", "brew", "-o", "kbdev", "github.com/keybase/client/go/keybase"

    bin.install "kbdev"
  end

  def post_install
    system "#{opt_bin}/kbdev", "launchd", "install", "homebrew.mxcl.keybase.devel", "#{opt_bin}/kbdev"
  end

  test do
    system "#{bin}/kbdev", "version"
  end
end
