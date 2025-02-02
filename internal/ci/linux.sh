#!/bin/bash
set -ev

#check env
df -h

ls $HOME/*
du -sh $HOME/*

#needed for headless qt installation
export QT_QPA_PLATFORM=minimal

#replace gcc4 with gcc5
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get -qq update
sudo apt-get -y -qq install gcc-5 g++-5
sudo rm /usr/bin/gcc; sudo ln -s /usr/bin/gcc-5 /usr/bin/gcc
sudo rm /usr/bin/g++; sudo ln -s /usr/bin/g++-5 /usr/bin/g++

if [ "$QT_PKG_CONFIG" == "true" ]
then
  #download and install qt
  sudo add-apt-repository -y ppa:beineri/opt-qt57-trusty
  sudo apt-get -qq update
  sudo apt-get -y -qq install qt573d qt57base qt57canvas3d qt57charts-no-lgpl qt57connectivity qt57creator qt57datavis-no-lgpl qt57declarative qt57declarative-render2d-no-lgpl qt57doc qt57gamepad qt57graphicaleffects qt57imageformats qt57location qt57multimedia qt57qbs qt57quickcontrols qt57quickcontrols2 qt57script qt57scxml qt57sensors qt57serialbus qt57serialport qt57svg qt57tools qt57translations qt57virtualkeyboard-no-lgpl qt57webchannel qt57webengine qt57websockets qt57x11extras qt57xmlpatterns
else
  #download and install qt
  QT=qt-opensource-linux-x64-android-5.7.0.run
  curl -sL --retry 10 --retry-delay 10 -o /tmp/$QT https://download.qt.io/official_releases/qt/5.7/5.7.0/$QT
  chmod +x /tmp/$QT
  /tmp/$QT --script $GOPATH/src/github.com/therecipe/qt/internal/ci/iscript.qs
  rm -f /tmp/$QT
fi

if [ "$QT_WINDOWS_CC" == "true" ]
then
  #download and install qt (and wine) for cross compilation
  #sudo apt-get -y -qq install wine
  echo "deb http://pkg.mxe.cc/repos/apt/debian wheezy main" | sudo tee --append /etc/apt/sources.list.d/mxeapt.list > /dev/null
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D43A795B73B16ABE9643FE1AFD8FFF16DB45C6AB
  sudo apt-get -qq update

  if [ "$QT_MXE_ARCH" == "386" ]
  then
    sudo apt-get -y -qq install mxe-i686-w64-mingw32.shared-qt3d mxe-i686-w64-mingw32.shared-qtactiveqt mxe-i686-w64-mingw32.shared-qtbase mxe-i686-w64-mingw32.shared-qtcanvas3d mxe-i686-w64-mingw32.shared-qtcharts mxe-i686-w64-mingw32.shared-qtconnectivity mxe-i686-w64-mingw32.shared-qtdatavis3d mxe-i686-w64-mingw32.shared-qtdeclarative mxe-i686-w64-mingw32.shared-qtdeclarative-render2d mxe-i686-w64-mingw32.shared-qtgamepad mxe-i686-w64-mingw32.shared-qtgraphicaleffects mxe-i686-w64-mingw32.shared-qtimageformats mxe-i686-w64-mingw32.shared-qtlocation mxe-i686-w64-mingw32.shared-qtmultimedia mxe-i686-w64-mingw32.shared-qtofficeopenxml mxe-i686-w64-mingw32.shared-qtpurchasing mxe-i686-w64-mingw32.shared-qtquickcontrols mxe-i686-w64-mingw32.shared-qtquickcontrols2 mxe-i686-w64-mingw32.shared-qtscript mxe-i686-w64-mingw32.shared-qtscxml mxe-i686-w64-mingw32.shared-qtsensors mxe-i686-w64-mingw32.shared-qtserialbus mxe-i686-w64-mingw32.shared-qtserialport mxe-i686-w64-mingw32.shared-qtservice mxe-i686-w64-mingw32.shared-qtsvg mxe-i686-w64-mingw32.shared-qtsystems mxe-i686-w64-mingw32.shared-qttools mxe-i686-w64-mingw32.shared-qttranslations mxe-i686-w64-mingw32.shared-qtvirtualkeyboard mxe-i686-w64-mingw32.shared-qtwebchannel mxe-i686-w64-mingw32.shared-qtwebkit mxe-i686-w64-mingw32.shared-qtwebsockets mxe-i686-w64-mingw32.shared-qtwinextras mxe-i686-w64-mingw32.shared-qtxlsxwriter mxe-i686-w64-mingw32.shared-qtxmlpatterns
  else
    sudo apt-get -y -qq install mxe-x86-64-w64-mingw32.shared-qt3d mxe-x86-64-w64-mingw32.shared-qtactiveqt mxe-x86-64-w64-mingw32.shared-qtbase mxe-x86-64-w64-mingw32.shared-qtcanvas3d mxe-x86-64-w64-mingw32.shared-qtcharts mxe-x86-64-w64-mingw32.shared-qtconnectivity mxe-x86-64-w64-mingw32.shared-qtdatavis3d mxe-x86-64-w64-mingw32.shared-qtdeclarative mxe-x86-64-w64-mingw32.shared-qtdeclarative-render2d mxe-x86-64-w64-mingw32.shared-qtgamepad mxe-x86-64-w64-mingw32.shared-qtgraphicaleffects mxe-x86-64-w64-mingw32.shared-qtimageformats mxe-x86-64-w64-mingw32.shared-qtlocation mxe-x86-64-w64-mingw32.shared-qtmultimedia mxe-x86-64-w64-mingw32.shared-qtofficeopenxml mxe-x86-64-w64-mingw32.shared-qtpurchasing mxe-x86-64-w64-mingw32.shared-qtquickcontrols mxe-x86-64-w64-mingw32.shared-qtquickcontrols2 mxe-x86-64-w64-mingw32.shared-qtscript mxe-x86-64-w64-mingw32.shared-qtscxml mxe-x86-64-w64-mingw32.shared-qtsensors mxe-x86-64-w64-mingw32.shared-qtserialbus mxe-x86-64-w64-mingw32.shared-qtserialport mxe-x86-64-w64-mingw32.shared-qtservice mxe-x86-64-w64-mingw32.shared-qtsvg mxe-x86-64-w64-mingw32.shared-qtsystems mxe-x86-64-w64-mingw32.shared-qttools mxe-x86-64-w64-mingw32.shared-qttranslations mxe-x86-64-w64-mingw32.shared-qtvirtualkeyboard mxe-x86-64-w64-mingw32.shared-qtwebchannel mxe-x86-64-w64-mingw32.shared-qtwebkit mxe-x86-64-w64-mingw32.shared-qtwebsockets mxe-x86-64-w64-mingw32.shared-qtwinextras mxe-x86-64-w64-mingw32.shared-qtxlsxwriter mxe-x86-64-w64-mingw32.shared-qtxmlpatterns
  fi
fi

#download and install android sdk
SDK=android-sdk_r24.4.1-linux.tgz
curl -sL --retry 10 --retry-delay 10 -o /tmp/$SDK https://dl.google.com/android/$SDK
tar -xzf /tmp/$SDK -C $HOME
rm -f /tmp/$SDK

#install deps for android sdk
$HOME/android-sdk-linux/tools/android list sdk
echo "y" | $HOME/android-sdk-linux/tools/android -s update sdk -f -u -t 1,2,3,5

#download and install android ndk
NDK=android-ndk-r12b-linux-x86_64.zip
curl -sL --retry 10 --retry-delay 10 -o /tmp/$NDK https://dl.google.com/android/repository/$NDK
unzip -qq /tmp/$NDK -d $HOME
rm -f /tmp/$NDK

#install openjdk8
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get -qq update
sudo apt-get -y -qq install openjdk-8-jdk

#prepare env
sudo chown $USER /usr/local/bin
sudo chown $USER $GOROOT/pkg | true

#check env
df -h

ls $HOME/*
du -sh $HOME/*
