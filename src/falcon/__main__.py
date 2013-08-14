import os
import sys
import falcon

# Wrap the main function of a script and run it inside of falcon. 
def main():
  if not sys.argv[1:]:
    print 'Usage: -mfalcon <script> <args>'
    sys.exit(2)

  script = sys.argv[1]
  sys.argv = sys.argv[1:]
  
  sys.path.insert(0, os.path.dirname(script))
  with open(script, 'rb') as fp:
      code = compile(fp.read(), script, 'exec')

  e = falcon.Evaluator()
  e.eval_python(code, (), {})
  
if __name__ == '__main__':
  main()
