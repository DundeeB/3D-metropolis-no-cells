father_dir = 'C:\Users\Daniel\OneDrive - Technion\simulation-results\';
folds_obj = dir(father_dir);
sim_dirs = {};
for i=1:length(folds_obj)
    f = folds_obj(i).name;
    if sum(strcmp(f,{'.','..','Small or 2D simulations'}))||...
            ~isdir([father_dir f])  
        continue
    end
    sim_dirs{end+1} = [father_dir f];
end
n = length(sim_dirs);
rho_H_vec = zeros(n,1);
h_vec = rho_H_vec;
N_vec = rho_H_vec;

for i=1:n
    rho_H_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'.*rhoH=',''),'_.*',''));
    N_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'_h=.*',''),'.*N=',''));
    h_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'.*h=',''),'_rhoH.*',''));

    if (h_vec(i) < 0.8) && N_vec(i) == 3600
        post_process(sim_dirs{i},false,'output_psi14_psi23_b1_N_sp_100',100);
    end
end