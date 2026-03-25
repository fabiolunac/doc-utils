# SHAPER Filters

This folder contains the files required to implement digital filters (FIR and IIR) for the SHAPER.

---

## 📂 Verilog Modules

### FIR Filter
- `FIR_filter.v`  
  Implements a parameterizable FIR filter with **N coefficients**.  
  Coefficients are loaded from an external memory file (`.mem`).

---

### IIR Filters
- `iir_ordem1.v`  
  Implements a **1st-order IIR filter**.

- `iir_ordem2.v`  
  Implements a **2nd-order IIR filter**.

Both modules compute the recursive filter response using predefined coefficients.

---