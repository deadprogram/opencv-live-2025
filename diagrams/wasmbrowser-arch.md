```mermaid
flowchart
    subgraph "V8"
    HTML-->Javascript;
    Javascript-->JSShim[WASM Javascript loader];
    Javascript-->JSRuntime[JS Browser Runtime];
    end
    subgraph "WebAssembly engine"
    WASM[compiled .WASM file]-->WASMRuntime[Browser WASM Runtime];
    end
    JSShim-->WASM
```
