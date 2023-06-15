function y = asc_legendre(n, m, x)

% Calculate Pnm(x)

% m must be less than n

A = legendre(n, x);
B = A(m+1, :, :);

if n == 0
    y = ones(size(x));
else
    y = reshape(B, [size(x, 1) size(x, 2) 1]);
end

end