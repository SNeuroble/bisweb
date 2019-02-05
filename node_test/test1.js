var promise1 = new Promise(function(resolve, reject) {
    setTimeout(function() { 
        resolve('foo');
        //reject('goo');
        }, 3000);
    });

promise1.then(function(value) { 
        console.log(value);
    }).catch(
        (reason) => {
            console.log('Handle rejected promise ('+reason+') here.');
           }
    );

console.log(promise1);
