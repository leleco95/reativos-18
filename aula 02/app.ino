#include "event_driven.h"
#include "app.h"
#include "pindefs.h"

static int state = 1;
static int now;
static int led_delay;
static int last_pressedd[2];

void appinit(void)
{
  button_listen(KEY1);
  button_listen(KEY2);
  button_listen(KEY3);
  pinMode(LED1, OUTPUT);
  pinMode(LED4, OUTPUT);
  digitalWrite(LED1, 1);
  now = millis();
  last_pressed[0] = now;
  last_pressed[1] = now;
  led_delay = 500;
  timer_set(led_delay);
}

void button_changed(int pin, int v)
{
  now = millis();
  if (pin == KEY1) {
    if (!v) {
      digitalWrite(LED1, 0);
    }
    else {
      digitalWrite(LED1, 1);
    }
  }
  else if (pin == KEY2) {
    if (!v) {
      if (now < last_pressedd[1] + 500) {
        digitalWrite(LED4, 1);
        while(1) {
          delay(1);
        }
      }
      led_delay -= 100;
      timer_set(led_delay);
      last_pressedd[0] = now;
    }
  }
  else if (pin == KEY3) {
    if (!v) {
      if (now < last_pressedd[0] + 500) {
        digitalWrite(LED4, 1);
        while(1) {
          delay(1);
        }
      }
      led_delay += 100;
      timer_set(led_delay);
      last_pressedd[1] = now;
    }
  }
}

void timer_expired(void)
{
  state = !state;
  digitalWrite(LED4, state);
  timer_set(led_delay);
}
