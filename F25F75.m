function [f25,f75] = F25F75(r,fs) % wat doen deze arguments?

%r = data
%fs = frequency spectrum?/sample freq?

% cummulative of frequency spectrum
F = cumsum(abs(fft(r)).^2);
% normalisation to twice the energy due to symetric spectrum
F = 2* F / max(F);

% frequency content
f = (0: length(r)-1)/length(r)*fs;

i = find (F <=0.25,1, 'last');
f25 = f(i);

i = find (F <=0.75,1, 'last');
f75 = f(i);


 %if f25 ~= 0
 %    figure
 %    plot(r)
 %    figure
 %    plot(F)
 %    hold on
 %    psd = abs(fft(r)).^2;
 %    psd = psd / max(psd);
 %    plot(psd)
 %    i = find (F <=0.25);
 %    max(i)
 %    f(max(i))
 %end

