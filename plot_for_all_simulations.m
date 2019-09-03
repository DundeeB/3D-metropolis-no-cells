father_dir = 'simulation-results\';
% folds_obj = dir(father_dir);
folds_obj = dir(father_dir);
sim_dirs = {};
for i=1:length(folds_obj)
    f = folds_obj(i).name;
    if strcmp(f,'.') || strcmp(f,'..')...
            ||strcmp(f,'Small or 2D simulations')||...
            ~isdir([father_dir f])  
        continue
    end
    sim_dirs{end+1} = ['simulation-results\' f];
end
n = length(sim_dirs);
rho_H_vec = zeros(n,1);
h_vec = rho_H_vec;
N_vec = rho_H_vec;
psi_vec = zeros(n,1);
for i=1:n
    rho_H_vec(i) = str2double(regexprep(...
        sim_dirs{i},'.*rhoH=',''));
    N_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'_h=.*',''),'.*N=',''));
    h_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'.*h=',''),'_rhoH.*',''));

    cd(sim_dirs{i});
    try
        load('output.mat');
        psi_vec(i) = psi14(end);
    end
    cd('../../');
end
%%
figure; hold all; title('h=0.7');
I1 = h_vec==0.7 & N_vec==900;
I2 = h_vec==0.7 & N_vec==3600;
plot(rho_H_vec(I1),psi_vec(I1),'o--','MarkerSize',10);
plot(rho_H_vec(I2),psi_vec(I2),'o--','MarkerSize',10);
legend('N=900','N=3600','Location','NorthWest');
set(gca,'FontSize',24);
xlabel('\rho_H');
ylabel('|\psi_{14}|');
grid on;