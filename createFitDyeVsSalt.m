function [fitresult, gof] = createFitDyeVsSalt(DyeConcentrationmM, SaltConcentrationmM, Timehours, Sizenm)
%CREATEFIT1(DYECONCENTRATIONMM,SALTCONCENTRATIONMM,SIZENM)

%% Fit: 'untitled fit 2'.
[xData, yData, zData] = prepareSurfaceData( DyeConcentrationmM./max(DyeConcentrationmM), SaltConcentrationmM./max(SaltConcentrationmM), Sizenm );

% Set up fittype and options.
ft = fittype( 'b*cosh(a*x)+d*cosh(c*y)', 'independent', {'x', 'y'}, 'dependent', 'z' );
%ft = fittype( '1-a/exp(x)-b/exp(y)+c*x*y', 'independent', {'x', 'y'}, 'dependent', 'z' );
%ft = fittype( 'd/(1+exp(b+c*x))+d1/(1+exp(b1+c1*y))+e', 'independent', {'x', 'y'}, 'dependent', 'z' );

opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';

opts.StartPoint = [0.8,0.8,1.2,1];
%opts.StartPoint = [0.8,0.8,1.2];
%opts.StartPoint = [0.317520582899226 0.243524968724989 0.653690133966475 0.832423386285184 0.18351115573727 0.597490191872579 0.368484596490336];

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );

time14 = 14 + zeros(length(Sizenm),1);
time20 = 20 + zeros(length(Sizenm),1);
time24 = 24 + zeros(length(Sizenm),1);


t14 = (time14 == Timehours);
t20 = (time20 == Timehours);
t24 = (time24 == Timehours);


x14Data = (xData.*t14);
x20Data = (xData.*t20);
x24Data = (xData.*t24);

y14Data = (yData.*t14);
y20Data = (yData.*t20);
y24Data = (yData.*t24);

z14Data = (zData.*t14);
z20Data = (zData.*t20);
z24Data = (zData.*t24);

%h = plot( fitresult, [xData, yDascatterta], zData );
figure
plot(fitresult)
hold on 
scatter3(x14Data,y14Data,z14Data,'red')
hold on 
scatter3(x20Data,y20Data,z20Data,'yellow')
hold on 
scatter3(x24Data,y24Data,z24Data,'green')

legend( '14hrs','20hrs','24hrs','Sizenm vs. DyeConcentrationmM, Timehours', 'Location', 'NorthEast', 'Interpreter', 'none' );
set(gcf,'position',[0 100 1000 800])
% Plot fit with data.
%figure( 'Name', 'untitled fit 2' );
%h = plot( fitresult, [xData, yData], zData );
%legend( h, 'untitled fit 2', 'Sizenm vs. DyeConcentrationmM, SaltConcentrationmM', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'DyeConcentrationmM', 'Interpreter', 'none' );
ylabel( 'SaltConcentrationmM', 'Interpreter', 'none' );
zlabel( 'Sizenm', 'Interpreter', 'none' );
str = ['R-Squared: ',sprintf('%0.2f',gof.adjrsquare)];
annotation('textbox',[.15 0.9 0 0],'string',str,'FitBoxToText','on','EdgeColor','black')
grid on
view( -50.7, 31.1 );

% Make contour plot.
figure
h = plot( fitresult, [xData, yData], zData, 'Style', 'Contour' );
legend( h, 'untitled fit 1', 'Sizenm vs. SaltConcentrationmM, Timehours', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'SaltConcentrationmM', 'Interpreter', 'none' );
ylabel( 'Timehours', 'Interpreter', 'none' );
annotation('textbox',[.15 0.9 0 0],'string',str,'FitBoxToText','on','EdgeColor','black')
grid on
set(gcf,'position',[0 100 1000 800])

