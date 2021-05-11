
# Este script está echo para descomprimir cualquier fichero teniendo en cuenta que dicho fichero puede estar
# comprimido varias veces. 


nombre=$1
ficherosDescomprimidos="El fichero se ha descomprimido en:"

# Comprobación fichero de descompresion
7z l $nombre > /dev/null 2>&1


if [ $? -eq 0 ]
then
    # Si el código es 0, significará que el fichero se puede descomprimir por lo que cogeremos el fichero resultante
    # que nos aporta la opcion "l" de 7z para continuar comprobando si se puede descomprimir
    ficheroDescomprimir=$(7z l $nombre > /dev/null 2>&1 | grep -A 2 "Name" | awk '(NR==3) {print $NF}')

    while  [ $ficheroDescomprimir ]
    do
        # Continuaremos descomprimiendo el fichero hasta que éste no pueda descomprimirse más
        7z x $nombre > /dev/null 2>&1

        nombre=$fcheroDescomprimira
        ficherosDescomprimidos="$ficherosDescomprimidos ->$nombre"
        ficheroDescomprimir=$(7z l $nombre > /dev/null 2>&1 | grep -A 2 "Name" | awk '(NR==3) {print $NF}')

    done

    echo " <<< El fichero ha sido descomprimido >>>"
    echo $ficherosDescomprimidos
    echo

    echo " --  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  -- "
    echo " -- El fichero final descomprimido es: $nombre"
    echo " --  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  -- "

else
    echo "El fichero no se puede descomprimir o ha indicado una ruta inválida"
fi

