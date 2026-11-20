# Diseño de superficies reflectantes planas para mejorar la cobertura radio

Trabajo de Fin de Grado (Grado en Ingeniería de Sistemas de Telecomunicación, UAB).
Diseño de una superficie reflectante pasiva a 5,8 GHz: diseño analítico y simulación
(MATLAB, FEKO), fabricación y caracterización experimental en cámara anecoica.

## Estructura

| Carpeta | Contenido |
|---|---|
| `memoria/` | Memoria final (PDF), presentación y vídeo de la evolución del lóbulo |
| `informes/` | Informes técnicos parciales (apéndice técnico, FEKO capítulos 4 y 5, divulgativo) |
| `matlab/` | Scripts generales: modelo circuital, benchmark de Luukkonen, secuencias, simulaciones de haz |
| `capitulos/` | Modelos y datos por capítulo (3 diseño analítico, 4 agrupación de celdas, 5 simulación full-wave, 6 medidas reales) |
| `figuras/` | Figuras usadas en la memoria |
| `notas/` | Apuntes de diseño |

## Reproducibilidad

- Los resultados pesados de FEKO (`.bof`, `.afo`, `.str`, `.out`) **no se incluyen**: se regeneran
  ejecutando los modelos (`.cfx`, `.pre`, `.fek`) con Altair FEKO.
- Los archivos de más de 5 MB (algunos modelos `.cfx` y barridos `.pfs`) se han omitido para
  mantener el repositorio ligero; se pueden añadir con Git LFS.
- Los scripts de MATLAB usan las toolboxes que indiquen sus cabeceras.

## Referencias

Ver [`REFERENCES.md`](REFERENCES.md). Los artículos de terceros no se redistribuyen en este repositorio.

## Licencia

- Código (`matlab/`, scripts y archivos de simulación): [MIT](LICENSE).
- Memoria, informes, figuras y fotografías: [CC BY 4.0](LICENSE-DOCS.md).
