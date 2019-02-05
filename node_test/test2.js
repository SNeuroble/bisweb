var promise1 = Promise.resolve([1, 2, 3]);

promise1.then(function(value) {
    console.log(mean(value));
    });

function mean(arr){
  if(arr.length){
    return arr.reduce(function(a, b) { return a + b; })/arr.length;
  }else{
    return 0;
  }
};

