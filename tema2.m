
N = 50; % numarul de coeficienti
D = 11; % durata
P = 40; % perioada
F=1/P; % frecventa 
w0=2*pi/P; % pulsatia
t=0:0.02:P-0.02; % timpul pe care calculam integrala (o perioada); 
                 % rezolutia temporala trebuie sa fie de 2 ori mai mica decat perioada semnalului (teorema esantionarii);

%% semnalul dreptungiular
x = zeros(1,size(t,2)); % initializarea lui x cu zerouri
x(t<=D/2) =1; % de la 0 la D/2 x are valoarea 1
x(t>P-D/2) =1; % de la D/2 la P x are valoarea 1
t_4p = 0:0.02:4*P-0.02; % vectorul timp pentru reprezentarea pe 4 perioade
x_4p = repmat(x,1,4); % vectorul x pentru reprezentarea pe 4 perioade
   
% integrala numerica prin functia trapz
for k = -N:N
    x_temp = x;
    x_temp = x_temp.*exp(-j*k*w0*t); % vectorul inmultit cu termenul corespunzator
    X(k+51) = trapz(t,x_temp); % trapz calculeaza integrala prin metoda trapezului 
    %(imparte suprafata in forme trapezoidale pentru a calcula mai usor aria)
end

x_r(1:length(t)) = 0; % initializarea semnalului reconstruit cu N puncte

%reconstruirea lui x(t) folosind N coeficienti
for index = 1:length(t);
for k = -N:N
x_r(index) = x_r(index) + (1/P)*X(k+N+1)*exp(j*k*w0*t(index));
end
end

figure(1);
plot(t_4p,x_4p); % afisarea lui x(t)
title('x(t) cu linie solida si reconstruirea folosind N=50 coeficienti(linie punctata)');
hold on
x_r_4p = repmat(x_r,1,4); % generarea lui x
plot(t_4p,x_r_4p,'--'); % afisarea lui x reconstruit
xlabel('Timp [s]');
ylabel('Amplitudine');

f = -N*F:F:N*F; % generarea vectorului de frecvente
figure(2);
stem(f,abs(X)); % afisarea lui X
title('Spectrul lui x(t)');
xlabel('Frecventa [Hz]');
ylabel('|X|');

%%
% Teoria seriilor Fourier ne spune semnalele periodice pot fi aproximate
% prin suma infinita de sinus si cosinus de frecvente diferite fiecare cu 
% anumiti coeficienti. Acesti coeficienti dau spectrul amplitudinii fata de frecventa.
% Semnalul reconstruit folosind un numar finit de termeni se apropie ca
% forma de semnalul original cu o anumita marja de eroare. Cu cat marim
% numarul de coeficienti, aceasta marja de eroare va fi din ce in ce mai
% mica. In plus se observa faptul ca semnalul poate fi aproximat printr-o
% suma de sinusoide.



