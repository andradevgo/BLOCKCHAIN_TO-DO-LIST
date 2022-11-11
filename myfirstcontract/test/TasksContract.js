// Se realizan los test con el fin de que al ejecutar en una blockchain no se pierdan los ETH al probar el codigo
const TasksContract = artifacts.require("TasksContract");

contract("TasksContract", () => {
  before(async () => {
    this.tasksContract = await TasksContract.deployed();
  });

  it("migrate deployed successfully", async () => {
    const address = this.tasksContract.address;

    assert.notEqual(address, null);
    assert.notEqual(address, undefined);
    assert.notEqual(address, 0x0);
    assert.notEqual(address, "");
  });
  //Aqui se prueba con otra funcion para testear  la lista de tareas
  //Aqui se prueba la llamada del counter
  //Es decir si aumenta el contador
  it("get Tasks List", async () => {
    const taskCounter = await this.tasksContract.taskCounter();
    const task = await this.tasksContract.tasks(taskCounter);
    assert.equal(task.id.toNumber(), taskCounter);
    assert.equal(task.title, "Mi primer tarea de ejemplo");
    assert.equal(task.description, "Tengo que hacer algo");
    assert.equal(taskCounter, 1);
    assert.equal(task.done, false);
  });

  //Test de poder comprobar si una tarea que estoy creando funciona, es decir funciona el createtask

  it("task created successfully", async () => {
    const result = await this.tasksContract.createTask(
      "some task",
      "description two"
    );
    const taskEvent = await result.logs[0].args;
    const taskCounter = await this.tasksContract.taskCounter();

    assert.equal(taskCounter, 2);
    assert.equal(taskEvent.id.toNumber(), 2);
    assert.equal(taskEvent.title, "some task");
    assert.equal(taskEvent.description, "description two");
    assert.equal(taskEvent.done, false);
  });

  it("task toggle done", async () => {
    const result = await this.tasksContract.toggleDone(1);
    const taskEvent = result.logs[0].args;
    const task = await this.tasksContract.tasks(1);

    assert.equal(task.done, true);
    assert.equal(taskEvent.done, true);
    assert.equal(taskEvent.id, 1);
  });
});
