#! /bin/bash
# To run: sh c.sh -a y -b y -c y -d y -e w -f y -g "gb" -h n -i "win_cp" -j n -k "gb" -l n -z y  

# single-executable-applications: https://nodejs.org/api/single-executable-applications.html
  # Un paso a paso: https://dev.to/chad_r_stewart/compile-a-single-executable-from-your-node-app-with-nodejs-20-and-esbuild-210j
# Colores: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# Firmar ejecutable: https://signmycode.com/resources/signing-executable-files-using-microsoft-signtool 

# Ejecutar hasta la 5
# Paso 6 ejecutarse en PS dado que en gb falla
# Una vez ejecutado 6, se puede ejecutar el 8
# sh c.sh -a y -b y -c y -d y -e w -f y -g "gb" -h n -i "win_cp" -j n -k "gb" -l n -z y
# i :
  # "linux"
  # "win_ps"
  # "win_cp"
  # "mac"

# Ejecutar solo paso 8 (siempre y cuando en ps se haya ejecutado el 6)
# sh c.sh -l y

#Add some color
RED='\e[31m'
GRN='\e[32m'
grn='\e[92m'
YLW='\e[33m'
DEF='\e[0m'   #Default color and effects
BLD='\e[1m'   #Bold\brighter
COF='\e[?25l' #Cursor Off
CON='\e[?25h' #Cursor On

function printTitle()
{
  # color1, title, color2
  printf "\n"
  printf "${2}";
  echo -e "$1"
  printf "${3}";
  printf "\n"
}

function delFile()
{
  # file
  if [ -f "$1" ] ; then
    rm "$1"
  fi
}

function fileExist()
{
  # file
  if [ -f "$1" ] ; then
    echo -e ""
    printTitle " Archivo ${1} creado con éxito" $GRN $DEF 
    return 0
  fi
  printTitle " Archivo ${1} no creado con éxito" $RED $DEF
  return 1
}

function listDir()
{
  printf "\n"
  ls -al
}

function printDate()
{
  current_date_time="`date "+%Y-%m-%d %H:%M:%S"`";
  printf "\n"
  echo -e "\033[31m $current_date_time \033[0m"
}

clear

while getopts a:b:c:d:e:f:g:h:i:j:k:l:z: flag
do
    case "${flag}" in
        a) pas_1=${OPTARG};;
        b) pas_2=${OPTARG};;
        c) pas_3=${OPTARG};;
        d) pas_4=${OPTARG};;
        e) pas_4_os=${OPTARG};;
        f) pas_5=${OPTARG};;
        g) pas_5_sh=${OPTARG};;
        h) pas_6=${OPTARG};;
        i) pas_6_os=${OPTARG};;
        j) pas_7=${OPTARG};;
        k) pas_7_os=${OPTARG};;
        l) pas_8=${OPTARG};;
        z) borrar=${OPTARG};;
    esac
done

# Si no se ha definido se colona 'n'
if [ -z ${pas_1+x} ]; then pas_1="n"; fi
if [ -z ${pas_2+x} ]; then pas_2="n"; fi
if [ -z ${pas_3+x} ]; then pas_3="n"; fi
if [ -z ${pas_4+x} ]; then pas_4="n"; fi
if [ -z ${pas_5+x} ]; then pas_5="n"; fi
if [ -z ${pas_6+x} ]; then pas_6="n"; fi
if [ -z ${pas_7+x} ]; then pas_7="n"; fi
if [ -z ${pas_8+x} ]; then pas_8="n"; fi
if [ -z ${borrar+x} ]; then borrar="n"; fi
if [ -z ${pas_4_os+x} ]; then pas_4_os="n"; fi
if [ -z ${pas_5_sh+x} ]; then pas_5_sh="n"; fi
if [ -z ${pas_6_os+x} ]; then pas_6_os="n"; fi
if [ -z ${pas_7_os+x} ]; then pas_7_os="n"; fi

# echo "pas_1: $pas_1";
# echo "pas_2: $pas_2";
# echo "pas_3: $pas_3";
# echo "pas_4: $pas_4";
# echo "pas_4_os: $pas_4_os";
# echo "pas_5: $pas_5";
# echo "pas_5_sh: $pas_5_sh";
# echo "pas_6: $pas_6";
# echo "pas_6_os: $pas_6_os";
# echo "pas_7: $pas_7";
# echo "pas_7_os: $pas_7_os";
# echo "pas_8: $pas_8";
# echo "Borrar: $borrar";

printDate

if [ $borrar = "y" ]; then
  printTitle "----> Borrando inicio" $YLW $DEF 

  delFile "hello.exe"
  delFile "hello.js"
  delFile "sea-config.json"
  delFile "sea-prep.blob"

  listDir

  printTitle "----> Borrando fin" $YLW $DEF 
fi

if [ $pas_1 = "y" ]; then
  printTitle "----> 1.- Create a JavaScript file inicio" $YLW $DEF 

  echo 'console.log(`Hello, ${process.argv[2]}!`);' > hello.js

  fileExist "hello.js"

  printTitle "----> 1.- Create a JavaScript file fin" $YLW $DEF 
fi

if [ $pas_2 = "y" ]; then
  printTitle "--> 2.- Create a configuration file building a blob that   can be injected into the single executable application (see Generating  single executable preparation blobs for details):" $YLW $DEF 

  echo '{ "main": "hello.js", "output": "sea-prep.blob" }' > sea-config.json

  fileExist "sea-config.json"

  printTitle "----> 2.- Create a configuration file building a blob fin" $YLW $DEF 
fi

if [ $pas_3 = "y" ]; then
  printTitle "--> 3.- Generate the blob to be injected:" $YLW $DEF 

  printf "${GRN}"
  node --experimental-sea-config sea-config.json

  fileExist "sea-prep.blob"

  printTitle "----> 3.- Generate the blob to be injected: fin" $YLW $DEF 
fi

if [ $pas_4 = "y" ]; then
  printTitle "--> 4.- Create a copy of the node executable and name it   according to your needs:" $YLW $DEF 
  
  if [ $pas_4_os = "nw" ]; then
    printTitle " Ejecutando para no windows" $GRN $DEF
    cp $(command -v node) hello
  fi
  
  if [ $pas_4_os = "w" ]; then
    printTitle " Ejecutando para windows" $GRN $DEF
    node -e "require('fs').copyFileSync(process.execPath, 'hello.exe')"
  fi

  fileExist "hello.exe"

  printTitle "----> 4.- Create a copy of the node executable and name it   according to your needs: fin" $YLW $DEF 
fi

if [ $pas_5 = "y" ]; then
  printTitle "--> 5.- Remove the signature of the binary (macOS and  Windows only):\n signtool can be used from the installed Windows SDK. If   this step is skipped, ignore any signature-related warning from postject." $YLW $DEF 

  printf "${RED}"
  
  if [ $pas_5_sh = "ps" ]; then
    printTitle " Ejecutando para power shell" $GRN $DEF
    signtool remove /s hello.exe
  fi
  
  if [ $pas_5_sh = "gb" ]; then
    printTitle " Ejecutando para git bash" $GRN $DEF
    signtool remove //s hello.exe
  fi

  printTitle "----> 5.- Remove the signature of the binary (macOS and  Windows only). fin" $YLW $DEF 
fi

if [ $pas_6 = "y" ]; then
  printTitle "--> 6.- Inject the blob into the copied binary by running postject   with the following options:" $YLW $DEF 

  printf "${RED}"

  if [ $pas_6_os = "linux" ]; then
    printTitle " Ejecutando para linux" $GRN $DEF
    npx postject hello NODE_SEA_BLOB sea-prep.blob \
    --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2
  fi

  if [ $pas_6_os = "win_ps" ]; then
    printTitle " Ejecutando para windows power shell" $GRN $DEF
    # Ejecutando en ps este comando si funciona.
    # npx postject hello.exe NODE_SEA_BLOB sea-prep.blob `
    #  --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2
  fi

  if [ $pas_6_os = "win_cpo" ]; then
    printTitle " Ejecutando para windows command prompt" $GRN $DEF
    npx postject hello.exe NODE_SEA_BLOB sea-prep.blob ^
    --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2
  fi

  if [ $pas_6_os = "win_cp" ]; then
    printTitle " Ejecutando para windows command prompt" $GRN $DEF
    npx postject hello.exe NODE_SEA_BLOB sea-prep.blob \
    --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2
  fi

  if [ $pas_6_os = "mac" ]; then
    printTitle " Ejecutando para mac" $GRN $DEF
    npx postject hello NODE_SEA_BLOB sea-prep.blob \
    --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 \
    --macho-segment-name NODE_SEA
  fi

  printTitle "----> 6.- Inject the blob into the copied binary by running postject   with the following options: fin" $YLW $DEF 
fi

if [ $pas_7 = "y" ]; then
  printTitle "--> 7.- Sign the binary (macOS and Windows only):" $YLW $DEF 
  
  if [ $pas_7_os = "mac" ]; then
    printTitle " Ejecutando para mac" $GRN $DEF
    codesign --sign - hello
  fi
  
  if [ $pas_7_os = "w" ]; then
    printTitle " Ejecutando para windows" $GRN $DEF
    printTitle " Debe existir previamente el certificado" $GRN $DEF
    signtool sign /fd SHA256 hello.exe
  fi

  if [ $pas_7_os = "gb" ]; then
    printTitle " Ejecutando para windows en git bash" $GRN $DEF
    printTitle " Debe existir previamente el certificado" $GRN $DEF
    signtool sign //fd SHA256 hello.exe
  fi

  fileExist "hello.exe"

  printTitle "----> 7.- Sign the binary (macOS and Windows only): fin" $YLW $DEF 
fi

if [ $pas_8 = "y" ]; then
  printTitle "--> 8.- Run the binary" $YLW $DEF 

  # printf "${RED}"
  
  ./hello world --trace-warning

  printTitle "----> 8.- Run the binary. fin" $YLW $DEF 
fi

echo "pas_1: $pas_1";
echo "pas_2: $pas_2";
echo "pas_3: $pas_3";
echo "pas_4: $pas_4";
echo "pas_4_os: $pas_4_os";
echo "pas_5: $pas_5";
echo "pas_5_sh: $pas_5_sh";
echo "pas_6: $pas_6";
echo "pas_6_os: $pas_6_os";
echo "pas_7: $pas_7";
echo "pas_7_os: $pas_7_os";
echo "pas_8: $pas_8";
echo "Borrar: $borrar";




