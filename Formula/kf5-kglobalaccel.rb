class Kf5Kglobalaccel < Formula
  desc "Add support for global workspace shortcuts"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.50/kglobalaccel-5.50.0.tar.xz"
  sha256 "6385bb0749bc75fb357125711b255333683042e7a27951217f8a06470f4c97b7"

  head "git://anongit.kde.org/kglobalaccel.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kcrash"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"

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

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
  EOS
  end
end
