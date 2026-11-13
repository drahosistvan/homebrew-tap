# Homebrew cask template for Taped. Lives in a (public) tap, e.g. drahosistvan/homebrew-tap as
# Casks/taped.rb; the release workflow bumps version + sha256 per arch on every tag.
# Downloads come from tapedapp.com because the source repository is private.
#
#   brew tap drahosistvan/tap
#   brew install --cask taped
cask "taped" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.0"
  sha256 arm:   "bc7aa210ca5049054d6fb09b781c3e85fb297aab9489b203798f9eeaa7995e96",
         intel: "783bdc5faba25a8e68fd719a5a715ba1b234431e8c6ffaa50abb28d91062f419"

  url "https://tapedapp.com/downloads/Taped-#{version}-#{arch}.dmg"
  name "Taped"
  desc "Menubar video archiver (yt-dlp inside)"
  homepage "https://tapedapp.com/"

  livecheck do
    url "https://tapedapp.com/appcast-#{arch}.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Taped.app"
  # The `taped` command line (docs/integration-api.md).
  binary "#{appdir}/Taped.app/Contents/Helpers/taped"

  zap trash: [
    "~/Library/Application Support/Taped",
    "~/Library/Caches/com.tapedapp.app",
    # Bundle id before 1.x was dev.taped.app; an older install leaves these behind.
    "~/Library/Caches/dev.taped.app",
    "~/Library/Preferences/com.tapedapp.app.plist",
    "~/Library/Preferences/dev.taped.app.plist",
  ]
end
