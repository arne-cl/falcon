#ifndef FALCON_REGISTER_STACK_H
#define FALCON_REGISTER_STACK_H

#include <vector>
#include <string>

#include "compiler_frame.h"

struct RegisterStack {
public:
  std::vector<int> regs;
  std::vector<Frame> frames;

  RegisterStack() {
  }

  RegisterStack(const RegisterStack& other) {
    this->regs = other.regs;
    this->frames = other.frames;
  }

  void push_frame(int target, bool exc_handler = false);
  Frame pop_frame();
  Frame pop_exc_handler();

  int num_exc_handlers();

  int push_register(int reg);
  int pop_register();
  int peek_register(int reg);

  void fill_register_array(std::vector<int>&, size_t);

  int num_registers() {
    return regs.size();
  }

  std::string str();
};

#endif
