function [phi0, rho0] = check_eval_rho0(handles)

rho00 = eval(get(handles.edit_rho0, 'string'));
phi00 = eval(get(handles.edit_phi0, 'string'));

if (length(rho00) > length(phi00))
    n = length(rho00) - length(phi00);
    rho0 = rho00;
    phi0 = [phi00; zeros(n, 1)];
elseif (length(rho00) < length(phi00))
    n = length(phi00) - length(rho00);
    phi0 = phi00;
    rho0 = [rho00; zeros(n, 1)];
else
    rho0 = rho00;
    phi0 = phi00;
end

end