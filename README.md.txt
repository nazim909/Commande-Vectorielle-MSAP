# Field-Oriented Control (FOC) of a Permanent Magnet Synchronous Motor (PMSM)

This repository contains a MATLAB/Simulink project focusing on the modeling, controller synthesis, and vector control of a Permanent Magnet Synchronous Motor (PMSM) supplied by a PWM voltage source inverter. 

This work was conducted at the École Nationale Polytechnique (ENP) of Algiers (Department of Electrical Engineering, 4th year, Academic Year 2025 - 2026) by Mohamed Nazim ABBAD under the supervision of Pr. MO MAHMOUDI.

---

## 1. Project Overview & Objectives

The goal of this study is to implement a high-performance variable-speed drive for a Permanent Magnet Synchronous Motor (PMSM/MSAP). Because the PMSM is a multivariable, coupled, and non-linear system, decoupled control of flux and torque is achieved through Field-Oriented Control (FOC) with the $i_d = 0$ strategy.

The study is conducted on a **1.38 kW PMSM** with the following nominal parameters:
* **Stator Resistance ($R_s$)**: $0.8\ \Omega$
* **d-axis Inductance ($L_d$)**: $1.10\text{ mH}$
* **q-axis Inductance ($L_q$)**: $1.32\text{ mH}$
* **Rotor Flux ($\Phi_f$)**: $1.5\text{ Wb}$
* **Moment of Inertia ($J$)**: $1.15 \times 10^{-3}\text{ kg}\cdot\text{m}^2$
* **Viscous Friction ($f_r$)**: $0.59 \times 10^{-4}\text{ N}\cdot\text{m}/(\text{rad/s})$
* **Pole Pairs ($p$)**: $2$

---

## 2. PMSM Mathematical Modeling

### Park Transformation
The $abc$ reference frame equations are converted into the $d-q$ rotating reference frame using the Park transformation:

$$V_d = R_s i_d + L_d \frac{di_d}{dt} - \omega_r L_q i_q$$

$$V_q = R_s i_q + L_q \frac{di_q}{dt} + \omega_r (L_d i_d + \Phi_f)$$

The electromagnetic torque is expressed as:

$$T_{em} = p \left[ \Phi_f i_q + (L_d - L_q) i_d i_q \right]$$

Using the $i_d = 0$ strategy for a surface-mounted (smooth rotor) PMSM ($L_d \approx L_q$), the torque becomes directly proportional to the quadrature current $i_q$:

$$T_{em} = p \cdot \Phi_f \cdot i_q = 3 \cdot i_q$$

---

## 3. Controller Synthesis & Tuning

The control structure uses cascaded loops: an inner fast current loop and an outer slower speed loop.

### Current Regulators ($i_d$, $i_q$)
The PI controllers for the $d$ and $q$ axes are designed using the **pole-zero cancellation method** to achieve a first-order closed-loop transfer function with a desired response time $T_{ri} = 1\text{ ms}$:
* **Proportional Gain ($K_{pd}$)**: $3.3$ | **Integral Gain ($K_{id}$)**: $2400$
* **Proportional Gain ($K_{pq}$)**: $3.96$ | **Integral Gain ($K_{iq}$)**: $2400$

### Speed Regulator ($\Omega$)
Designed using **pole placement** with an optimal damping ratio $\xi = 0.707$ and natural frequency $\omega_n = 100\text{ rad/s}$:
* **Proportional Gain ($K_{p\Omega}$)**: $0.0766$ | **Integral Gain ($K_{i\Omega}$)**: $7.66$
* *Anti-Windup protection* is integrated into the PI block to prevent integrator saturation during speed transients.

---

## 4. Simulation Results & Waveform Analysis

### 4.1. Open-Loop Simulation (Boucle Ouverte - BO)
In open loop, the autopilot system aligns the rotor flux but has no speed regulation. A load torque of $C_r = 4\text{ Nm}$ is applied at $t = 0.5\text{ s}$.

* **Observations**:
  * Extreme starting currents reach **200 A** (jeopardizing motor safety).
  * High torque ripple is observed due to high frequency inverter switching.
  * No speed regulation: the speed drops significantly when the load torque is applied.

#### Open-Loop Speed Waveform ($\Omega$):
![Open-Loop Speed](images/bo_vitesse.png)

#### Open-Loop d-axis Current Waveform ($I_d$):
![Open-Loop Id](images/bo_id.png)

---

### 4.2. Closed-Loop Simulation (Boucle Fermée - BF)

#### Test 1: Load Disturbance Rejection
The motor starts under no-load condition with a speed reference of $100\text{ rad/s}$. A load torque of $C_r = 3\text{ Nm}$ is applied at $t = 0.15\text{ s}$.

* **Observations**:
  * The speed reaches its target in **$30\text{ ms}$** with a minimal overshoot ($4.4\%$).
  * The system effectively rejects the load perturbation, restoring the speed to $100\text{ rad/s}$ almost instantly.
  * The current $i_d$ is kept strictly at $0\text{ A}$ verifying the FOC decoupling.

#### Test 1 Speed Waveform:
![Test 1 Speed](images/bf_test1_vitesse.png)

#### Test 1 Current Waveform ($I_d$):
![Test 1 Id](images/bf_test1_id.png)

---

#### Test 2: Speed Inversion Reversibility
To test the speed tracking reversibility, a sudden step reference is applied from $+100\text{ rad/s}$ to $-100\text{ rad/s}$ at $t = 0.3\text{ s}$ under load.

* **Observations**:
  * The speed transition occurs in **$40\text{ ms}$** with high precision.
  * The current limits are maintained safely by the regulators, showing excellent transient protection.

#### Test 2 Speed Waveform:
![Test 2 Speed](images/bf_test2_vitesse.png)

#### Test 2 Current Waveform ($I_d$):
![Test 2 Id](images/bf_test2_id.png)

---

## 5. How to Run the Simulations

1. Clone or download this repository.
2. Ensure you have the `images/` folder containing the waveform plots.
3. Open MATLAB/Simulink (R2016a or newer).
4. Run the closed-loop Simulink model: `CV_new_bf.slx`.
5. Open the Scopes to observe the speed and current signals.