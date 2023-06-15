function Ez_t = calculate_plane_wave_field(k_vec, x, y)

kx = k_vec(1);
ky = k_vec(2);

[X, Y] = meshgrid(x, y);

X = X*1e-3;
Y = Y*1e-3;

Ez_t = exp(-1i*(kx*X + ky*Y));

end