require "formula"

class Kf5Kcmutils < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kcmutils-5.22.0.tar.xz"
  sha1 "232b8a55afd9e4f41b1487b5209aa63f6d9814c9"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcmutils.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "haraldf/kf5/kf5-kdeclarative"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
