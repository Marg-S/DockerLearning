#include <fcgi_stdio.h>

int main() {
  while (FCGI_Accept() >= 0) {
    printf("Content-Type: text/plain\r\n\r\n");
    printf("Hello World!\n");
  }
  return 0;
}
