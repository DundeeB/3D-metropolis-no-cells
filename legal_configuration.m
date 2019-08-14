function [flag] = legal_configuration(state)
spheres = state.spheres;
radiues = state.rad;
Height = state.H;
cyc = state.cyclic_boundary;
flag = true;
[N,d] = size(spheres);
for i=1:N
    p1 = spheres(i,:);
    
    z = p1(d);
    if z<radiues || z > Height - radiues
        flag = false;
        return
    end
    for j=i+1:N
        p2 = spheres(j,:);
        for i_p=1:length(p1)
            if cyclic_dist(p1,p2,cyc)<2*radiues
                flag = false;
                return
            end
        end
    end
end
end

