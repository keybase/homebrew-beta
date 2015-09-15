class KeybaseDev < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-20.tar.gz"
  sha256 "1e63d966cd0bd10e73eec51844eee9f75a64270af1aa36c6e8a3103b1bcca49c"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-20"

  # bottle do
  #   cellar :any_skip_relocation
  #   root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-19/"
  #   sha256 "c667efdd99cce2c0767816b972b15cb665bdde1791b6f8e5e813303a120951da" => :yosemite
  # end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "get", "github.com/keybase/client/go/keybase"
    system "go", "build", "-tags", "release", "github.com/keybase/client/go/keybase"

    bin.install "keybase"
  end

  def post_install
    system "#{opt_bin}/keybase", "launchd", "install", "homebrew.mxcl.keybase", "#{opt_bin}/keybase"
  end

  test do
    system "#{bin}/keybase", "version", "-d"
  end
end
