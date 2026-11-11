# SignalCalc Pro - Scientific Calculator + Signal Generator

A complete MATLAB App that combines a Scientific Calculator and a Signal Generator & Processor in one clean GUI.

Built for Signals & Systems / Engineering Lab - calculate, generate, operate and visualize signals in real-time.

## Features

### Scientific Calculator
- Basic operations: `+  -  *  /  %  ^`
- Trigonometry: `sin, cos, tan` + Inverse `sin-1, cos-1, tan-1`
- Logarithms: `log, ln`
- Powers: `x^2, x^3, x^y, e^x, 10^x`
- Special: `sqrt, cbrt, 1/x, n!, pi, Ans`
- Deg / Rad Mode Switch
- Ans memory - last answer reuse
- Bracket safety - `)` ke baghair `=` dabane pe `Error` show hota hai
- Example: `sin(30)` = `0.5`

### Signal Generator & Processor
- Signal 1 [y1(t)] - Amplitude (A1), Frequency (F1), Type
- Signal 2 [y2(t)] - Amplitude (A2), Frequency (F2), Type
- Signal Types: `Sine, Cosine, Square, Triangle, Sawtooth`
- Operations:
    - Add (y1 + y2)
    - Sub (y1 - y2)
    - Mul (y1 x y2)
    - Div (y1 / y2)
- Live Graph with 3 solid lines - `y1(t)`, `y2(t)`, `Result y(t)`
- Full Corrected Equations Display

### Equations Display Example
```text
y1(t) = 1*sin(2*pi*1*t)

y2(t) = 1*cos(2*pi*1*t)

Operation: y1 + y2

Result Equation:
y(t) = 1*sin(2*pi*1*t) + 1*cos(2*pi*1*t)

```


## How to Run

1. Download / Clone this repo
2. Open MATLAB
3. Open file `HybridCalculatorApp.m`
4. Run:
HybridCalculatorApp()
No extra setup needed. Signal Processing Toolbox required for `square` / `sawtooth`.

## Files
File | Description
HybridCalculatorApp.m | Main App - Calculator + Signal Generator
http://README.md | Project Documentation
## Used For

- Signals & Systems Lab
- DSP / Electrical Engineering Projects
- MATLAB GUI Practice
- University Assignment / Viva Demo

## Author

Made in MATLAB

## License

Free to use for learning and university projects.