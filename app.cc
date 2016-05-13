#include <cstdlib>
#include <iostream>
#include <fstream>
#include <iterator>

[[ noreturn ]] static void panic() {
    std::exit(EXIT_FAILURE);
}

int main(int argc, char** argv) {
  if (argc != 2)
    panic();

  std::ifstream in{argv[1], std::ios::binary};

  if (!in)
    panic();

  std::copy(std::istreambuf_iterator<char>{in}, {},
      std::ostreambuf_iterator<char>(std::cout));
}
