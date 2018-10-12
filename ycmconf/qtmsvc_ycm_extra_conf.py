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
    '-target i686-pc-windows-msvc19.00.24215.1',

    '-isystem', 'D:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/include',
    '-isystem', 'D:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/atlmfc/include',
    '-isystem', 'C:/Program Files (x86)/Windows Kits/10/Include/10.0.10150.0/ucrt',
    '-isystem', 'C:/Program Files (x86)/Windows Kits/NETFXSDK/4.6/include/um',
    '-isystem', 'C:/Program Files (x86)/Windows Kits/8.1/Include/um',
    '-isystem', 'C:/Program Files (x86)/Windows Kits/8.1/Include/shared',
    '-isystem', 'C:/Program Files (x86)/Windows Kits/8.1/Include/winrt',

    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/ActiveQt',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DAnimation',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DCore',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DExtras',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DInput',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DLogic',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DQuick',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DQuickAnimation',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DQuickExtras',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DQuickInput',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DQuickRender',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DQuickScene2D',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/Qt3DRender',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtANGLE',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtAccessibilitySupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtBluetooth',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtCharts',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtConcurrent',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtCore',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtDBus',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtDataVisualization',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtDesigner',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtDesignerComponents',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtDeviceDiscoverySupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtEglSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtEventDispatcherSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtFbSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtFontDatabaseSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtGamepad',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtGui',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtHelp',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtLocation',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtMultimedia',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtMultimediaQuick_p',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtMultimediaWidgets',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtNetwork',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtNetworkAuth',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtNfc',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtOpenGL',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtOpenGLExtensions',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtPacketProtocol',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtPlatformCompositorSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtPlatformHeaders',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtPositioning',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtPrintSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtPurchasing',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtQml',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtQmlDebug',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtQuick',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtQuickControls2',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtQuickParticles',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtQuickTemplates2',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtQuickTest',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtQuickWidgets',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtRemoteObjects',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtRepParser',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtScript',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtScriptTools',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtScxml',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtSensors',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtSerialBus',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtSerialPort',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtSql',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtSvg',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtTest',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtTextToSpeech',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtThemeSupport',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtUiPlugin',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtUiTools',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtWebChannel',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtWebSockets',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtWidgets',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtWinExtras',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtXml',
    '-isystem', 'D:/Qt/Qt5.9.6/5.9.6/msvc2015/include/QtXmlPatterns',
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