function [phi0, r0] = eval_r0phi0_from_theta0(handles)

r00 = eval(get(handles.edit_r0, 'string'));
theta00 = eval(get(handles.edit_theta0, 'string'));
phi00 = eval(get(handles.edit_phi0_sph, 'string'));

if (length(theta00) > length(r00))
    n = length(theta00) - length(r00);
    r0 = [r00; zeros(n, 1)];

    if (length(theta00) > length(phi00))
        
        n = length(theta00) - length(phi00);
        phi0 = [phi00; zeros(n, 1)];

    elseif (length(theta00) < length(phi00))
        
        n = length(phi00) - length(theta00);
        phi00((end - n+1):end)=[];
        phi0 = phi00;
        
    else
        
        phi0 = phi00;
    end
        


elseif (length(theta00) < length(r00))
    n = length(r00) - length(theta00);
    r00((end - n+1):end)=[];
    r0 = r00;
    
        if (length(theta00) > length(phi00))
        
            n = length(theta00) - length(phi00);
            phi0 = [phi00; zeros(n, 1)];

        elseif (length(theta00) < length(phi00))
        
            n = length(phi00) - length(theta00);
            phi00((end - n+1):end)=[];
            phi0 = phi00;
        
        else
            phi0 = phi00;
        end
        
else
    r0 = r00;
    
        if (length(theta00) > length(phi00))
        
            n = length(theta00) - length(phi00);
            phi0 = [phi00; zeros(n, 1)];

        elseif (length(theta00) < length(phi00))
        
            n = length(phi00) - length(theta00);
            phi00((end - n+1):end)=[];
            phi0 = phi00;
        
        else
            phi0 = phi00;
        end
end

end