function hh = riccati_besselhh_prim(n, a, x)

hh = x .* besselhh_prim(n, a, x) + besselhh(n, a, x);

end