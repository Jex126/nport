#!/bin/bash
cant=0
arch=0
function ayuda(){
echo -e "banderas:\n-a [archivo] : copia en la clipboard los puertos abiertos\n-t : indica cuantos puertos TCP se econtraron abiertos\n-h : ayuda"
}
function nmaparch (){
cat "$1" | grep --only-matching -E "(.|..|...)/open" | grep -o -E "[0-9]|[0-9][0-9]|[0-9][0-9][0-9]" | sed ':inicio ; N ; $! b inicio; s/\n/,/g' | xclip -selection clipboard
}  
function numtcp(){
ntcp=$(cat "$1" | grep -i "ports" | grep -o "tcp/" | wc -l)
 echo "N° de puertos TCP abiertos: $ntcp"
}

while getopts :a:th opt;
do
    case "${opt}" in
        a) arch=${OPTARG};;
        t) cant=1;;
        h) ayuda;;
        *) ayuda;;
    esac
done

if [ "$arch" != 0 ]; then
    nmaparch "$arch"
fi

if [ $cant -eq 1 ]; then
    numtcp "$arch"
fi

if [ $# -eq 0 ]; then
    ayuda
fi