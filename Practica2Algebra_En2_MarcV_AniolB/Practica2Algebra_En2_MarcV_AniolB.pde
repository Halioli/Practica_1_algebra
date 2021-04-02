// VARIABLES Y OBJETOS
boid[] boidArray;
int numberOfBoids = 2;
float timeIncrement = 0.1;
PVector posLeader, posFlock, posDestination;

// FUNCIONES
// Calcula vector entre pos1 y pos2 y lo normaliza
PVector calculateUnitVector (PVector pos1, PVector pos2) {
  PVector calculatedVector = new PVector();
  float module;

  // Restamos posiciones final menos inicial
  calculatedVector.x = pos2.x - pos1.x;
  calculatedVector.y = pos2.y - pos1.y;
  calculatedVector.z = pos2.z - pos1.z;

  // Calcular el module del vector
  module = sqrt(calculatedVector.x * calculatedVector.x +
    calculatedVector.y * calculatedVector.y +
    calculatedVector.z * calculatedVector.z);

  // Normalizo
  calculatedVector.x /= module;
  calculatedVector.y /= module;
  calculatedVector.z /= module;

  println("Vector: ", calculatedVector.x, 
    calculatedVector.y, calculatedVector.z);

  // Devolver el vector
  return calculatedVector;
}

// CLASES
class boid {
  // Atributos
  PVector pos, vel;
  float mass, size, KL, KD, KB, KF;
  color colorB;
  boolean leader;  // Vale true si soy el leader y false si no

  // Constructor
  boid (PVector p, PVector v, float m, float t, color c, boolean l, 
    float cl, float cd, float cb, float cf) {
    pos = p;
    vel = v;
    mass = m;
    size = t;
    KL = cl;
    KD = cd;
    KB = cb;
    KF = cf;
    colorB = c;
    leader = l;
  }
  // Métodos
  void move() {
    // Definir variables u objetos
    PVector strenght, accel, intentionLeader, intentionFlock, intentionDestination;
    strenght = new PVector(0.0, 0.0, 0.0);
    accel = new PVector(0.0, 0.0, 0.0);
    intentionLeader = new PVector(0.0, 0.0, 0.0);
    intentionFlock = new PVector(0.0, 0.0, 0.0);
    intentionDestination = new PVector(0.0, 0.0, 0.0);

    // Calcular las intenciones
    // De momento no usaremos el atributo "leader"
    // Calculo las intenciones que actuaran como strenghts
    if (leader) {
      intentionDestination = calculateUnitVector(pos, posDestination);
    } else {
      intentionLeader = calculateUnitVector(pos, posLeader);
      intentionFlock = calculateUnitVector(pos, posFlock);
      intentionDestination = calculateUnitVector(pos, posDestination);
    }

    // Calculo la media ponderada de todas las intenciones
    // Aqui es cuando usamos las constantes!!!
    strenght.x = KL * intentionLeader.x + 
      KB * intentionFlock.x +
      KD * intentionDestination.x;
    strenght.y = KL * intentionLeader.y + 
      KB * intentionFlock.y +
      KD * intentionDestination.y;
    strenght.z = KL * intentionLeader.z + 
      KB * intentionFlock.z +
      KD * intentionDestination.z;

    println(strenght.x, strenght.y, strenght.z);

    // Añadimos la friccion
    strenght.x -= KF * vel.x;
    strenght.y -= KF * vel.y;
    strenght.z -= KF * vel.z;

    // Solver Euler

    // acceleracion
    accel.x = strenght.x / mass;
    accel.y = strenght.y / mass;
    accel.z = strenght.z / mass;

    // Velocidad
    vel.x = vel.x + accel.x * timeIncrement;
    vel.y = vel.y + accel.y * timeIncrement;
    vel.z = vel.z + accel.z * timeIncrement;

    // Posicion
    pos.x = pos.x + vel.x * timeIncrement;
    pos.y = pos.y + vel.y * timeIncrement;
    pos.z = pos.z + vel.z * timeIncrement;
  }

  void drawn() {
    strokeWeight(2);
    noFill();
    stroke(colorB);
    ellipse(pos.x, pos.y, size, size);
  }
}

// SETUP
void setup() {
  size(800, 600);
  // Llamamos a los constructores
  // de nuestros "numberOfBoids" Boids
  boidArray = new boid[numberOfBoids];

  // El primer Boid será el leader
  boidArray[0] = new boid(
    new PVector(0.0, 0.0, 0.0), 
    new PVector(0.0, 0.0, 0.0), 1.0, 10.0, 
    color(255, 0, 0), true, 
    0.0, 1.0, 0.0, 0.08);

  // El resto de boids no son leaders
  boidArray[1]= new boid(
    new PVector(width, height/2.0, 0.0), 
    new PVector(0.0, 0.0, 0.0), 1.0, 30.0, 
    color(0, 255, 0), false, 
    0.6, 0.2, 0.2, 0.08);

  // Inicializamos
  posLeader = new PVector(0.0, 0.0, 0.0);
  posFlock = new PVector(0.0, 0.0, 0.0);
  posDestination = new PVector();

  // Definimos la posición destino
  posDestination.x = width / 2.0;
  posDestination.y = height / 2.0;
  posDestination.z = 0.0;
}

// DRAW
void draw() {
  background(0);
  // El For que recorre todos los Boids
  for (int i = 0; i < numberOfBoids; i++) {
    boidArray[i].move();
    boidArray[i].drawn();
  }

  // Guardamos la nueva posicion del leader
  posLeader.x = boidArray[0].pos.x;
  posLeader.y = boidArray[0].pos.y;
  posLeader.z = boidArray[0].pos.z;

  // Calculamos otra vez el centroide de la bandada
  // Primero limpiamos
  posFlock.x = 0.0;
  posFlock.y = 0.0;
  posFlock.z = 0.0;

  // Ahora sumamos todas las posiciones de los boids
  for (int i = 0; i < numberOfBoids; i++) {
    posFlock.x += boidArray[i].pos.x;
    posFlock.y += boidArray[i].pos.y;
    posFlock.z += boidArray[i].pos.z;
  }

  // Ahora promediamos
  posFlock.x /= numberOfBoids;
  posFlock.y /= numberOfBoids;
  posFlock.z /= numberOfBoids;
}
