#!/bin/bash
#AGENDA
#Autor:Iván Domínguez Repoller
#Fecha:04-02-25

clear


AGENDA="agenda.txt"
agregar_entrada(){
	read -p "Introduce el DNI: " dni
if grep -q "^dni:" "$AGENDA"; then
	echo "La persona con DNI $dni ya está registrada en la agenda."
else
	read -p "Introduce el nombre: " nombre
	read -p "Introduce los apellidos: " apellidos
	read -p "Introduce la localidad: " localidad
	echo "$dni:$nombre:$apellidos:$localidad" >> "$AGENDA"
	echo "Entrada añadida con éxito."
fi
}

buscar_por_dni(){
	read -p "Introduce el DNI a buscar: " dni
	resultado=$(grep "^$dni:" "$AGENDA")
if [ -z "$resultado" ]; then
	echo "No se encontró ninguna persona con DNI $dni."
else
	nombre=$(echo "$resultado" | cut -d ':' -f2)
	apellidos=$(echo "$resultado" | cut -d ':' -f3)
	localidad=$(echo "$resultado" | cut -d ':' -f4)
	echo "La persona con DNI número $dni es: $nombre $apellidos, y vive en $localidad."
fi
}

ver_agenda(){
	>"$AGENDA"
	echo "Todas las entradas han sido eliminadas."
}

while true; do
	echo -e "\n--- MENÚ DE AGENDA ---"
	echo "a) Agregar una entrada"
	echo "b) Buscar por DNI"
	echo "c) Ver la agenda completa"
	echo "d) Eliminar todas las entradas de la agenda"
	echo "e) Finalizar"
	read -p "Elige una opción: " opcion
case $opcion in
	a) agregar_entrada
	;;
	b) buscar_por_dni
	;;
	c) ver_agenda
	;;
	d) eliminar_agenda
	;;
	e) echo "Saliendo..."; break
	;;
	*) echo "Opción no válida, vuelve a intentarlo."
	;;
esac
done
