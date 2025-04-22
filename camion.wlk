import cosas.*

object camion {
	const property cosas = #{}
	const tara = 1000

	method cargar(cosa) {
		cosas.add(cosa)
		cosa.actuar()
	}

	method descargar(cosa){
		cosas.remove(cosa) //ver que pasa si no está
	}

	method todoPesoPar(){
		return cosas.all({cosa => cosa.peso().even()})
	}

	method hayAlgunoQuePesa(peso){
		return cosas.any({cosa => cosa.peso() == peso})
	}

	method elDeNivel(nivel){
		return cosas.find(
			{cosa => cosa.nivelPeligrosidad() == nivel})
	}

	method pesoTotal(){
		return tara + cosas.sum({cosa => cosa.peso()})
	}

	method excedidoDePeso(){
		return self.pesoTotal() > 2500
	}

	method objetosQueSuperanPeligrosidad(nivel){
		return cosas.filter(
			{cosa => cosa.nivelPeligrosidad() > nivel})
	}

	method objetosMasPeligrososQue(cosa){
		return self.objetosQueSuperanPeligrosidad(cosa.nivelPeligrosidad())
	}

	method puedeCircularEnRuta(nivelMaximoPeligrosidad){
		return !self.excedidoDePeso()
			&& !self.superaNivelDePeligrosidad(nivelMaximoPeligrosidad)
	}

	method superaNivelDePeligrosidad(nivelMaximoPeligrosidad){
		return cosas.any(
			{cosa => cosa.nivelPeligrosidad() > nivelMaximoPeligrosidad})
	}

	// Agregados al Camión

	method tieneAlgoQuePesaEntre(min, max){
		return cosas.any({cosa => cosa.peso().between(min, max)})
	}

	method cosaMasPesada(){
		return cosas.max({cosa => cosa.peso()})
	}

	method pesos(){
		return cosas.map({cosa => cosa.peso()})
	}

	method totalBultos(){
		return cosas.sum({cosa => cosa.bulto()})
	}


	// Transporte

	method transportar(destino, camino){
		return !self.excedidoDePeso() 
			&& self.puedeDescargarEn(destino)
			&& self.puedeCircularPor(camino)
	}

	method puedeDescargarEn(destino){
		return self.totalBultos() <= destino.disponibilidad()
	}

	method puedeCircularPor(camino){
		return camino.permiteCircularA(self)
	}

}
