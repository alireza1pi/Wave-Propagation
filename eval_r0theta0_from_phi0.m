function [theta0, r0] = eval_r0theta0_from_phi0(handles)

r00 = eval(get(handles.edit_r0, 'string'));
theta00 = eval(get(handles.edit_theta0, 'string'));
phi00 = eval(get(handles.edit_phi0_sph, 'string'));

if (length(phi00) > length(theta00))
    n = length(phi00) - length(theta00);
    theta0 = [theta00; zeros(n, 1)];
    
    if (length(phi00) > length(r00))
        
        n = length(phi00) - length(r00);
        r0 = [r00; zeros(n, 1)];

    elseif (length(phi00) < length(r00))
        
        n = length(r00) - length(phi00);
        r00((end - n+1):end)=[];
        r0 = r00;
        
    else
        
        r0 = r00;
    end
    
elseif (length(phi00) < length(theta00))
    n = length(theta00) - length(phi00);
    theta00((end - n+1):end)=[];
    theta0 = theta00;
    
    if (length(phi00) > length(r00))
        
        n = length(phi00) - length(r00);
        r0 = [r00; zeros(n, 1)];

    elseif (length(phi00) < length(r00))
        
        n = length(r00) - length(phi00);
        r00((end - n+1):end)=[];
        r0 = r00;
        
    else
        
        r0 = r00;
    end
else
    theta0 = theta00;
    
    if (length(phi00) > length(r00))
        
        n = length(phi00) - length(r00);
        r0 = [r00; zeros(n, 1)];

    elseif (length(phi00) < length(r00))
        
        n = length(r00) - length(phi00);
        r00((end - n+1):end)=[];
        r0 = r00;
        
    else
        
        r0 = r00;
    end
end

end