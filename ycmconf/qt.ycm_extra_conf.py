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
    '-std=c++11',
    '-stdlib=libc++',
    '-x', 'c',
    '-x', 'c++',
    '-Wno-deprecated-declarations',
    '-Wno-disabled-macro-expansion',
    '-Wno-float-equal',
    '-Wno-c++98-compat',
    '-Wno-c++98-compat-pedantic',
    '-Wno-global-constructors',
    '-Wno-exit-time-destructors',
    '-Wno-missing-prototypes',
    '-Wno-padded',
    '-Wno-c++11-extensions',
    '-target x86_64-w64-mingw32',
    '-DQT_CORE_LIB',
    '-DQT_GUI_LIB',
    '-DQT_NETWORK_LIB',
    '-DQT_QML_LIB',
    '-DQT_QUICK_LIB',
    '-DQT_SQL_LIB',
    '-DQT_WIDGETS_LIB',
    '-DQT_XML_LIB',

    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/c++',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/c++/',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/c++/tr1',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/c++/tr2',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/lib/gcc/i686-w64-mingw32/5.3.0/include',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/c++/i686-w64-mingw32',

    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/ActiveQt',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DAnimation',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DCore',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DExtras',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DInput',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DLogic',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuick',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuickAnimation',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuickExtras',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuickInput',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuickRender',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuickScene2D',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DRender',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtANGLE',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtAccessibilitySupport',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtBluetooth',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtCharts',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtConcurrent',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtCore',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtDBus',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtDataVisualization',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtDesigner',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtDesignerComponents',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtDeviceDiscoverySupport',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtEglSupport',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtEventDispatcherSupport',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtFbSupport',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtFontDatabaseSupport',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtGamepad',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtGui',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtHelp',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtLocation',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtMultimedia',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtMultimediaQuick_p',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtMultimediaWidgets',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtNetwork',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtNetworkAuth',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtNfc',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtOpenGL',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtOpenGLExtensions',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPacketProtocol',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPlatformCompositorSupport',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPlatformHeaders',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPositioning',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPrintSupport',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPurchasing',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQml',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQmlDebug',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuick',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuickControls2',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuickParticles',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuickTemplates2',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuickTest',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuickWidgets',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtRemoteObjects',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtRepParser',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtScript',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtScriptTools',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtScxml',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtSensors',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtSerialBus',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtSerialPort',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtSql',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtSvg',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtTest',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtTextToSpeech',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtThemeSupport',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtUiPlugin',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtUiTools',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtWebChannel',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtWebSockets',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtWidgets',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtWinExtras',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtXml',
    '-I', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtXmlPatterns',
    #  '-I', '.',
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
  else:
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
  }
