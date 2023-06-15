function jj = riccati_besseljj_prim(n, x)

jj = x .* besseljj_prim(n, x) + besseljj(n, x);

end