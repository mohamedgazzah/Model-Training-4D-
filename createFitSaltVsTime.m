function [fitresult, gof] = createFitSaltVsTime(DyeConcentrationmM, SaltConcentrationmM, Timehours, Sizenm)
%CREATEFIT1(SALTCONCENTRATIONMM,TIMEHOURS,SIZENM)


%% Fit.
[xData, yData, zData] = prepareSurfaceData( SaltConcentrationmM./max(SaltConcentrationmM), Timehours./max(Timehours), Sizenm );

% Set up fittype and options.
ft = fittype( '1-a/x-b/y+c*x*y', 'independent', {'x', 'y'}, 'dependent', 'z' );
%ft = fittype( 'a*b*x^(e-1)*exp(-d*y^c)', 'independent', {'x', 'y'}, 'dependent', 'z' );
%ft = fittype( 'b*x^3+c*y+d*x^2+e*x+f*y^2+g*y^3', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.8,0.8,1.2];
%opts.StartPoint = [  0.758112431327419 0.1 0.758112431327419 0.758112431327419 0.758112431327419];
%opts.StartPoint = [0.8,0.8,1.2,-7.1,-2.4,0.41];

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );

% Create a figure for the plots.
figure( 'Name', 'untitled fit 1' );

dye025 = 0.25 + zeros(length(Sizenm),1);
dye05 = 0.5 + zeros(length(Sizenm),1);
dye075 = 0.75 + zeros(length(Sizenm),1);
dye1 = 1 + zeros(length(Sizenm),1);

d025 = (dye025 == DyeConcentrationmM);
d05 = (dye05 == DyeConcentrationmM);
d075 = (dye075 == DyeConcentrationmM);
d1 = (dye1 == DyeConcentrationmM);

x025Data = (xData.*d025);
x05Data = (xData.*d05);
x075Data = (xData.*d075);
x1Data = (xData.*d1);

y025Data = (yData.*d025);
y05Data = (yData.*d05);
y075Data = (yData.*d075);
y1Data = (yData.*d1);

z025Data = (zData.*d025);
z05Data = (zData.*d05);
z075Data = (zData.*d075);
z1Data = (zData.*d1);


%h = plot( fitresult, [xData, yDascatterta], zData );
plot(fitresult)
hold on 
scatter3(x025Data,y025Data,z025Data)
hold on 
scatter3(x05Data,y05Data,z05Data)
hold on 
scatter3(x075Data,y075Data,z075Data)
hold on 
scatter3(x1Data,y1Data,z1Data)

legend( '14hrs','20hrs','24hrs','Sizenm vs. DyeConcentrationmM, Timehours', 'Location', 'NorthEast', 'Interpreter', 'none' );
set(gcf,'position',[0 100 1000 800])

% Label axes
xlabel( 'SaltConcentrationmM', 'Interpreter', 'none' );
ylabel( 'Timehours', 'Interpreter', 'none' );
zlabel( 'Sizenm', 'Interpreter', 'none' );
str = ['R-Squared: ',sprintf('%0.2f',gof.adjrsquare)];
annotation('textbox',[.15 0.9 0 0],'string',str,'FitBoxToText','on','EdgeColor','black')
grid on

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


