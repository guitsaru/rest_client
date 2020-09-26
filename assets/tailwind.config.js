const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  future: {
    removeDeprecatedGapUtilities: true,
    purgeLayersByDefault: true,
  },
  purge: [
    "../lib/rest_client_web/templates/**/*.eex",
    "../lib/rest_client_web/templates/**/*.leex",
    "../lib/rest_client_web/live/**/*.leex",
    "../lib/rest_client_web/views/**/*.ex",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  variants: {},
  plugins: [require("@tailwindcss/custom-forms")],
};
