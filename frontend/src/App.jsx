import { useEffect, useState } from 'react'
import './App.css'

function App() {
  const [destinos, setDestinos] = useState([])
  const [ruta, setRuta] = useState([])
  const [busqueda, setBusqueda] = useState('')
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    fetch('http://127.0.0.1:8000/api/destinos/')
      .then((respuesta) => {
        if (!respuesta.ok) {
          throw new Error('no se pudieron obtener los destinos')
        }

        return respuesta.json()
      })
      .then((datos) => {
        setDestinos(datos)
        setCargando(false)
      })
      .catch(() => {
        setError('no se pudo conectar con el servidor de django')
        setCargando(false)
      })
  }, [])

  function agregarARuta(destino) {
    const yaExiste = ruta.some((item) => item.id === destino.id)

    if (!yaExiste) {
      setRuta([...ruta, destino])
    }
  }

  function quitarDeRuta(id) {
    setRuta(ruta.filter((destino) => destino.id !== id))
  }

  const destinosFiltrados = destinos.filter((destino) =>
    destino.nombre.toLowerCase().includes(busqueda.toLowerCase())
  )

  const costoTotal = ruta.reduce(
    (total, destino) => total + Number(destino.precio),
    0
  )

  return (
    <div className="app">

      <header>
        <h1>ThakaTravel</h1>
      </header>

      <main>

        <h2>Arma tu Ruta</h2>

        <p className="descripcion">
          selecciona los destinos que deseas visitar en tu recorrido turístico
        </p>

        {cargando && (
          <p className="mensaje">
            cargando destinos...
          </p>
        )}

        {error && (
          <p className="error">
            {error}
          </p>
        )}

        <section className="destinos">

          <h2>Destinos disponibles</h2>

          <input
            type="text"
            placeholder="🔎 buscar destino..."
            className="buscador"
            value={busqueda}
            onChange={(e) => setBusqueda(e.target.value)}
          />

          {destinosFiltrados.length === 0 && !cargando && (
            <p className="mensaje">
              no se encontraron destinos
            </p>
          )}

          {destinosFiltrados.map((destino) => (

            <article className="destino" key={destino.id}>

              <h3>{destino.nombre}</h3>

              <p>
                {destino.descripcion}
              </p>

              <p>
                <strong>Ciudad:</strong> {destino.ciudad}
              </p>

              <p>
                <strong>Categoría:</strong> {destino.categoria}
              </p>

              <p>
                <strong>Precio:</strong> Bs. {destino.precio}
              </p>

              <button onClick={() => agregarARuta(destino)}>
                agregar a mi ruta
              </button>

            </article>

          ))}

        </section>

        <section className="mi-ruta">

          <h2>Mi ruta</h2>

          {ruta.length === 0 ? (

            <p>
              todavía no has seleccionado ningún destino
            </p>

          ) : (

            <>
              <p className="contador">
                destinos seleccionados:{' '}
                <strong>{ruta.length}</strong>
              </p>

              {ruta.map((destino, index) => (

                <div className="ruta-item" key={destino.id}>

                  <span>
                    {index + 1}. {destino.nombre}
                  </span>

                  <button
                    onClick={() => quitarDeRuta(destino.id)}
                  >
                    quitar
                  </button>

                </div>

              ))}

              <div className="total">
                <span>
                  costo total estimado
                </span>

                <strong>
                  Bs. {costoTotal.toFixed(2)}
                </strong>
              </div>
            </>

          )}

        </section>

      </main>

    </div>
  )
}

export default App