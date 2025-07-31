import {defineConfig} from 'eslint/config';
import markdown from '@eslint/markdown';

export default defineConfig([
  {
    files: ['**/*.md'],
    plugins: {
      markdown,
    },
    language: 'markdown/commonmark',
    languageOptions: {
      frontmatter: 'yaml',
    },
    extends: ['markdown/recommended'],
    rules: {
      'markdown/no-duplicate-headings': 'error',
      'markdown/no-missing-label-refs': 'off', // collides with Liquid
    },
  },
]);
