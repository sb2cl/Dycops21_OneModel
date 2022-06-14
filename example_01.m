clear all;
close all;

%% Init model.

m = antithetic_controller();

%% Simulate.

% Solver options.
opt = odeset('AbsTol',1e-8,'RelTol',1e-8);
opt = odeset(opt,'Mass',m.M);

% Simulation time span.
tspan = [m.opts.t_init m.opts.t_end];

[t,x] = ode15s(@(t,x) m.ode(t,x,m.p),tspan,m.x0,opt);
out = m.simout2struct(t,x,m.p);

%% Plot result.

figure(1);

subplot(2,1,1);

hold on;

plot(out.t, out.circuit__A__protein);

grid on;
legend('circuit.A.protein','ref');

subplot(2,1,2);

hold on;

plot(out.t, out.circuit__z1__protein);
plot(out.t, out.circuit__z2__protein);

grid on;
legend('circuit.z1.protein','circuit.z2.protein');