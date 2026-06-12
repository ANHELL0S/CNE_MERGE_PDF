import { faThumbsUp } from "@fortawesome/free-solid-svg-icons";
import { InlineLink } from "../links/inline.tsx";
import { Modal } from "./base.tsx";

const SUPPORT_LINK = (
	<InlineLink to="https://cne.gob.ve">apoyar iniciativas cívicas</InlineLink>
);
const REACT_LINK = <InlineLink to="https://reactjs.org/">React</InlineLink>;
const GATSBY_LINK = (
	<InlineLink to="https://www.gatsbyjs.org/">Gatsby</InlineLink>
);
const TAILWIND_CSS_LINK = (
	<InlineLink to="https://tailwindcss.com/">Tailwind CSS</InlineLink>
);
const GITHUB_PAGES_LINK = (
	<InlineLink to="https://pages.github.com/">GitHub Pages</InlineLink>
);
const BOLIVAR_ICON_LINK = (
	<InlineLink to="https://thenounproject.com/icon/bolivar-1974111/">
		Ícono "Bolívar"
	</InlineLink>
);
const BOLIVAR_ICON_LICENSE_LINK = (
	<InlineLink to="https://creativecommons.org/licenses/by/3.0/">
		CC BY
	</InlineLink>
);
const FONT_AWESOME_LINK = (
	<InlineLink to="https://fontawesome.io/">FontAwesome</InlineLink>
);

/**
 * A modal that displays info about the site – Cne Bolivar
 */
export function AboutModal(props: {
	id: string;
	author: string;
	authorUrl: string;
}) {
	const authorLink = (
		<InlineLink to={props.authorUrl} rel="author">
			{props.author}
		</InlineLink>
	);

	return (
		<Modal
			id={props.id}
			title="Acerca de"
			buttonIcon={faThumbsUp}
			buttonLabel="Entendido"
		>
			<br />
			<p>Hecho ❤️ por {authorLink}</p>
			<br />
			<p>
				Funciona gracias a {REACT_LINK} + {GATSBY_LINK} + {TAILWIND_CSS_LINK}.
			</p>
			<br />
			<p>
				<strong>Nota institucional:</strong> Este sitio no es el sitio oficial
				del CNE - BOLIVAR. Para trámites oficiales, consulte los canales
				autorizados del Consejo Nacional Electoral Delegación Bolívar.
			</p>
		</Modal>
	);
}
