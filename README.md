# ELE2026 — Ejercicios y Cálculos

Repositorio del curso de **Electrotecnia II 2026**, Departamento de Electromecánica,
Facultad de Ingeniería, Universidad Nacional de San Juan.

Espacio compartido donde los alumnos suben ejercicios resueltos, cálculos y
trabajos prácticos a lo largo de la cursada.

## Estructura

Cada alumno crea su propia carpeta con el formato:

    /apellido-nombre/

Dentro de su carpeta, organiza por trabajo práctico:

    /apellido-nombre/
        tp01-circuitos/
            enunciado.pdf
            resolucion.pdf
            calculos.py        (o .m, .pas, .xlsx, etc.)
            README.md          (breve descripción del TP)
        tp02-transformadores/
            ...

## Cómo contribuir

1. Hacer **fork** del repo (botón arriba a la derecha).
2. Clonar tu fork en tu máquina:

       git clone https://github.com/TU-USUARIO/ELE2026.git
       cd ELE2026

3. Crear tu carpeta y agregar tu trabajo.
4. Commit y push a tu fork:

       git add apellido-nombre/
       git commit -m "TP01 - apellido"
       git push origin main

5. Abrir un **Pull Request** desde tu fork hacia este repo.

El docente revisa el PR y lo mergea.

## Reglas

- **No modificar carpetas de otros alumnos.** Cualquier PR que toque
  archivos fuera de la carpeta propia será rechazado.
- **No subir archivos pesados** (>10 MB). Para datasets o videos,
  usar enlaces externos (Drive, Figshare).
- **No subir credenciales, claves, ni datos personales.**
- Los archivos deben ser propios. Citar fuentes cuando se reutilice
  material de terceros.
- Lenguajes/formatos aceptados: PDF, Markdown, Python, Octave/MATLAB,
  Free Pascal, planillas de cálculo, LaTeX.

## Licencia

El código de los trabajos se libera bajo **Apache 2.0** (ver `LICENSE`).
Los documentos PDF/LaTeX bajo **CC BY 4.0**. Al hacer push a este
repositorio, el alumno acepta estas licencias para su contribución.

## Contacto

Rodolfo Rodrigo — Profesor Titular, Departamento de Electromecánica
rrodrigo@unsj.edu.ar
