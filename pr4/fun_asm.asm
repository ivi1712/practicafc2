/*---------------------------------------------------------------------
**
**  Fichero:
**    fun_asm.c  19/10/2022
**
**    (c) Daniel Báscones García
**    Fundamentos de Computadores II
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Propósito:
**    Fichero de código para la práctica 4
**
**-------------------------------------------------------------------*/


//rellenar con directivas .extern y .global
//con las funciones apropiadas
.global eucl_dist
.global guardar
.extern mul
.extern i_sqrt
.extern _stack

main:
	la sp , _stack

//int eucl_dist(int * w, int size);
eucl_dist:
    //recibo dirección de W en a0, y tamaño N en a1
    //realizo los cálculos pertinentes
    //devuelvo el resultado en a0
	mv t1, a0  // t1 = W = a0
	mv t2, a1 // t2 = N = a1
	li t3, 0 // i = 0
	li t4, 0 // t4 = acc
for_eucl:
	bge t3, t2, efor
	// a0 = w[i]
	// a1 = w[i]
	slli a0, t3, 2
	add a0, t1, a0
	lw a0, 0(a0)
	addi sp , sp , -20
	sw ra , 16(sp)
	sw t4 , 12(sp)
	sw t3 , 8(sp)
	sw t2 , 4(sp)
	sw t1 , 0(sp)
	call mul
	// a0 = int res
	lw ra , 16(sp)
	lw t4 , 12(sp)
	lw t3 , 8(sp)
	lw t2 , 4(sp)
	lw t1 , 0(sp)
	addi sp , sp , 20
	add t4, t4, a0
	addi t3, t3, 1
	j for_eucl
efor:
	mv a0, t4
	addi sp , sp , -20
	sw ra , 16(sp)
	sw t4 , 12(sp)
	sw t3 , 8(sp)
	sw t2 , 4(sp)
	sw t1 , 0(sp)
	call i_sqrt
	lw ra , 16(sp)
	lw t4 , 12(sp)
	lw t3 , 8(sp)
	lw t2 , 4(sp)
	lw t1 , 0(sp)
	addi sp , sp , 20
	ret

guardar:
	//int guardar(char valor, char * ubicacion);
    //recibo el valor en a0, y la dirección destino en a1
    //asegurarse que sólo se guarda UN BYTE!!
    //mv a0, t1 // a0 = t1 = valor
    //mv a1, t2 // a1 = t2 = ubicacion
    sb a0, 0(a1)
    ret


