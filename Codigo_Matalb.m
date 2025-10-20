clc; clear ; close all;

num = 3;
den = [1 2 3];
ts = 0.1;
delay = 2;

Gs = tf(num, den, "InputDelay",delay); %tiempo continuo

[y, t] = impulse(Gs); %impulso
[y1, t1] = step(Gs) ; % escalon
[ymax , ind] = max(y);
[ymax1 , ind1] = max(y1);

figure();
plot(t1,y1,'LineWidth',2);
hold on;
plot(t1(ind1),ymax1,'r*','MarkerSize',15,'LineWidth',1.5);
hold off;
xlabel('tiempo');
ylabel('Amplitud');
title('Respuesta del sistema, con una señal escalon como entrada');

figure();
plot(t,y,'LineWidth',2);
hold on;
plot(t(ind),ymax,'r*','MarkerSize',15,'LineWidth',1.5);
hold off;
xlabel('tiempo');
ylabel('Amplitud');
title('Respuesta del sistema, con una señal impulso como entrada');
xlim([0 10])
%%

Gz = tf(num,den,ts); %Tiempo discreto


%Primera se;al arbitraria 
t = 0:0.1:30;  
x = zeros(size(t));

% 0-10s: señal en cero
x(t >= 10 & t <= 20) = 5;        % escalón de subida amplitud de 5
x(t >= 20 & t <= 30) = 10; % escalon de subida ampitud de 10

[y, t_out] = lsim(Gs, x, t);

figure;
plot(t, x, 'b--', 'LineWidth', 1.5);
hold on;
%plot(t_out, y, 'r', 'LineWidth', 2);
xlabel('Tiempo');
ylabel('Ampitud');
title('Señal arbitraria')
grid on;
hold off

%%

% segunda se;al arbitraria

t2 = 0:0.1:40;  % tiempo de 0 a 40 s
x2 = zeros(size(t2));

% 10–20 s: señal constante en 5
x2(t2 >= 10 & t2 < 20) = 5;

% 20–30 s: rampa ascendente de 20 a 30
idx_rampa = t2 >= 20 & t2 < 30;
x2(idx_rampa) = t2(idx_rampa) - 5;%funcion de la recta desplazada

% 30–40 s: señal constante en 25
x2(t2 >= 30) = 25;

% Respuesta del sistema
[y2, t_2] = lsim(Gs, x2, t2);

% Gráfica
figure;
plot(t2, x2, 'b--', 'LineWidth', 1.5);
hold on;
%plot(t_2, y2, 'r', 'LineWidth', 2);
grid on;
xlabel('Tiempo');
ylabel('Amplitud');
title('Señal arbitraria')

%%
% Señal aleatoria combinada
t = 0:0.1:50;           % Tiempo de 0 a 50 s
u = zeros(size(t));      % Inicializamos el vector de señal

u(t >= 0 & t < 5) = linspace(0, 5, sum(t >= 0 & t < 5));
u(t >= 5 & t < 10) = 5;
u(t >= 10 & t < 15) = linspace(5, 2, sum(t >= 10 & t < 15));
u( (t >= 15 & t < 25)) = linspace(2, 8, sum(t >= 15 & t < 25));  % senoidal centrada en 2
u(t >= 25 & t < 30) = 12;
u(t >= 30 & t < 40) = linspace(12, 4, sum(t >= 30 & t < 40));
u(t >= 40 & t <= 50) = 4;

[y_a , t_a] = lsim(Gs,u,t);

% Gráfica
figure;
plot(t, u, 'LineWidth', 2);
hold on;
plot(t_a,y_a,'r', 'LineWidth', 2)
grid on;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Respuesta del sistema');

