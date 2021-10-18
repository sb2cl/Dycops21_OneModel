clear all;
close all;

% Init model.
m = antithetic_controller();

% Solver options.
opt = odeset('AbsTol',1e-8,'RelTol',1e-8);
opt = odeset(opt,'Mass',m.M);

% Simulation time span.
tspan = [m.opts.t_init m.opts.t_end];

[t,x] = ode15s(@(t,x) m.ode(t,x,m.p),tspan,m.x0,opt);
out = m.simout2struct(t,x,m.p);

% Plot result.
figure(1);

subplot(2,1,1);

hold on;

plot(out.t, out.x__protein);
plot(out.t, out.ref);

grid on;
legend('x.protein','ref');

subplot(2,1,2);

hold on;

plot(out.t, out.z1__protein);
plot(out.t, out.z2__protein);
plot(out.t, out.z12__protein);

grid on;
legend('z1.protein','z2.protein','z12.protein');


