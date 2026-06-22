function [If, Uf, M] = resolver_falla(Eth, Zth, tipo, Zf, rt)
  I3 = eye(3);

  switch upper(tipo)
    case '3FT'
      Rf = diag([Zf Zf Zf]) + rt*ones(3);
      A  = I3;
      B  = -Rf;

    case '1FT_A'
      A = [ 1 0 0 ; 0 0 0 ; 0 0 0 ];
      B = [ -(Zf+rt) -rt -rt ; 0 1 0 ; 0 0 1 ];

    case '2FT_BC'
      A = [ 0 0 0 ; 0 1 0 ; 0 0 1 ];
      B = [ 1 0 0 ; -rt -(Zf+rt) -rt ; -rt -rt -(Zf+rt) ];

    case '2F_BC'
      A = [ 0 0 0 ; 0 0 0 ; 0 1 -1 ];
      B = [ 1 0 0 ; 0 1 1 ; 0 -Zf 0 ];

    case '3F'
      A = [ 1 -1 0 ; 0 1 -1 ; 0 0 0 ];
      B = [ -Zf Zf 0 ; 0 -Zf Zf ; 1 1 1 ];

    otherwise
      error('Tipo de falla no reconocido: %s', tipo);
  end

  M   = [ eye(3), Zth ; A, B ];
  rhs = [ Eth ; zeros(3,1) ];

  x  = M \ rhs;
  Uf = x(1:3);
  If = x(4:6);
end
