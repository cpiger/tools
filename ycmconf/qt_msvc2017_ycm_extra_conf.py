import os
import ycm_core
from clang_helpers import PrepareClangFlags

# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = ''

# These are the compilation flags that will be used in case there's no
# compilation database set.
flags = [
    '-std=c++14',
    '-stdlib=libc++',
    '-x', 'c',
    '-x', 'c++',
    #  '-target i686-pc-windows-msvc19.00.24215.1',
    '-target x86_64-pc-windows-msvc',

    '-EHsc',
    '-DWIN32',
    '-D_ENABLE_EXTENDED_ALIGNED_STORAGE',
    '-DQZXING_LIBRARY ',
    '-DZXING_ICONV_CONST ',
    '-DDISABLE_LIBRARY_FEATURES ',
    '-DQZXING_MULTIMEDIA ',
    '-DQZXING_QML ',
    '-DNOFMAXL ',
    '-D__STDC_LIMIT_MACROS ',
    '-DQT_DEPRECATED_WARNINGS ',
    '-DWINAPI="__stdcall" ',
    '-DSS_ANSI ',
    '-DQT_NO_DEBUG ',
    '-DQT_CHARTS_LIB ',
    '-DQT_OPENGL_LIB ',
    '-DQT_WIDGETS_LIB ',
    '-DQT_QUICK_LIB ',
    '-DQT_MULTIMEDIA_LIB ',
    '-DQT_GUI_LIB ',
    '-DQT_QML_LIB ',
    '-DQT_NETWORK_LIB ',
    '-DQT_SQL_LIB ',
    '-DQT_POSITIONING_LIB ',
    '-DQT_SENSORS_LIB ',
    '-DQT_CORE_LIB ',
    '-DNDEBUG ',

    #  '--driver-mode=cl -Qunused-arguments -Xclang -load -Xclang ClangLazy.dll -Xclang -add-plugin -Xclang clang-lazy -Wno-microsoft-enum-value',
    #  vs2015
    #  '-isystem', 'D:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/include',
    #  '-isystem', 'D:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/atlmfc/include',

    #  vs2017
    #  '-isystem', 'D:/Program Files (x86)/Microsoft Visual Studio/2017/Enterprise/VC/Tools/MSVC/14.16.27023/include',
    #  '-isystem', 'D:/Program Files (x86)/Microsoft Visual Studio/2017/Enterprise/VC/Tools/MSVC/14.16.27023/atlmfc/include',

    #  windows sdk
    #  '-isystem', 'C:/Program Files (x86)/Windows Kits/10/Include/10.0.17763.0/um',
    #  '-isystem', 'C:/Program Files (x86)/Windows Kits/10/Include/10.0.17763.0/winrt',
    #  '-isystem', 'C:/Program Files (x86)/Windows Kits/10/Include/10.0.17763.0/shared',
    #  '-isystem', 'C:/Program Files (x86)/Windows Kits/10/Include/10.0.17763.0/ucrt',

    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/ActiveQt',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DAnimation',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DCore',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DExtras',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DInput',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DLogic',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DQuick',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DQuickAnimation',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DQuickExtras',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DQuickInput',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DQuickRender',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DQuickScene2D',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/Qt3DRender',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtANGLE',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtAccessibilitySupport',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtBluetooth',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtCharts',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtConcurrent',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtCore',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtDBus',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtDataVisualization',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtDesigner',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtDesignerComponents',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtDeviceDiscoverySupport',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtEglSupport',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtEventDispatcherSupport',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtFbSupport',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtFontDatabaseSupport',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtGamepad',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtGui',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtHelp',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtLocation',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtMultimedia',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtMultimediaQuick_p',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtMultimediaWidgets',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtNetwork',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtNetworkAuth',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtNfc',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtOpenGL',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtOpenGLExtensions',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtPacketProtocol',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtPlatformCompositorSupport',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtPlatformHeaders',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtPositioning',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtPrintSupport',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtPurchasing',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtQml',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtQmlDebug',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtQuick',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtQuickControls2',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtQuickParticles',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtQuickTemplates2',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtQuickTest',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtQuickWidgets',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtRemoteObjects',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtRepParser',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtScript',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtScriptTools',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtScxml',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtSensors',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtSerialBus',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtSerialPort',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtSql',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtSvg',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtTest',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtTextToSpeech',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtThemeSupport',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtUiPlugin',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtUiTools',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtWebChannel',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtWebSockets',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtWidgets',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtWinExtras',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtXml',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/include/QtXmlPatterns',
    '-isystem', 'D:/Qt/Qt5.12.1/5.12.1/msvc2017/mkspecs/win32-msvc',

    '-DUNICODE',
    '-D_UNICODE',
    '-DCMLIB_LIBRARY',

    '-I', '.',
    '-I', 'cm-lib/source',
    '-I', 'cm-lib/source/controllers',
    '-I', 'cm-lib/source/data',
    '-I', 'cm-lib/source/framework',
    '-I', 'cm-lib/source/models',

    '-I', '.',
    '-I', 'src/MJS008/QZXing',
    '-I', 'src/MJS008/QZXing/zxing',
    '-I', 'src/MJS008/QZXing/zxing/win32/zxing',
    '-I', 'src/MJS008/QZXing/zxing/win32/zxing/msvc',
    '-I', 'Inc',
    '-I', 'Inc/opencv_include',
    '-I', 'Dev',
    '-I', 'Src',
    '-I', 'Src/CamVideo',
    '-I', 'Src/CamVideo/core',
    '-I', 'Src/CamVideo/cvqml',
    '-I', 'Src/CamVideo/rendering',
    '-I', 'Src/MJS008/poppler',
    '-I', '3rdparty/QtPdfium/include',
    '-I', '3rdparty/QtXlsxWriter/include',
]

if compilation_database_folder:
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None


def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return flags
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def FlagsForFile( filename ):
  if database:
    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = database.GetCompilationInfoForFile( filename )
    final_flags = PrepareClangFlags(
        MakeRelativePathsInFlagsAbsolute(
            compilation_info.compiler_flags_,
            compilation_info.compiler_working_dir_ ),
        filename )

    # NOTE: This is just for YouCompleteMe; it's highly likely that your project
    # does NOT need to remove the stdlib flag. DO NOT USE THIS IN YOUR
    # ycm_extra_conf IF YOU'RE NOT 100% YOU NEED IT.
    try:
      final_flags.remove( '-stdlib=libc++' )
    except ValueError:
      pass
  else:
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
}
