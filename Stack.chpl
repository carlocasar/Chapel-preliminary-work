

/*
  This module provides a stack.
*/
module Stack {


class StackNode {
  type eltType;
  var data: eltType;
  var next: StackNode(eltType);
}

record stack {
  /*
    The type of the data stored in every node.
  */
  type eltType;
  /* 
  references the last Node of the stack 
  */
  var last: StackNode(eltType);
  /*
    The number of nodes in the Stack.
  */
  var length: int;
  
  /* 
  Var to use as block
  */
  var lock: sync bool;
  var unlock: bool;
  
  /*
    Synonym for length.
  */
  proc size {
    lock = true;
    var aux = length;
    unlock = lock;
    return aux;
  }
   /*
    Inserts an element to the top of the stack
   */
  proc ref push(e : eltType) {
    lock = true;
    last = new StackNode(eltType, e, last);
    length += 1;
    unlock = lock;
  }
  
   /*
    Returns the top element of the stack
   */
  proc top {
    lock = true;
    var aux = last.data;
    unlock = lock;
    return aux;
  }
  
   /*
    Returns True if the stack is empty, false otherwise
   */
  proc empty{
    lock = true;
    if(length == 0){
      unlock = lock;
      return true;
    }
    else{
      unlock = lock;
      return false;
    }
  }
    /*
     Remove the last element from the stack and return it.
     It is an error to call this function on an empty stack.
   */
  proc pop {
    if length < 1 then halt("pop on empty stack");
    lock = true;
    var oldLast = last;
    var ret = last.data;
    last = last.next;
    length -= 1;
    delete oldLast;
    unlock = lock;
    return ret;
  }
  
  
  
  }//end of record stack
}//end of module stack


/*
  Main module to check the correct function of the module
*/
module MainModule {
  proc main() {
    use Stack;
    var stack1 = new stack(int);

    writeln(stack1.empty);
    stack1.push(10);
    stack1.push(20);
    writeln(stack1.top);
    writeln(stack1.size);
    writeln(stack1.empty);
    writeln(stack1.pop);
    writeln(stack1.size);
    writeln(stack1.top);
    
      

  }
  
  }

 




