class Kf5Kpty < Formula
  desc "Pty abstraction"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.52/kpty-5.52.0.tar.xz"
  sha256 "02cd57c6fb41946d76e79153387db24de664f3f55db6664b37d65286ef91c78a"

  head "git://anongit.kde.org/kpty.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
