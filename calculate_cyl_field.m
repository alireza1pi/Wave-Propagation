function Ez_t = calculate_cyl_field(freq, eps_r, mu_r, N,  x, y, x0, y0)


omega = 2*pi*freq;

c = 3e8;

k0 = omega/c;

k = sqrt(eps_r*mu_r) *k0;


Ns = length(x0);


[X, Y] = meshgrid(x, y);

X = X*1e-3;
Y = Y*1e-3;

[PHI, RHO] = cart2pol(X, Y);

Ez1 = zeros(size(RHO, 1), size(RHO, 2), Ns);
Ez2 = zeros(size(RHO, 1), size(RHO, 2), Ns);

Ez = zeros(size(RHO, 1), size(RHO, 2), Ns);

Ez_t = zeros(size(RHO));

handle_waitbar = waitbar(0, 'Calculating ...', 'Name', 'Calculate Matrices');

for ns = 1:Ns
    
    [phi0, rho0] = cart2pol(x0(ns)*1e-3, y0(ns)*1e-3);    
    phi0(phi0<0) = 2*pi + phi0(phi0<0);
                    
    logic_mat1 = zeros(size(RHO));
    logic_mat2 = zeros(size(RHO));
                    
    logic_mat1(RHO<rho0) = 1;
    logic_mat2(RHO>=rho0) =1;
    
    if (x0(ns) == 0 && y0(ns) == 0)
        
        Ez(:, :, ns) = besselh(0, 2, k*RHO);
        
    else
    
        for n = -N:N
        
            if (eps_r < 0 && mu_r < 0)
                Ez1(:, :, ns) = Ez1(:, :, ns) + besselh(n, 1, k*rho0)*besselj(n, k*RHO) .* exp(1i*n*(PHI - phi0));
                Ez2(:, :, ns) = Ez2(:, :, ns) + besselh(n, 1, k*RHO)*besselj(n, k*rho0) .* exp(1i*n*(PHI - phi0));
            else
                Ez1(:, :, ns) = Ez1(:, :, ns) + besselh(n, 2, k*rho0)*besselj(n, k*RHO) .* exp(1i*n*(PHI - phi0));
                Ez2(:, :, ns) = Ez2(:, :, ns) + besselh(n, 2, k*RHO)*besselj(n, k*rho0) .* exp(1i*n*(PHI - phi0));
            end
        
            waitbar(n/(N), handle_waitbar);
        
        end
    
        Ez1(:, :, ns) = Ez1(:, :, ns).*logic_mat1;
        Ez2(:, :, ns) = Ez2(:, :, ns).*logic_mat2;
    
        Ez(:, :, ns) = Ez1(:, :, ns) + Ez2(:, :, ns);
    
    end
    
    Ez_t = Ez_t + Ez(:,:,ns);
    
end

close(handle_waitbar);


end