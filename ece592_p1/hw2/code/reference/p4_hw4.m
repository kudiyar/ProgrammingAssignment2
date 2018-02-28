% nicholas casale
% ece 542 hw 4 problem 4
% 2/27/17

% use MLP routine to solve the XOR problem
clear;
N = 4;
data = [0, 0, 1, 1; ...
        0, 1, 0, 1; ...
       -1, 1, 1, -1];

%% Part a - 2 hidden neurons
n_hd = 2;
eta0 = 1;
anneal_ind = 1;
[w1,mse] = NN_1HL(data,n_hd,eta0,anneal_ind);

% Plotting Learning Curve
h(1) = figure(1); clf;
plot(mse,'k');
title(sprintf('Learning curve, Hidden Neurons: %d', n_hd));
xlabel('Number of epochs');ylabel('MSE');
print -dpng 4a_2hd_learning_curve.png

% Colormap the figure
h(2) = figure(2); clf;
hold on;
border = 0.5;
xmin = min(data(1,:))-border;
xmax = max(data(1,:))+border;
ymin = min(data(2,:))-border;
ymax = max(data(2,:))+border;
[x_b,y_b]= meshgrid(xmin:(xmax-xmin)/100:xmax,ymin:(ymax-ymin)/100:ymax);
z_b  = 0*ones(size(x_b));
for x1 = 1 : size(x_b,1)
    for y1 = 1 : size(x_b,2)
        input = [x_b(x1,y1);y_b(x1,y1);1];
        z_b(x1,y1) = hyperb(w1{2}*[hyperb(w1{1}*input);1]);
    end
end

% Adding colormap to the final figure
sp = pcolor(x_b,y_b,z_b);
load red_black_colmap;
colormap(red_black);
shading interp;
%set(gca,'XLim',[xmin xmax],'YLim',[ymin ymax]);

% Testing 
fprintf('Testing the MLP ...\n');
% Calculate testing error rate
err = 0; % counter to denote the number of error outputs
for i = 1:N
    x   = [data(1:2,i);1];
    o(:,i)= hyperb(w1{2}*[hyperb(w1{1}*x);1]);
    if o(:,i) > 0
        plot(x(1),x(2),'rx');
    elseif o(:,i) < 0 
        plot(x(1),x(2),'k+');
    end
    if (o(i)*data(3,i)) < 0
        err = err + 1;
    end
end
xlabel('x');ylabel('y');
title(sprintf(['XOR Classification MLP, Epochs = %d \n' ...
        'Num. Hidden = %d, Errors = %d (%1.2f %%) final MSE: %1.3f'],...
        length(mse), n_hd, err, (err/N)*100, mse(end)));
fprintf('   Points tested : %d\n',N);
fprintf('    Error points : %d (%5.2f%%)\n',err,(err/N)*100);
fprintf('  ------------------------------------\n');

% Plot decision boundary with contour
contour(x_b,y_b,z_b,[0 0],'k','Linewidth',1);
set(gca,'XLim',[xmin xmax],'YLim',[ymin ymax]);
hold off;
print -dpng 4a_2hd_classification.png

%% Part b - 4 hidden neurons
n_hd = 4;
eta0 = 1;
anneal_ind = 1;
[w1,mse] = NN_1HL(data,n_hd,eta0,anneal_ind);

% Plotting Learning Curve
h(1) = figure(1);
plot(mse,'k');
title(sprintf('Learning curve, Hidden Neurons: %d', n_hd));
xlabel('Number of epochs');ylabel('MSE');
print -dpng 4b_4hd_learning_curve.png

% Colormap the figure
h(2) = figure(2);
hold on;
border = 0.5;
xmin = min(data(1,:))-border;
xmax = max(data(1,:))+border;
ymin = min(data(2,:))-border;
ymax = max(data(2,:))+border;
[x_b,y_b]= meshgrid(xmin:(xmax-xmin)/100:xmax,ymin:(ymax-ymin)/100:ymax);
z_b  = 0*ones(size(x_b));
for x1 = 1 : size(x_b,1)
    for y1 = 1 : size(x_b,2)
        input = [x_b(x1,y1);y_b(x1,y1);1];
        z_b(x1,y1) = hyperb(w1{2}*[hyperb(w1{1}*input);1]);
    end
end

% Adding colormap to the final figure
sp = pcolor(x_b,y_b,z_b);
load red_black_colmap;
colormap(red_black);
shading interp;
%set(gca,'XLim',[xmin xmax],'YLim',[ymin ymax]);

% Testing 
fprintf('Testing the MLP ...\n');
% Calculate testing error rate
err = 0; % counter to denote the number of error outputs
for i = 1:N
    x   = [data(1:2,i);1];
    o(:,i)= hyperb(w1{2}*[hyperb(w1{1}*x);1]);
    if o(:,i) > 0
        plot(x(1),x(2),'rx');
    elseif o(:,i) < 0 
        plot(x(1),x(2),'k+');
    end
    if (o(i)*data(3,i)) < 0
        err = err + 1;
    end
end
xlabel('x');ylabel('y');
title(sprintf(['XOR Classification MLP, Epochs = %d \n' ...
        'Num. Hidden = %d, Errors = %d (%1.2f %%) final MSE: %1.3f'],...
        length(mse), n_hd, err, (err/N)*100, mse(end)));
fprintf('   Points tested : %d\n',N);
fprintf('    Error points : %d (%5.2f%%)\n',err,(err/N)*100);
fprintf('  ------------------------------------\n');

% Plot decision boundary with contour
contour(x_b,y_b,z_b,[0 0],'k','Linewidth',1);
set(gca,'XLim',[xmin xmax],'YLim',[ymin ymax]);
hold off;
print -dpng 4b_4hd_classification.png