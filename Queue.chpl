

/*
  This module provides a queue.
*/
module Queue {


class QueueNode {
  type eltType;
  var data: eltType;
  var next: QueueNode(eltType);
}

record queue {
  /*
    The type of the data stored in every node.
  */
  type eltType;
  /* 
  references the last Node of the stack 
  */
  var first: QueueNode(eltType);
  var last: QueueNode(eltType);
  /*
    The number of nodes in the queue.
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
    Inserts an element to the back of the queue
   */
  proc ref push(e : eltType) {
    lock = true;
    if last {
      last.next = new QueueNode(eltType, e);
      last = last.next;
    } 
    else {
      first = new QueueNode(eltType, e);
      last = first;
    }
    length += 1;
    unlock = lock;
  }
  
   /*
    Returns the first element of the queue
   */
  proc front {
    lock = true;
    var aux = first.data;
    unlock = lock;
    return aux;
  }
  
   /*
    Returns the last element of the queue
   */
  proc back {
    lock = true;
    var aux = last.data;
    unlock = lock;
    return aux;
  }
  
   /*
    Returns True if the queue is empty, false otherwise
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
     Remove the first element from the queue and return it.
     It is an error to call this function on an empty queue.
   */
  proc pop {
    if length < 1 then halt("pop on empty queue");
    lock = true;
    var oldfirst = first;
    var newfirst = first.next;
    var ret = oldfirst.data;
    first = newfirst;
    if last == oldfirst then last = newfirst;
    length -= 1;
    unlock = lock;
    return ret;
  }
  
  
  
  }//end of record queue
}//end of module queue


/*
  Main module to check the correct function of the module
*/
module MainModule {
  proc main() {
    use Queue;
    var queue1 = new queue(int);

    writeln(queue1.empty);
    queue1.push(10);
    queue1.push(20);
    writeln(queue1.front);
    writeln(queue1.size);
    writeln(queue1.empty);
    writeln(queue1.pop);
    writeln(queue1.size);
    writeln(queue1.front);
    queue1.push(30); 
    queue1.push(40);
    writeln("the front: " + queue1.front);
    writeln("the back: " + queue1.back);

  }
  
  }

 