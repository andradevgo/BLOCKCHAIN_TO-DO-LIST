// ESTE CONTRATO LO QUE VA A HACER ES PODER PERMITIRME CREAR
// UN CRUD

// Se define la version del solidity y su licencia

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract TasksContract {
    uint256 public taskCounter = 0;
    // Se declaran variables


    constructor(){
        createTask("Mi primer tarea de ejemplo", "Tengo que hacer algo");
    }

    //SE CREA UN EVENTO
    //ES COMO CREAR UN LOG
    event TaskCreated(
        uint id,
        string title,
        string description,
        bool done,
        uint createdAt
    );

    event TaskToggleDone(uint id, bool done);

    //struct es un nuevo tipo de dato donde se crea la tarea
    struct Task {
        uint256 id;
        string title;
        string description;
        bool done;
        uint256 createdAt;
    }
    // Se define una lista de tareas o se crea un arreglo
    // mapping cunjunto de datos clave-valor
    // uint es un entero sin signos negativos
    //256 bytes
    mapping(uint256 => Task) public tasks;

    //ESTOS SOLO SE GUARDAN EN MEMORIA
    //SE AÑADE LA PALABRA CLAVE MEMORY
    //Se le pone guion antes de title ya que es un parametro que solo
    //va a servir en la funcion para variables privadas
    //CREA TAREA
        //Las tareas empezarán en 1
        // block.timestamp guarda el tiempo en el que se guarda la tarea
        //SE EMITE EL LOG
    function createTask(string memory _title, string memory _description) public{
        taskCounter++;
        tasks[taskCounter] = Task(taskCounter,_title,_description,false,block.timestamp);
        emit TaskCreated(taskCounter, _title, _description, false, block.timestamp);
        
    }

    //ACTUALIZA ESTADO TAREA
    function toggleDone(uint256 _id) public {
        Task memory _task = tasks[_id];
        //De la tarea que se quiere actualizar se quiere cambiar el dato booleano
        //Se esta buscando la lista de tareas
        _task.done = !_task.done;
        tasks[_id] = _task;

        emit TaskToggleDone(_id, _task.done);
    }
}
