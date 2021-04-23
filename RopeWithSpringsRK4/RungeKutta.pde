// dx/dt = y --> func1
float func1(float X1) {
  return X1;
}

// dy/dt = u * (1 - x^2) * y - x
float func2(float t, float X1, float X2, float U1) {
  float F2 = U1 * (1 - pow(X2, 2)) * X1 - X2;

  return F2;
}

// X[1] = Y Posn, X[2] = X Posn

// VARIABLES
float time;  //t
float timeInc;  //dt
float timeFinal;  //FT
static int stateNumb = 2;  //N
static int inputsNumb = 1;  //M
//float X[];
float X1;
float X2;
//float U[];
float U1;

// RK4 const
static float a1 = 0.166;
static float a2 = 0.333, a3 = 0.333;
static float a4 = 0.166;

// Function aproximators
float K1, K2, K3, K4;
float L1, L2, L3, L4;

void setupRK() {
  //size(500, 800, P3D);

  time = 0.0;
  //timeInc = 0.01;
  timeFinal = 150;

  X1 = 0.01;
  X2 = 0.0;
}

void drawRK() {
  //while (time <= timeFinal) {

  // input
  U1 = sin(pow(time, 0.2));

  // placeholders
  float time2 = time + 0.5 * timeInc;
  float time3 = time + timeInc;

  // forward iterations
  K1 = timeInc * func1(Y);
  L1 = timeInc * func2(time, Y, X, U1);

  K2 = timeInc * func1(Y + 0.5 * L1);
  L2 = timeInc * func2(time2, Y + 0.5 * L1, X + 0.5 * K1, U1);

  K3 = timeInc * func1(Y + 0.5 * L2);
  L3 = timeInc * func2(time2, Y + 0.5 * L2, X + 0.5 * K2, U1);

  K3 = timeInc * func1(Y + L3);
  L3 = timeInc * func2(time3, Y + L3, X + K3, U1);

  // update X-position
  X2 = X2 + a1 * (K1 + K4) + a2 * (K2 + K3);

  // update Y-position
  X2 = X2 + a1 * (L1 + L4) + a2 * (L2 + L3);

  println(time + ", " + X + ", " + Y + ", " + U1 + "\n");
  //time += timeInc;
  //}
}
