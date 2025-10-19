clc; clear ; close all;

num = [3] ;
den = [1 2 3];
ts = 0.1;
delay = 0;

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
xlim([0 7]);

figure();
plot(t,y,'LineWidth',2);
hold on;
plot(t(ind),ymax,'r*','MarkerSize',15,'LineWidth',1.5);
hold off;
xlabel('tiempo');
ylabel('Amplitud');
title('Respuesta del sistema, con una señal impulso como entrada');
xlim([0 7]);
