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
    '-x', 'c',
    '-x', 'c++',
    '-std=c++11',
    '-stdlib=libc++',
    '-Wno-deprecated-declarations',
    '-Wno-disabled-macro-expansion',
    '-Wno-float-equal',
    '-Wno-c++98-compat',
    '-Wno-c++98-compat-pedantic',
    '-Wno-global-constructors',
    '-Wno-exit-time-destructors',
    '-Wno-missing-prototypes',
    '-Wno-padded',
    '-Wextra',
    '-Werror',
    '-Wc++98-compat',
    '-Wno-long-long',
    '-Wno-variadic-macros',
    '-fexceptions',
    '-DNDEBUG',
    '-D__GNUC__=5',
    '-D__GNUC_MINOR__=3',
    '-D__GNUC_PATCHLEVEL__=0',
    '-target',
    'x86_64-w64-mingw32'
    '-DQT_CORE_LIB',
    '-DQT_GUI_LIB',
    '-DQT_NETWORK_LIB',
    '-DQT_QML_LIB',
    '-DQT_QUICK_LIB',
    '-DQT_SQL_LIB',
    '-DQT_WIDGETS_LIB',
    '-DQT_XML_LIB',

    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/lib/gcc/i686-w64-mingw32/5.3.0/include',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/c++',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/c++/i686-w64-mingw32',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/ddk',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/gdiplus',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/GL',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/psdk_inc',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/sdks',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/sec_api',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/sys',
    '-isystem', 'D:/Qt/Qt5.9.6/Tools/mingw530_32/i686-w64-mingw32/include/wrl',

    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/ActiveQt',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DAnimation',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DCore',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DExtras',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DInput',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DLogic',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuick',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuickAnimation',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuickExtras',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuickInput',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuickRender',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DQuickScene2D',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/Qt3DRender',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtANGLE',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtAccessibilitySupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtBluetooth',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtCharts',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtConcurrent',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtCore',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtDBus',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtDataVisualization',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtDesigner',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtDesignerComponents',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtDeviceDiscoverySupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtEglSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtEventDispatcherSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtFbSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtFontDatabaseSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtGamepad',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtGui',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtHelp',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtLocation',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtMultimedia',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtMultimediaQuick_p',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtMultimediaWidgets',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtNetwork',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtNetworkAuth',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtNfc',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtOpenGL',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtOpenGLExtensions',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPacketProtocol',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPlatformCompositorSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPlatformHeaders',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPositioning',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPrintSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtPurchasing',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQml',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQmlDebug',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuick',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuickControls2',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuickParticles',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuickTemplates2',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuickTest',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtQuickWidgets',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtRemoteObjects',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtRepParser',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtScript',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtScriptTools',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtScxml',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtSensors',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtSerialBus',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtSerialPort',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtSql',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtSvg',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtTest',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtTextToSpeech',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtThemeSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtUiPlugin',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtUiTools',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtWebChannel',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtWebSockets',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtWidgets',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtWinExtras',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtXml',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/mingw53_32/include/QtXmlPatterns',
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
