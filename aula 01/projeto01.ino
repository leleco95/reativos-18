#define KEY1 A1
#define KEY2 A2
#define KEY3 A3
#define LED_PIN 11

int state = 1;
unsigned long old;
unsigned long old_button1;
unsigned long old_button2;
int led_delay = 1000;

void setup() {
  // put your setup code here, to run once:
  pinMode(KEY1, INPUT_PULLUP);
  pinMode(KEY2, INPUT_PULLUP);
  pinMode(KEY3, INPUT_PULLUP);
  pinMode(LED_PIN, OUTPUT);
  old = old_button1 = old_button2 = millis();
}

void loop() {
  // put your main code here, to run repeatedly:
  
  unsigned long now = millis();
  if (now >= old+led_delay) {
    old = now;
    state = !state;
    digitalWrite(LED_PIN, state);
  }
  
  int but1 = digitalRead(KEY1);
  if (!but1 && now >= old_button1+300) {
    if (now < old_button2+500) {
      while(1);
    }
    led_delay -= 100;
    old_button1 = now;
  }
  
  int but2 = digitalRead(KEY2);
  if (!but2 && now >= old_button2+300) {
    if (now < old_button1+500) {
      while(1);
    }
    led_delay += 100;
    old_button2 = now;
  }
}
