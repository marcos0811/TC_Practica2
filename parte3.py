import numpy as np
import matplotlib.pyplot as plt
import control as ctrl

# --- Sistema con retardo ---
num = [3]
den = [1, 2, 3]
G = ctrl.tf(num, den)

# Aproximación de e^{-2s} con Padé (orden 2)
num_delay, den_delay = ctrl.pade(2, 2)
delay = ctrl.tf(num_delay, den_delay)
Gs = G * delay

# =========================
# PRIMERA SEÑAL ARBITRARIA
# =========================
t = np.arange(0, 30.1, 0.1)
x = np.zeros_like(t)

# 10–20 s: escalón de subida a 5
x[(t >= 10) & (t < 20)] = 5
# 20–30 s: escalón de subida a 10
x[(t >= 20) & (t <= 30)] = 10

# Respuesta del sistema
t_out, y = ctrl.forced_response(Gs, T=t, U=x)

# Gráfica señal arbitraria y respuesta
plt.figure(figsize=(7, 4))
plt.plot(t, x, 'b--', linewidth=1.5)
plt.plot(t_out, y, 'r', linewidth=2)
plt.xlabel('Tiempo (s)')
plt.ylabel('Amplitud')
plt.title('Respuesta del sistema')
plt.grid(True)
plt.tight_layout()
plt.show()

# =========================
# SEGUNDA SEÑAL ARBITRARIA
# =========================
t2 = np.arange(0, 40.1, 0.1)
x2 = np.zeros_like(t2)

# 10–20 s: constante en 5
x2[(t2 >= 10) & (t2 < 20)] = 5
# 20–30 s: rampa ascendente de 15 a 25 (y = x - 5)
mask_rampa = (t2 >= 20) & (t2 < 30)
x2[mask_rampa] = t2[mask_rampa] - 5
# 30–40 s: constante en 25
x2[(t2 >= 30)] = 25

# Respuesta del sistema
t_out2, y2 = ctrl.forced_response(Gs, T=t2, U=x2)

# Gráfica señal y respuesta
plt.figure(figsize=(7, 4))
plt.plot(t2, x2, 'b--', linewidth=1.5, label='Señal arbitraria')
plt.plot(t_out2, y2, 'r', linewidth=2, label='Respuesta del sistema')
plt.xlabel('Tiempo (s)')
plt.ylabel('Amplitud')
plt.title('Respuesta del sistema')
plt.grid(True)
plt.tight_layout()
plt.show()
