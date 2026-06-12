import { faCookieBite } from "@fortawesome/free-solid-svg-icons";
import { Modal } from "./base.tsx";

/**
 * A modal that displays the privacy policy for the site related to Cne Bolivar
 */
export function PrivacyModal(props: { id: string }) {
	return (
		<Modal
			id={props.id}
			title="Políticas de Privacidad"
			buttonIcon={faCookieBite}
			buttonLabel="Aceptar"
		>
			<br />
			<p>
				Todos los procesos se realizan localmente en tu dispositivo — ningún
				archivo PDF se sube a nuestros servidores. Esto también hace que el
				proceso de fusión sea más rápido.
			</p>
			<br />
			<p>
				Si cambias alguna opción, se usará el almacenamiento local para guardar
				tu configuración entre visitas. Puedes borrar los datos guardados de
				este sitio en la configuración de tu navegador.
			</p>
			<br />
			<p>
				Este sitio puede recopilar análisis de uso anónimos. Estos datos se usan
				para ayudarme a mejorar el sitio y NO incluyen información personal
				identificable ni detalles sobre los archivos PDF que añadas. Estos datos
				no se usan para rastreo ni marketing.
			</p>
			<br />
			<p>
				<strong>Políticas adicionales para Cne Bolivar:</strong>
				<br />
				Este sitio cumple con las normativas de protección de datos aplicables
				en el ámbito bolivariano. La información procesada no será compartida
				con terceros sin tu consentimiento explícito, a menos que lo exija la
				ley. Para consultas oficiales, contacta a través de los canales
				autorizados del CNE o entidades competentes.
			</p>
		</Modal>
	);
}
