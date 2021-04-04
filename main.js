
let exports;
var importObject = {
    env: {
        _slowAdd(a, b, frame) {
            console.log("slowAddJS", { a, b, frame });
            setTimeout(() => {
                console.log("Calling zig callback...")
                exports.onSlowAdd(frame, a + b);
            }, 100);
        },
        print(a) {
            console.log("print", { a });
        }
    }
};

WebAssembly.instantiateStreaming(fetch('main.wasm'), importObject)
    .then(obj => {
        exports = obj.instance.exports;
        console.log("Calling zig main via wasm...")
        exports.main()
    });
