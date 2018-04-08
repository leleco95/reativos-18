#include "pindefs.h"
#include <avr/sleep.h>
#include <avr/power.h>

volatile int buttonChanged = 0;

void enterSleep() {
  set_sleep_mode(SLEEP_MODE_PWR_DOWN);
  sleep_enable();
  sleep_mode();
  sleep_disable();
}

void pciSetup(byte pin) {
  *digitalPinToPCMSK(pin) |= bit (digitalPinToPCMSKbit(pin));
  PCIFR |= bit (digitalPinToPCICRbit(pin));
  PCICR |= bit (digitalPinToPCICRbit(pin));
}

ISR (PCINT1_vect) {
  buttonChanged = 1;
}

void setup() {
  pinMode(LED1, OUTPUT); pinMode(LED2, OUTPUT);
  digitalWrite(LED1, HIGH); digitalWrite(LED2, HIGH);
  pinMode(KEY1, INPUT_PULLUP);
  pinMode(KEY2, INPUT_PULLUP);
  pinMode(KEY3, INPUT_PULLUP);

  pciSetup(KEY1); pciSetup(KEY2); pciSetup(KEY3);

  Serial.begin(9600);
}

void loop() {
  Serial.println("!");
  enterSleep();
  if (buttonChanged) {
      digitalWrite(LED1, digitalRead(KEY1));
      digitalWrite(LED2, digitalRead(KEY2));
      buttonChanged = 0;
  }
}

