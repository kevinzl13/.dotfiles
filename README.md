# Atajos en terminal

En la mayoría de terminales (bash, zsh, fish, etc.) los atajos de edición vienen de **Readline** (modo Emacs por defecto). Estos son los más útiles:

### Movimiento del cursor

| Atajo | Acción |
| --- | --- |
| `Ctrl + A` | Ir al inicio de la línea |
| `Ctrl + E` | Ir al final de la línea |
| `Alt + B` | Mover una palabra hacia atrás |
| `Alt + F` | Mover una palabra hacia adelante |
| `Ctrl + F` | Mover un carácter adelante |
| `Ctrl + B` | Mover un carácter atrás |

### Borrar texto

| Atajo | Acción |
| --- | --- |
| `Ctrl + W` | Borrar la palabra anterior |
| `Ctrl + U` | Borrar desde el cursor hasta el inicio |
| `Ctrl + K` | Borrar desde el cursor hasta el final |
| `Ctrl + H` | Borrar un carácter atrás (como Backspace) |
| `Ctrl + D` | Borrar un carácter adelante (o salir si la línea está vacía) |

### Historial

| Atajo | Acción |
| --- | --- |
| `Ctrl + P` | Comando anterior |
| `Ctrl + N` | Comando siguiente |
| `Ctrl + R` | Buscar en el historial |
| `↑ / ↓` | Navegar por historial |

### Control de procesos

| Atajo | Acción |
| --- | --- |
| `Ctrl + C` | Interrumpir comando actual |
| `Ctrl + Z` | Suspender proceso |
| `Ctrl + D` | Cerrar sesión / enviar EOF |
| `Ctrl + L` | Limpiar pantalla (igual que `clear`) |

### Atajos de palabras (muy usados)

| Atajo | Acción |
| --- | --- |
| `Alt + Backspace` | Borrar una palabra hacia atrás |
| `Alt + D` | Borrar una palabra hacia adelante |
| `Ctrl + Y` | Pegar lo último borrado |
| `Alt + T` | Intercambiar dos palabras |

# Tmux

Lista de atajos útiles de **tmux** (prefijo por defecto: `Ctrl+b`).

> `Prefix` significa pulsar `Ctrl+b`, soltar, y después pulsar la tecla indicada.

---

# Ventanas (Windows)

| Atajo | Acción |
| --- | --- |
| `Prefix + c` | Crear nueva ventana |
| `Prefix + n` | Ir a la siguiente ventana |
| `Prefix + p` | Ir a la ventana anterior |
| `Prefix + 0-9` | Ir directamente a una ventana por número |
| `Prefix + w` | Mostrar lista de ventanas |
| `Prefix + ,` | Renombrar ventana actual |
| `Prefix + &` | Cerrar ventana actual |
| `Prefix + f` | Buscar ventana por nombre |
| `Prefix + l` | Volver a la ventana anterior usada |

---

# Paneles (Panes)

| Atajo | Acción |
| --- | --- |
| `Prefix + %` | Dividir panel verticalmente |
| `Prefix + "` | Dividir panel horizontalmente |
| `Prefix + flechas` | Moverse entre paneles |
| `Prefix + o` | Rotar entre paneles |
| `Prefix + ;` | Volver al panel anterior |
| `Prefix + q` | Mostrar números de panel |
| `Prefix + z` | Maximizar/restaurar panel actual |
| `Prefix + x` | Cerrar panel actual |
| `Prefix + {` | Mover panel a la izquierda |
| `Prefix + }` | Mover panel a la derecha |
| `Prefix + !` | Convertir panel en nueva ventana |

---

# Redimensionar paneles

| Atajo | Acción |
| --- | --- |
| `Prefix + Ctrl + flechas` | Redimensionar paneles |
| `Prefix + h` | Redimensionar hacia la izquierda (si está configurado) |
| `Prefix + j` | Redimensionar hacia abajo (si está configurado) |
| `Prefix + k` | Redimensionar hacia arriba (si está configurado) |
| `Prefix + l` | Redimensionar hacia la derecha (si está configurado) |

---

# Copiar y pegar

| Atajo | Acción |
| --- | --- |
| `Prefix + [` | Entrar en modo copia |
| `Space` | Iniciar selección |
| `Enter` | Copiar selección |
| `q` | Salir del modo copia |
| `Prefix + ]` | Pegar texto copiado |

---

# Sesiones

| Comando | Acción |
| --- | --- |
| `tmux new -s nombre` | Crear sesión con nombre |
| `tmux ls` | Ver sesiones activas |
| `tmux attach` | Volver a la sesión anterior |
| `tmux attach -t nombre` | Entrar a una sesión concreta |
| `tmux kill-session -t nombre` | Cerrar una sesión |
| `Prefix + d` | Desconectarse dejando tmux ejecutándose |

---

# Modo comando

| Atajo | Acción |
| --- | --- |
| `Prefix + :` | Abrir línea de comandos de tmux |

Comandos útiles:

| Comando | Acción |
| --- | --- |
| `new-window` | Crear ventana |
| `split-window` | Crear panel |
| `list-windows` | Listar ventanas |
| `list-panes` | Listar paneles |
| `resize-pane` | Cambiar tamaño de panel |
| `set mouse on` | Activar ratón |

---

# Información y ayuda

| Atajo | Acción |
| --- | --- |
| `Prefix + ?` | Mostrar todos los atajos |
| `Prefix + t` | Mostrar reloj |
| `Prefix + s` | Lista de sesiones |
| `Prefix + i` | Información del panel |

---

# Comandos de administración

| Comando | Acción |
| --- | --- |
| `tmux new` | Crear nueva sesión |
| `tmux ls` | Listar sesiones |
| `tmux attach` | Reconectar a una sesión |
| `tmux kill-server` | Cerrar todas las sesiones |
| `tmux source-file ~/.tmux.conf` | Recargar configuración |

---

# Atajos esenciales

| Acción | Atajo |
| --- | --- |
| Nueva ventana | `Ctrl+b c` |
| Cambiar ventana | `Ctrl+b n/p` |
| Cambiar por número | `Ctrl+b 0-9` |
| Dividir panel vertical | `Ctrl+b %` |
| Dividir panel horizontal | `Ctrl+b "` |
| Moverse entre paneles | `Ctrl+b flechas` |
| Maximizar panel | `Ctrl+b z` |
| Cerrar panel | `Ctrl+b x` |
| Copiar texto | `Ctrl+b [` |
| Pegar texto | `Ctrl+b ]` |
| Desconectar sesión | `Ctrl+b d` |
| Volver a tmux | `tmux attach` |
| Ver sesiones | `tmux ls` |
| Ver ayuda | `Ctrl+b ?` |
