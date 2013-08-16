#ifndef FALCON_REGISTER_STACK_H
#define FALCON_REGISTER_STACK_H

#include <vector>
#include <string>

#include "compiler_frame.h"

struct RegisterStack {
  std::vector<int> regs;
  std::vector<Frame> frames;
  std::vector<Frame> exc_handlers;

  RegisterStack() {
  }

  RegisterStack(const RegisterStack& other) {
    this->regs = other.regs;
    this->frames = other.frames;
  }

  void push_frame(int target);
  Frame pop_frame();

  int num_exc_handlers();
  Frame pop_exc_handler();
  void push_exc_handler(int target);

  int push_register(int reg);
  int pop_register();
  int peek_register(int reg);

  void fill_register_array(std::vector<int>&, size_t);

  std::string str();
};

#endif
