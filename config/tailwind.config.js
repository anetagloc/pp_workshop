const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
    content: [
      './public/*.html',
      './app/helpers/**/*.rb',
      './app/javascript/**/*.js',
      './app/views/**/*',
    ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
    colors: {
      transparent: 'transparent',
      'bermuda': '#78dcca',
      'red': '#ef4444',
      'yellow': '#fef08a',
      'green': '#86efac',
      'slate': '#94a3b8',
      'white': '#fff',
      'grey': '#d1d5db',
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
