cask "flipio" do
  version "0.1.0"
  sha256 "REPLACE_WITH_SHA256_FROM_V0_1_0_RELEASE_JOB_SUMMARY"

  url "https://github.com/pavel-golub/flipio/releases/download/v#{version}/Flipio-#{version}.dmg"
  name "Flipio"
  desc "Menu bar app that converts typed text between keyboard layouts"
  homepage "https://github.com/pavel-golub/flipio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Flipio.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Flipio.app"]
  end

  uninstall quit: "com.flipio.app"

  zap trash: [
    "~/Library/Preferences/com.flipio.app.plist",
    "~/Library/Caches/com.flipio.app",
    "~/Library/HTTPStorages/com.flipio.app",
  ]

  caveats <<~EOS
    Flipio is ad-hoc signed (not notarized — the author is not in the Apple
    Developer Program). The postflight step removes macOS Gatekeeper's
    quarantine attribute so the app can launch. Review the source at
    #{homepage} before installing if that concerns you.

    On first launch, grant Accessibility permission.
  EOS
end
