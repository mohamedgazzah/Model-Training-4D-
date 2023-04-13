function [fitresult, gof] = createFitDyeVsTime(DyeConcentrationmM, SaltConcentrationmM, Timehours, Sizenm)

%% Fit: 'untitled fit 3'.
[xData, yData, zData] = prepareSurfaceData( DyeConcentrationmM./max(DyeConcentrationmM), Timehours./max(Timehours), Sizenm );

% Set up fittype and options.
ft = fittype( '-a*log(x)-b*log(y)+c*x^2*y^2', 'independent', {'x', 'y'}, 'dependent', 'z' );
%ft = fittype( 'c*y*exp(a*x+b*y)', 'independent', {'x', 'y'}, 'dependent', 'z' );
%ft = fittype( 'b*x^3+c*y+d*x^2+e*x+f*y^2+g*y^3', 'independent', {'x', 'y'}, 'dependent', 'z' );

opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';

opts.StartPoint = [0.381345204444472 0.161133971849361 0.758112431327419 ];
%opts.StartPoint = [  0.758112431327419 0.1 0.758112431327419];
%opts.StartPoint = [0.8,0.8,1.2,-7.1,-2.4,0.41];

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );


% Plot fit with data.
figure( 'Name', 'Polynomial' );

salt01 = 0.1 + zeros(length(Sizenm),1);
salt1 = 1 + zeros(length(Sizenm),1);
salt5 = 5 + zeros(length(Sizenm),1);
salt10 = 10 + zeros(length(Sizenm),1);
salt20 = 20 + zeros(length(Sizenm),1);

s01 = (salt01 == SaltConcentrationmM);
s1 = (salt1 == SaltConcentrationmM);
s5 = (salt5 == SaltConcentrationmM);
s10 = (salt10 == SaltConcentrationmM);
s20 = (salt20 == SaltConcentrationmM);

x01Data = (xData.*s01);
x1Data = (xData.*s1);
x5Data = (xData.*s5);
x10Data = (xData.*s10);
x20Data = (xData.*s20);

y01Data = (yData.*s01);
y1Data = (yData.*s1);
y5Data = (yData.*s5);
y10Data = (yData.*s10);
y20Data = (yData.*s20);

z01Data = (zData.*s01);
z1Data = (zData.*s1);
z5Data = (zData.*s5);
z10Data = (zData.*s10);
z20Data = (zData.*s20);

%h = plot( fitresult, [xData, yDascatterta], zData );
plot(fitresult)
hold on 
scatter3(x01Data,y01Data,z01Data)
hold on 
scatter3(x1Data,y1Data,z1Data)
hold on 
scatter3(x5Data,y5Data,z5Data)
hold on 
scatter3(x10Data,y10Data,z10Data)
hold on 
scatter3(x20Data,y20Data,z20Data)

legend( '0.1mM','1mM','5mM','10mM','20mM', 'Sizenm vs. DyeConcentrationmM, Timehours', 'Location', 'NorthEast', 'Interpreter', 'none' );
%legend( h, 'Fit', 'Sizenm vs. DyeConcentrationmM, Timehours', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'DyeConcentrationmM', 'Interpreter', 'none' );
ylabel( 'Timehours', 'Interpreter', 'none' );
zlabel( 'Sizenm', 'Interpreter', 'none' );
fprintf('R-Squared: %0.2f',gof.adjrsquare)
str = ['R-Squared: ',sprintf('%0.2f',gof.adjrsquare)];
annotation('textbox',[.15 0.9 0 0],'string',str,'FitBoxToText','on','EdgeColor','black')
grid on
set(gcf,'position',[0 100 1000 800])

% Make contour plot.
figure
h = plot( fitresult, [xData, yData], zData, 'Style', 'Contour' );
legend( h, 'untitled fit 1', 'Sizenm vs. SaltConcentrationmM, Timehours', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'SaltConcentrationmM', 'Interpreter', 'none' );
annotation('textbox',[.15 0.9 0 0],'string',str,'FitBoxToText','on','EdgeColor','black')
ylabel( 'Timehours', 'Interpreter', 'none' );
grid on
set(gcf,'position',[0 100 1000 800])
