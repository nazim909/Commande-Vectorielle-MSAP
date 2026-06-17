# Field-Oriented Control (FOC) of a Permanent Magnet Synchronous Motor (PMSM)

This repository contains a MATLAB/Simulink project focusing on the modeling, controller synthesis, and vector control of a Permanent Magnet Synchronous Motor (PMSM) supplied by a PWM voltage source inverter. 

This work was conducted at the École Nationale Polytechnique (ENP) of Algiers (Academic Year 2025 - 2026) by Mohamed Nazim ABBAD under the supervision of Pr. MO MAHMOUDI.

---

## Project Structure & Features

### 1. Mathematical Modeling
* **PMSM Modeling**: Development of the electric and mechanical state equations. Application of Clarke and Park transformations to transition the tri-phase ($abc$) variables into the bi-phase rotating reference frame ($d, q$).
* **Voltage Source Inverter**: Modeling of a 3-phase inverter driven by Sinusoidal Pulse Width Modulation (SPWM).

### 2. Controller Synthesis & Tuning
* **Current Control Loops ($i_d, i_q$)**: Tuning of proportional-integral (PI) controllers using the pole-zero cancellation method to guarantee a fast dynamic response (time response $T_r \approx 30\text{ ms}$).
* **Speed Control Loop ($\Omega$)**: Synthesis of a PI speed controller optimized for torque disturbance rejection and speed tracking.
* **Anti-Windup**: Implementation of anti-reset windup protection to prevent integrator saturation during large transient states.

### 3. Simulink Simulations & Dynamic Tests
* **Open-Loop Simulation**: Highlights system constraints under raw startup conditions (e.g., massive initial current spikes up to 200A and lack of speed regulation under load).
* **Closed-Loop FOC ($i_d = 0$ strategy)**:
  * *Load Disturbance Test*: Evaluation of speed tracking and recovery transient when applying a 3 Nm load torque at $t = 0.15\text{ s}$.
  * *Speed Reversal Test*: Instantaneous speed reference step from +100 rad/s to -100 rad/s at $t = 0.3\text{ s}$ to demonstrate system reversibility and electrical braking efficiency.

---

## Repository Contents

* `/Commande_Vectorielle_MSAP` : Simulink `.slx` files representing open-loop and closed-loop systems.
* `Rapport_pdf.pdf` : Comprehensive project report detailing the theoretical derivations, controller parameters, and simulation waveforms.