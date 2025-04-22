import camion.*

object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bulto(){return 1}
	method actuar(){}
}

object  bumblebee {
	var forma = auto
	method peso() {return 800}

	method forma(_forma){
		forma = _forma
	}

	method nivelPeligrosidad(){
		return forma.nivelPeligrosidad() 
	}
	
	method bulto(){return 2}
	method actuar(){
		self.forma(robot)
	}
}

object auto{
	method nivelPeligrosidad(){
		return 15
	}
}

object robot{
	method nivelPeligrosidad(){
		return 30
	}
}


object paqueteDeLadrillos{
	var cantidad = 0
	const bultos = #{bultoSinCarga, bultoChico, bultoMediano, bultoGrande}

	method cantidad(_cantidad){
		cantidad = _cantidad
	}

	method peso(){return 2 * cantidad}

	method nivelPeligrosidad(){return 2}

	method bulto(){
		return self.bultoDeTamanio(cantidad).bulto()
	}

	method bultoDeTamanio(_cantidad){
		return bultos.find({bulto => bulto.esBultoBuscado(_cantidad)})
	}
	method actuar(){
		cantidad += 12
	}
}

object bultoSinCarga{

	method esBultoBuscado(cantidad){
		return 0 == cantidad
	}

	method bulto(){
		return 0
	}
}

object bultoChico{

	method esBultoBuscado(cantidad){
		return 1 <= cantidad && cantidad <= 100
	}

	method bulto(){
		return 1
	}
}

object bultoMediano{
	method esBultoBuscado(cantidad){
		return 101 <= cantidad && cantidad <= 300
	}

	method bulto(){
		return 2
	}
}

object bultoGrande{
	method esBultoBuscado(cantidad){
		return cantidad >= 301
	}

	method bulto(){
		return 3
	}
}

object arenaAGranel{
	var property peso = 0

	method nivelPeligrosidad(){return 1}
	
	method bulto(){return 1}
	
	method actuar(){
		peso += 20
	}
}

object bateriaAntiaerea{
	var carga = cargaVacia

	method carga(_carga){
		carga = _carga
	}

	method peso(){
		return carga.peso()
	}

	method nivelPeligrosidad(){
		return carga.nivelPeligrosidad()
	}

	method bulto(){
		return carga.bulto()
	}

	method actuar(){
		self.carga(cargaConMisiles)
	}
}

object cargaVacia{
	method peso(){return 200}
	method nivelPeligrosidad(){return 0}
	method bulto(){return 1}
}

object cargaConMisiles{
	method peso(){return 300}
	method nivelPeligrosidad(){return 100}
	method bulto(){return 2}
}


object contenedorPortuario{
	const cosas = #{}

	method cargar(cosa) {
		cosas.add(cosa)
	}

	method descargar(cosa){
		cosas.remove(cosa)
	}

	method peso(){
		return 100 + cosas.sum({cosa => cosa.peso()})
	}

	method nivelPeligrosidad(){
		return if (cosas.isEmpty()) {0} else {self.cosaConMayorNivel().nivelPeligrosidad()}
	}

	method cosaConMayorNivel(){
		return cosas.max({cosa=>cosa.nivelPeligrosidad()})
	}

	method bulto(){
		return 1 + cosas.sum({cosa => cosa.bulto()})
	}

	method actuar(){
		cosas.forEach({cosa => cosa.actuar()})
	}
}

object residuosRadioactivos {
	var property peso = 0

	method nivelPeligrosidad(){
		return 200
	}

	method bulto(){return 1}

	method actuar(){
		peso += 15
	}
}

object embalajeDeSeguridad {
	var cosa = vacio

	method cosa(_cosa){
		cosa = _cosa
	}

	method peso(){
		return cosa.peso()
	}
	
	method nivelPeligrosidad(){
		return cosa.nivelPeligrosidad() / 2
	}

	method bulto(){return 2}

	method actuar(){}
}

object vacio{
	method peso(){
		return 0
	}

	method nivelPeligrosidad(){
		return 0
	}
}

// Almacen
object almacen {
	var property disponibilidad = 0
	const cosas = #{}

	method almacenar(cosa) {
		cosas.add(cosa)
		disponibilidad += cosa.capacidad()
	}

	method retirar(cosa){
		cosas.remove(cosa)
		disponibilidad -= cosa.capacidad()
	}


}


// Rutas

object ruta9{
	const peligrosidadMaxima = 9

	method peligrosidadMaxima(){
		return peligrosidadMaxima
	}

	method permiteCircularA(vehiculo){
		return !vehiculo.superaNivelDePeligrosidad(peligrosidadMaxima)
	}
}

object caminosVecinales {
	var property pesoMaximo = 0

	method permiteCircularA(vehiculo){
		return vehiculo.pesoTotal() < pesoMaximo
	}
}