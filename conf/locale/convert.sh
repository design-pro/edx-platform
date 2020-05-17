# for file in ./edx-platform/locale/*/*/*.po; do msgfmt $file -o $(dirname file)"/"$(basename ${file%.*}".mo"); done;
for file in ./fa/*/*.po; do msgfmt $file -o $(dirname $file)/$(basename ${file%.*}).mo; done;
