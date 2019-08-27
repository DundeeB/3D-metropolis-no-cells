function [] = post_process_and_save(lib, plot_flag)
psi14 = calc_psi_param_for_lib(lib, 1, 4);
%%
I = [1:length(psi14)];
psi_current = diff(psi14.*I);
h=figure; 
plot(I,psi14,'Black','LineWidth',3);
hold all; plot(I(1:end-1),psi_current,'b');
plot([0 I(end)],[psi14(end) psi14(end)],'--m','LineWidth',5);
title('Convergence of \psi'); ylabel('|\psi_{14}|');
xlabel('# of realizations summed into \psi');
set(gca,'FontSize',24); xlim([-10 I(end)]);
legend('Average \psi_{14}','\psi_{14} for current realization','Final \psi_{14}');
savefig(h,[lib '\Convergence of psi']);
save([lib '\output'],'psi14');
if ~plot_flag
    close(h);
end
end