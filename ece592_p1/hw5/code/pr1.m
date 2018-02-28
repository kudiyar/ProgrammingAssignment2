%{
Nico 
Cody
%}
%%
clear

p = [1 3 5 6 11];
%% n = 96, 100
pr96 = price2(96, p);
pr100 = price2(100, p);

%% plot timing
num_samps = 100;
times = zeros(1,num_samps);

for n = 1:num_samps
 
   tst = tic;
   pr = price2(n, p);
   times(n) = toc(tst);
   
   fprintf('pr = %d\n', pr);
end

f = instantiateFig(2);
plot(1:num_samps, times, 'LineWidth', 3);
prettyPictureFig(f);
xlabel('n');
ylabel('runtime (s)');
title('Dynamic programming runtime vs. n');
print('../images/pr2_timing','-dpng');