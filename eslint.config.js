const globals = require('globals')
const { FlatCompat } = require('@eslint/eslintrc')
const eslintPluginReact = require('eslint-plugin-react')
const eslintPluginReactHooks = require('eslint-plugin-react-hooks')

const compat = new FlatCompat()

module.exports = {
  ignores: ['dist', 'node_modules'],
  files: ['**/*.{js,jsx,ts,tsx}'],
  languageOptions: {
    ecmaVersion: 2020,
    globals: {
      ...globals.browser,
      $: 'readonly', // jQuery와 같은 라이브러리를 사용할 때
      chrome: 'readonly', // Chrome 확장 프로그램 API
    }
    // globals.browser,
  },
  plugins: {
    react: eslintPluginReact,
    'react-hooks': eslintPluginReactHooks,
  },
  rules: {
    semi: ['error', 'never'],
    indent: ['error', 2],
  },
  settings: {
    react: {
      version: 'detect',
    },
  },
}
