import {
	faEye,
	faMoon,
	faSun,
	faWandMagic,
	faWandMagicSparkles,
} from "@fortawesome/free-solid-svg-icons";
import { Modal } from "./base.tsx";
import { Toggle } from "../toggle.tsx";
import {
	AllowMotionContext,
	DarkThemeContext,
} from "../../common/utilities.ts";

/**
 * A toggle component used to change the page theme
 */
function ThemeToggle() {
	return (
		<Toggle
			className="pl-0"
			label="tema oscuro"
			context={DarkThemeContext}
			htmlAttribute="data-theme"
			disabled={["light", faSun]}
			enabled={["dark", faMoon]}
		/>
	);
}

/**
 * A toggle component used to change the `motion-allowed` property
 */
function MotionToggle() {
	return (
		<Toggle
			className="pl-0"
			label="animaciones"
			context={AllowMotionContext}
			htmlAttribute="data-motion"
			disabled={["reduce", faWandMagic]}
			enabled={["allow", faWandMagicSparkles]}
		/>
	);
}

/**
 * A modal that allows setting options for the site – Cne Bolivar
 */
export function OptionsModal(props: { id: string }) {
	return (
		<Modal
			id={props.id}
			title="Opciones"
			buttonIcon={faEye}
			buttonLabel="Aplicar"
		>
			<br />
			<p>Puedes cambiar varias opciones del sitio aquí.</p>
			<br />
			<div className="flex-col w-fit">
				<MotionToggle />
				<ThemeToggle />
			</div>
			<br />
			<p className="text-sm text-gray-500">
				Nota: Las opciones se guardan automáticamente en tu navegador.
			</p>
		</Modal>
	);
}
