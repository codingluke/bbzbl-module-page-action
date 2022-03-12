pandocPlugin = require("markdown-it-pandoc");
katexPlugin = require("katex");
textmathPlugin = require("markdown-it-texmath");
// config = require("../config");

module.exports = {
  // site config
  base: "/bbzbl-slides/page/",
  lang: 'en-US',
  title: 'BBZBL - Modul 404',
  description: 'This is my first VuePress site',

  // theme and its config
  theme: '@vuepress/theme-default',
  themeConfig: {
    // logo: '/images/logo.png',
    darkMode: false,
    // navbar: config.themeConfig.navbar
  },
  extendsMarkdownOptions: (markdownOptions, app) => {
    markdownOptions.html = true
  },
  extendsMarkdown: md => {
    md.use(pandocPlugin)
  }
};
