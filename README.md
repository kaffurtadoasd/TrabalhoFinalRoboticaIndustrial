# TrabalhoFinalRoboticaIndustrial
trabalho final de robotica industrial

%%%%%%%%%c odigo do arduino para motor de passo unipolar %%%%%%%%%%%%
int pins[] {
    8,  //IN9 on the ULN2003 Board, BLUE end of the Blue/Yellow motor coil
    9,  //IN10 on the ULN2003 Board, PINK end of the Pink/Orange motor coil
    10,  //IN11 on the ULN2003 Board, YELLOW end of the Blue/Yellow motor coil
    11   //IN12 on the ULN2003 Board, ORANGE end of the Pink/Orange motor coil
};

byte received;
int value;
byte mask = 128;

int fullStepCount = 4;
int fullSteps[][4] = {
    {HIGH,HIGH,LOW,LOW},
    {LOW,HIGH,HIGH,LOW},
    {LOW,LOW,HIGH,HIGH},
    {HIGH,LOW,LOW,HIGH}
  };

bool clockwise = true;

int targetSteps = 0; 

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);  
  
  for(int pin = 0; pin < 4; pin++) {
    pinMode(pins[pin], OUTPUT);
    digitalWrite(pins[pin], LOW);
  }
}

void step(int steps[][4], int stepCount, int currentStep) {

  int currentStepInSequence = currentStep % stepCount;
  int directionStep = clockwise ? currentStepInSequence : (stepCount-1) - currentStepInSequence;  
  for(int pin=0; pin < 4; pin++){
    digitalWrite(pins[pin],steps[directionStep][pin]);
  }  
}

void loop() {
      if(Serial.available()>0){
        int currentStep = 0;
        clockwise = true;
        received = Serial.read();
        value = (int)received;
        if (value > 64){
          clockwise = false;
          received = received - mask;
          value = (int)received;
        }
        targetSteps = value*32;
        while(true){
          if(currentStep >= targetSteps){
            break;
          }
          step(fullSteps,fullStepCount,currentStep);
          currentStep=currentStep+1;
          delay(2);
        }
      }
}
