
source env.sh

GBC=gbc-simple
RENDERER=ur

export FGLGBCDIR=../gbc/gbc-current/dist/customization/$GBC
export FGLIMAGEPATH=..:../pics:$FGLDIR/lib/image2font.txt
export FGLPROFILE=../etc/profile.$RENDERER
export FGLRESOURCEPATH=../etc

cd bin$GENVER
fglrun simpleDemo.42r
