class Kf5Kross < Formula
  desc "Embedding of scripting into applications"
  homepage "https://api.kde.org/frameworks/kross/html"
  url "https://download.kde.org/stable/frameworks/5.52/portingAids/kross-5.52.0.tar.xz"
  sha256 "9aafba35b57614758dc13c018b40fa47be470a9dffb503e07e290411edce0c95"

  head "git://anongit.kde.org/kross.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kxmlgui" => :build
  depends_on "gettext"
  depends_on "KDE-mac/kde/kf5-kcompletion"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kdoctools" => :optional

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --prefix)/opt/kf5-kross/bin/kf5kross.app" "$HOME/Applications/KDE/"
  EOS
  end

  test do
    assert `"#{bin}"/kf5kross.app/Contents/MacOS/kf5kross --help | grep -- --help` =~ /--help/
  end
end
