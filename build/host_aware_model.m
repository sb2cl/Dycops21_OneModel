classdef host_aware_model
	% This file was automatically generated by OneModel.
	% Any changes you make to it will be overwritten the next time
	% the file is generated.

	properties
		p      % Default model parameters.
		x0     % Default initial conditions.
		M      % Mass matrix for DAE systems.
		opts   % Simulation options.
	end

	methods
		function obj = host_aware_model()
			%% Constructor of host_aware_model.
			obj.p    = obj.default_parameters();
			obj.x0   = obj.initial_conditions();
			obj.M    = obj.mass_matrix();
			obj.opts = obj.simulation_options();
		end

		function p = default_parameters(~)
			%% Default parameters value.
			p = [];
			p.cell__p_r__N = 55.0;
			p.cell__p_r__omega = 7.33;
			p.cell__p_r__d_m = 0.16;
			p.cell__p_r__k_b = 4.7627;
			p.cell__p_r__k_u = 119.7956;
			p.cell__p_r__l_p = 195.0;
			p.cell__p_r__l_e = 25.0;
			p.cell__p_r__weigth = 0.0045;
			p.cell__p_nr__N = 1735.0;
			p.cell__p_nr__omega = 0.0361;
			p.cell__p_nr__d_m = 0.2;
			p.cell__p_nr__k_b = 12.4404;
			p.cell__p_nr__k_u = 10.0454;
			p.cell__p_nr__l_p = 333.0;
			p.cell__p_nr__l_e = 25.0;
			p.cell__K_sc = 0.1802;
			p.cell__nu = 1260.0;
			p.cell__m_aa = 1.826e-07;
			p.cell__phi_m = 0.9473;
			p.mass__c_1 = 239089.0;
			p.mass__c_2 = 7432.0;
			p.mass__c_3 = 37.06;
			p.s = 3.6;
		end

		function x0 = initial_conditions(~)
			%% Default initial conditions.
			x0 = [
				100.0 % cell__p_r__m
				100.0 % cell__p_nr__m
				0.01 % cell__mu (algebraic)
				350.0 % cell__r (algebraic)
			];
		end

		function M = mass_matrix(~)
			%% Mass matrix for DAE systems.
			M = [
				1 0 0 0 
				0 1 0 0 
				0 0 0 0 
				0 0 0 0 
			];
		end

		function opts = simulation_options(~)
			%% Default simulation options.
			opts.t_end = 1000.0;
			opts.t_init = 0.0;
		end

		function dx = ode(~,t,x,p)
			%% Evaluate the ODE.
			%
			% Args:
			%	 t Current time in the simulation.
			%	 x Array with the state value.
			%	 p Struct with the parameters.
			%
			% Return:
			%	 dx Array with the ODE.

			% ODE and algebraic states:
			cell__p_r__m = x(1,:);
			cell__p_nr__m = x(2,:);
			cell__mu = x(3,:);
			cell__r = x(4,:);

			% Assigment states:
			cell__s = p.s;
			cell__p_r__mu = cell__mu;
			cell__p_r__r = cell__r;
			cell__p_r__E_m = 3.459;
			cell__p_r__r_t = cell__p_r__m./p.cell__p_r__weigth;
			cell__p_nr__mu = cell__mu;
			cell__p_nr__r = cell__r;
			cell__p_nr__E_m = 6.3492;
			cell__nu_t = p.cell__nu.*cell__s./(cell__s + p.cell__K_sc);
			cell__m_p = cell__p_r__m + cell__p_nr__m;
			mass__mu = cell__mu;
			mass__m_h = p.mass__c_1.*mass__mu.*mass__mu + p.mass__c_2.*mass__mu + p.mass__c_3;
			cell__m_h = mass__m_h;
			cell__p_r__nu_t = cell__nu_t;
			cell__p_r__m_h = cell__m_h;
			cell__p_r__K_C0 = p.cell__p_r__k_b./(p.cell__p_r__k_u + cell__p_r__nu_t./p.cell__p_r__l_e);
			cell__p_r__J = cell__p_r__E_m.*p.cell__p_r__omega./(p.cell__p_r__d_m./cell__p_r__K_C0 + cell__p_r__mu.*cell__p_r__r);
			cell__p_r__W = p.cell__p_r__N.*(1 + 1./cell__p_r__E_m).*cell__p_r__J;
			cell__p_nr__nu_t = cell__nu_t;
			cell__p_nr__m_h = cell__m_h;
			cell__p_nr__K_C0 = p.cell__p_nr__k_b./(p.cell__p_nr__k_u + cell__p_nr__nu_t./p.cell__p_nr__l_e);
			cell__p_nr__J = cell__p_nr__E_m.*p.cell__p_nr__omega./(p.cell__p_nr__d_m./cell__p_nr__K_C0 + cell__p_nr__mu.*cell__p_nr__r);
			cell__p_nr__W = p.cell__p_nr__N.*(1 + 1./cell__p_nr__E_m).*cell__p_nr__J;
			cell__J_host_sum = p.cell__p_r__N.*cell__p_r__J + p.cell__p_nr__N.*cell__p_nr__J;
			cell__WSum = cell__p_r__W + cell__p_nr__W;
			cell__phi_ht = (p.cell__p_r__N.*cell__p_r__J + p.cell__p_nr__N.*cell__p_nr__J)./(1 + cell__WSum);
			cell__p_r__J_host_sum = cell__J_host_sum;
			cell__p_nr__J_host_sum = cell__J_host_sum;

			% der(cell__p_r__m)
			dx(1,1) =  + ((cell__p_r__m_h.*p.cell__p_r__N.*cell__p_r__J./cell__p_r__J_host_sum - cell__p_r__m).*cell__p_r__mu);

			% der(cell__p_nr__m)
			dx(2,1) =  + ((cell__p_nr__m_h.*p.cell__p_nr__N.*cell__p_nr__J./cell__p_nr__J_host_sum - cell__p_nr__m).*cell__p_nr__mu);

			% der(cell__mu)
			dx(3,1) = cell__mu - (p.cell__m_aa./cell__m_h).*cell__nu_t.*cell__phi_ht.*p.cell__phi_m.*cell__p_r__r_t;

			% der(cell__r)
			dx(4,1) = cell__r - p.cell__phi_m.*cell__p_r__r_t./(1 + cell__WSum);

		end
		function out = simout2struct(~,t,x,p)
			%% Convert the simulation output into an easy-to-use struct.

			% We need to transpose state matrix.
			x = x';
			% ODE and algebraic states:
			cell__p_r__m = x(1,:);
			cell__p_nr__m = x(2,:);
			cell__mu = x(3,:);
			cell__r = x(4,:);

			% Assigment states:
			cell__s = p.s;
			cell__p_r__mu = cell__mu;
			cell__p_r__r = cell__r;
			cell__p_r__E_m = 3.459;
			cell__p_r__r_t = cell__p_r__m./p.cell__p_r__weigth;
			cell__p_nr__mu = cell__mu;
			cell__p_nr__r = cell__r;
			cell__p_nr__E_m = 6.3492;
			cell__nu_t = p.cell__nu.*cell__s./(cell__s + p.cell__K_sc);
			cell__m_p = cell__p_r__m + cell__p_nr__m;
			mass__mu = cell__mu;
			mass__m_h = p.mass__c_1.*mass__mu.*mass__mu + p.mass__c_2.*mass__mu + p.mass__c_3;
			cell__m_h = mass__m_h;
			cell__p_r__nu_t = cell__nu_t;
			cell__p_r__m_h = cell__m_h;
			cell__p_r__K_C0 = p.cell__p_r__k_b./(p.cell__p_r__k_u + cell__p_r__nu_t./p.cell__p_r__l_e);
			cell__p_r__J = cell__p_r__E_m.*p.cell__p_r__omega./(p.cell__p_r__d_m./cell__p_r__K_C0 + cell__p_r__mu.*cell__p_r__r);
			cell__p_r__W = p.cell__p_r__N.*(1 + 1./cell__p_r__E_m).*cell__p_r__J;
			cell__p_nr__nu_t = cell__nu_t;
			cell__p_nr__m_h = cell__m_h;
			cell__p_nr__K_C0 = p.cell__p_nr__k_b./(p.cell__p_nr__k_u + cell__p_nr__nu_t./p.cell__p_nr__l_e);
			cell__p_nr__J = cell__p_nr__E_m.*p.cell__p_nr__omega./(p.cell__p_nr__d_m./cell__p_nr__K_C0 + cell__p_nr__mu.*cell__p_nr__r);
			cell__p_nr__W = p.cell__p_nr__N.*(1 + 1./cell__p_nr__E_m).*cell__p_nr__J;
			cell__J_host_sum = p.cell__p_r__N.*cell__p_r__J + p.cell__p_nr__N.*cell__p_nr__J;
			cell__WSum = cell__p_r__W + cell__p_nr__W;
			cell__phi_ht = (p.cell__p_r__N.*cell__p_r__J + p.cell__p_nr__N.*cell__p_nr__J)./(1 + cell__WSum);
			cell__p_r__J_host_sum = cell__J_host_sum;
			cell__p_nr__J_host_sum = cell__J_host_sum;

			% Save simulation time.
			out.t = t;

			% Vector for extending single-value states and parameters.
			ones_t = ones(size(t'));


			% Save states.
			out.cell__s = (cell__s.*ones_t)';
			out.cell__m_h = (cell__m_h.*ones_t)';
			out.cell__p_r__nu_t = (cell__p_r__nu_t.*ones_t)';
			out.cell__p_r__mu = (cell__p_r__mu.*ones_t)';
			out.cell__p_r__r = (cell__p_r__r.*ones_t)';
			out.cell__p_r__m_h = (cell__p_r__m_h.*ones_t)';
			out.cell__p_r__J_host_sum = (cell__p_r__J_host_sum.*ones_t)';
			out.cell__p_r__K_C0 = (cell__p_r__K_C0.*ones_t)';
			out.cell__p_r__E_m = (cell__p_r__E_m.*ones_t)';
			out.cell__p_r__J = (cell__p_r__J.*ones_t)';
			out.cell__p_r__W = (cell__p_r__W.*ones_t)';
			out.cell__p_r__m = (cell__p_r__m.*ones_t)';
			out.cell__p_r__r_t = (cell__p_r__r_t.*ones_t)';
			out.cell__p_nr__nu_t = (cell__p_nr__nu_t.*ones_t)';
			out.cell__p_nr__mu = (cell__p_nr__mu.*ones_t)';
			out.cell__p_nr__r = (cell__p_nr__r.*ones_t)';
			out.cell__p_nr__m_h = (cell__p_nr__m_h.*ones_t)';
			out.cell__p_nr__J_host_sum = (cell__p_nr__J_host_sum.*ones_t)';
			out.cell__p_nr__K_C0 = (cell__p_nr__K_C0.*ones_t)';
			out.cell__p_nr__E_m = (cell__p_nr__E_m.*ones_t)';
			out.cell__p_nr__J = (cell__p_nr__J.*ones_t)';
			out.cell__p_nr__W = (cell__p_nr__W.*ones_t)';
			out.cell__p_nr__m = (cell__p_nr__m.*ones_t)';
			out.cell__nu_t = (cell__nu_t.*ones_t)';
			out.cell__mu = (cell__mu.*ones_t)';
			out.cell__m_p = (cell__m_p.*ones_t)';
			out.cell__J_host_sum = (cell__J_host_sum.*ones_t)';
			out.cell__WSum = (cell__WSum.*ones_t)';
			out.cell__phi_ht = (cell__phi_ht.*ones_t)';
			out.cell__r = (cell__r.*ones_t)';
			out.mass__mu = (mass__mu.*ones_t)';
			out.mass__m_h = (mass__m_h.*ones_t)';

			% Save parameters.
			out.cell__p_r__N = (p.cell__p_r__N.*ones_t)';
			out.cell__p_r__omega = (p.cell__p_r__omega.*ones_t)';
			out.cell__p_r__d_m = (p.cell__p_r__d_m.*ones_t)';
			out.cell__p_r__k_b = (p.cell__p_r__k_b.*ones_t)';
			out.cell__p_r__k_u = (p.cell__p_r__k_u.*ones_t)';
			out.cell__p_r__l_p = (p.cell__p_r__l_p.*ones_t)';
			out.cell__p_r__l_e = (p.cell__p_r__l_e.*ones_t)';
			out.cell__p_r__weigth = (p.cell__p_r__weigth.*ones_t)';
			out.cell__p_nr__N = (p.cell__p_nr__N.*ones_t)';
			out.cell__p_nr__omega = (p.cell__p_nr__omega.*ones_t)';
			out.cell__p_nr__d_m = (p.cell__p_nr__d_m.*ones_t)';
			out.cell__p_nr__k_b = (p.cell__p_nr__k_b.*ones_t)';
			out.cell__p_nr__k_u = (p.cell__p_nr__k_u.*ones_t)';
			out.cell__p_nr__l_p = (p.cell__p_nr__l_p.*ones_t)';
			out.cell__p_nr__l_e = (p.cell__p_nr__l_e.*ones_t)';
			out.cell__K_sc = (p.cell__K_sc.*ones_t)';
			out.cell__nu = (p.cell__nu.*ones_t)';
			out.cell__m_aa = (p.cell__m_aa.*ones_t)';
			out.cell__phi_m = (p.cell__phi_m.*ones_t)';
			out.mass__c_1 = (p.mass__c_1.*ones_t)';
			out.mass__c_2 = (p.mass__c_2.*ones_t)';
			out.mass__c_3 = (p.mass__c_3.*ones_t)';
			out.s = (p.s.*ones_t)';

		end
		function plot(~,out)
			%% Plot simulation result.
			figure('Name','cell');
			subplot(3,3,1);
			plot(out.t, out.cell__s);
			title("cell__s");
			ylim([0, +inf]);
			grid on;

			subplot(3,3,2);
			plot(out.t, out.cell__m_h);
			title("cell__m_h");
			ylim([0, +inf]);
			grid on;

			subplot(3,3,3);
			plot(out.t, out.cell__nu_t);
			title("cell__nu_t");
			ylim([0, +inf]);
			grid on;

			subplot(3,3,4);
			plot(out.t, out.cell__mu);
			title("cell__mu");
			ylim([0, +inf]);
			grid on;

			subplot(3,3,5);
			plot(out.t, out.cell__m_p);
			title("cell__m_p");
			ylim([0, +inf]);
			grid on;

			subplot(3,3,6);
			plot(out.t, out.cell__J_host_sum);
			title("cell__J_host_sum");
			ylim([0, +inf]);
			grid on;

			subplot(3,3,7);
			plot(out.t, out.cell__WSum);
			title("cell__WSum");
			ylim([0, +inf]);
			grid on;

			subplot(3,3,8);
			plot(out.t, out.cell__phi_ht);
			title("cell__phi_ht");
			ylim([0, +inf]);
			grid on;

			subplot(3,3,9);
			plot(out.t, out.cell__r);
			title("cell__r");
			ylim([0, +inf]);
			grid on;

			figure('Name','cell__p_r');
			subplot(4,3,1);
			plot(out.t, out.cell__p_r__nu_t);
			title("cell__p_r__nu_t");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,2);
			plot(out.t, out.cell__p_r__mu);
			title("cell__p_r__mu");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,3);
			plot(out.t, out.cell__p_r__r);
			title("cell__p_r__r");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,4);
			plot(out.t, out.cell__p_r__m_h);
			title("cell__p_r__m_h");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,5);
			plot(out.t, out.cell__p_r__J_host_sum);
			title("cell__p_r__J_host_sum");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,6);
			plot(out.t, out.cell__p_r__K_C0);
			title("cell__p_r__K_C0");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,7);
			plot(out.t, out.cell__p_r__E_m);
			title("cell__p_r__E_m");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,8);
			plot(out.t, out.cell__p_r__J);
			title("cell__p_r__J");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,9);
			plot(out.t, out.cell__p_r__W);
			title("cell__p_r__W");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,10);
			plot(out.t, out.cell__p_r__m);
			title("cell__p_r__m");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,11);
			plot(out.t, out.cell__p_r__r_t);
			title("cell__p_r__r_t");
			ylim([0, +inf]);
			grid on;

			figure('Name','cell__p_nr');
			subplot(4,3,1);
			plot(out.t, out.cell__p_nr__nu_t);
			title("cell__p_nr__nu_t");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,2);
			plot(out.t, out.cell__p_nr__mu);
			title("cell__p_nr__mu");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,3);
			plot(out.t, out.cell__p_nr__r);
			title("cell__p_nr__r");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,4);
			plot(out.t, out.cell__p_nr__m_h);
			title("cell__p_nr__m_h");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,5);
			plot(out.t, out.cell__p_nr__J_host_sum);
			title("cell__p_nr__J_host_sum");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,6);
			plot(out.t, out.cell__p_nr__K_C0);
			title("cell__p_nr__K_C0");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,7);
			plot(out.t, out.cell__p_nr__E_m);
			title("cell__p_nr__E_m");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,8);
			plot(out.t, out.cell__p_nr__J);
			title("cell__p_nr__J");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,9);
			plot(out.t, out.cell__p_nr__W);
			title("cell__p_nr__W");
			ylim([0, +inf]);
			grid on;

			subplot(4,3,10);
			plot(out.t, out.cell__p_nr__m);
			title("cell__p_nr__m");
			ylim([0, +inf]);
			grid on;

			figure('Name','mass');
			subplot(2,1,1);
			plot(out.t, out.mass__mu);
			title("mass__mu");
			ylim([0, +inf]);
			grid on;

			subplot(2,1,2);
			plot(out.t, out.mass__m_h);
			title("mass__m_h");
			ylim([0, +inf]);
			grid on;

		end
	end
end
