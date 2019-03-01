# A simple demo that uses a WebComponent and a custom GBC and a Java source file

Goal is to be able to build and run using:
* Linux command line with a makefile
* Genero Studio

Also to be able to build and deploy as a GAR file and the custom GBC zip.

NOTE: The env.sh script checks the environment and reports the versions found and warns for any missing prerequisites.

Instructions:
* download or clone the repo
* set your Genero environment
* cd simpleWCGBCdemo
* . env.sh
* make run
or
* make deploy
* make deploygbc
then run via the GAS.

eg:
```
$ . env.sh 
Enter full path to current gbc project extract folder ?
/opt/fourjs/gbc-1.00.51-project
[1]+  Done                    gdc -a -D -M --port $GDCPORT 2> gdc.err > gdc.log  (wd: /opt/fourjs/gst-3.20.02/gdc/logs)
(wd now: /tmp/t/simpleWCGBCdemo)
Genero is 3.20
Java javac 1.8.0_191 JVM is /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server/libjvm.so
GBC 1.00.51
NODEJS v8.15.0 + grunt-cli v1.2.0
```

Build and dpeloy the GAR to the local GAS
```
$ make deploy
mkdir bin320
cd bin320 && rm -f webcomponents && ln -s ../webcomponents
javac -d bin320 java/simple.java
gsmake simpleWCGBCdemo320.4pw
[   0% ] *** Building 'project 'simpleWCGBCdemo320.4pw'' [00:38:36] ***
[   0% ] Building using setup GSTSETUPDIR="/opt/fourjs/gst-3.20.02/gst/bin/src/ag/tpl/dbapp4.1"
[  23% ] The 'etc' node contains no file to link. Nothing to link.
[  46% ] The 'simpleWC' node contains no file to link. Nothing to link.
[  51% ] Compiling '/tmp/t/simpleWCGBCdemo/src/form.per'
[  56% ] Compiling '/tmp/t/simpleWCGBCdemo/src/main.4gl'
[  57% ] Linking 'simpleDemo'
[  68% ] The 'xcf' node contains no file to link. Nothing to link.
[  93% ] Packaging '/tmp/t/simpleWCGBCdemo/distbin320/simpleWCGBCdemo'
[  94% ] ::info:(GS-09007) Packaging directories
[ 100% ] *** Success [00:38:36] ***
gasadmin gar -f /opt/fourjs/gst-3.20.02/gas/etc/new_as320.xcf --deploy-archive distbin320/simpleWCGBCdemo.gar
Command succeeded.

Found application simpleWCGBCdemo.xcf.
Optimizing by compressing static resources...
Archive simpleWCGBCdemo.gar successfully deployed.
gasadmin gar -f /opt/fourjs/gst-3.20.02/gas/etc/new_as320.xcf --enable-archive simpleWCGBCdemo
Command succeeded.

Archive root: /opt/fourjs/gst-3.20.02/gas/appdata/deployment/simpleWCGBCdemo-20190301-003836
Install application simpleWCGBCdemo.xcf into /opt/fourjs/gst-3.20.02/gas/appdata/app
Archive simpleWCGBCdemo successfully enabled.
```

Build and deploy the GBC to the local GAS
```
$ make deploygbc
cd gbc && make
make[1]: Entering directory '/tmp/t/simpleWCGBCdemo/gbc'
ln -s /tmp/t/simpleWCGBCdemo/gbc/gbc-simple gbc-current/customization/gbc-simple
cd gbc-current && grunt --customization=customization/gbc-simple --compile-mode=prod --create-zip
Running "node_version" task
Using node 8.15.0
(Project requires node >=8.9.0)

Running "__clean:localdist" (__clean) task
>> 0 paths cleaned.

Running "__touch-default" task

Running "concat:clientlibs" (concat) task

Running "templates2js:compile" (templates2js) task
Successfully converted 1 html templates to js.

Running "__localesdeploy:files" (__localesdeploy) task

Running "copy:jsbootstrap" (copy) task
Copied 1 file

Running "uglify:prod" (uglify) task
>> 1 file created 3.18 MB → 1.21 MB

Running "uglify:prod_templates" (uglify) task
>> 1 file created 44.45 kB → 34.35 kB

Running "uglify:prod_locales" (uglify) task
>> 1 file created 27.75 kB → 26.43 kB

Running "copy:version" (copy) task
Copied 1 file

Running "copy:productinfo" (copy) task
Copied 1 file

Running "copy:droidFonts" (copy) task
Copied 12 files

Running "copy:materialIcons" (copy) task
Copied 5 files

Running "copy:resources" (copy) task
Created 15 directories, copied 64 files

Running "copy:customizationResources" (copy) task
Created 1 directory, copied 1 file

Running "themes:compile" (themes) task

    Building theme default
Copy resources from /opt/fourjs/gbc-1.00.51-project/theme/platform/desktop ... not found
Writing dist/customization/gbc-simple/themes/default/main.css ... ok.

    Building theme highcontrast
Copy resources from /opt/fourjs/gbc-1.00.51-project/theme/platform/desktop ... not found
Copy resources from /opt/fourjs/gbc-1.00.51-project/theme/colors/highcontrast ... not found
Writing dist/customization/gbc-simple/themes/highcontrast/main.css ... ok.

    Building theme default_mobile
Copy resources from /opt/fourjs/gbc-1.00.51-project/theme/platform/mobile ... ok
Writing dist/customization/gbc-simple/themes/default_mobile/main.css ... ok.

    Building theme highcontrast_mobile
Copy resources from /opt/fourjs/gbc-1.00.51-project/theme/platform/mobile ... ok
Copy resources from /opt/fourjs/gbc-1.00.51-project/theme/colors/highcontrast ... not found
Writing dist/customization/gbc-simple/themes/highcontrast_mobile/main.css ... ok.

Running "replace:index" (replace) task

Running "replace:bootstrap" (replace) task

Running "gitinfo" task

Running "replace:version" (replace) task

Running "replace:prod" (replace) task

Running "compress:makegz" (compress) task
>> Compressed 95 files.

Running "compress:archive" (compress) task
>> Compressed 220 files.

Done.


Execution Time (2019-03-01 00:38:43 UTC-0)
loading tasks          472ms  ▇▇▇▇▇▇ 5%
uglify:prod             6.5s  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 69%
uglify:prod_templates   95ms  ▇▇ 1%
themes:compile          1.3s  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 14%
compress:makegz        266ms  ▇▇▇▇ 3%
compress:archive       588ms  ▇▇▇▇▇▇▇▇ 6%
Total 9.4s

rm -f gbc-simple.zip && ln -s gbc-current/archive/fjs-gbc-1.00.51-build201903010038-customization_gbc-simple.zip gbc-simple.zip;
make[1]: Leaving directory '/tmp/t/simpleWCGBCdemo/gbc'
cd gbc && make deploy
make[1]: Entering directory '/tmp/t/simpleWCGBCdemo/gbc'
gasadmin gbc -f /opt/fourjs/gst-3.20.02/gas/etc/new_as320.xcf --deploy gbc-simple.zip
Command succeeded.

GBC gbc-simple.zip deployed
make[1]: Leaving directory '/tmp/t/simpleWCGBCdemo/gbc'


```

