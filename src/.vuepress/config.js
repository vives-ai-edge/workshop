module.exports = {
  title: 'AI@EDGE Workshop',
  description: 'Introduction workshop for AI on embedded systems.',
  dest: 'dist',
  plugins: [
    ['vuepress-plugin-zooming'],
    [
      // includes all files in `sourceDir`
      // ignore dotfiles and markdown
      'vuepress-plugin-public-files', {
        from: 'files',
        to: 'files',
      }
    ],
    ['vuepress-plugin-container', {
      type: 'quote',
      defaultTitle: '',
    }],
    ['vuepress-plugin-container', {
      type: 'right',
      defaultTitle: '',
    }],
    ['vuepress-plugin-container', {
      type: 'tip',
      defaultTitle: 'TIP',
    }],
    ['vuepress-plugin-container', {
      type: 'warning',
      defaultTitle: 'WARNING',
    }],
    ['vuepress-plugin-container', {
      type: 'danger',
      defaultTitle: 'WARNING',
    }],
    ['vuepress-plugin-container', {
      type: 'details',
      before: info => `<details class="custom-block details">${info ? `<summary>${info}</summary>` : ''}\n`,
      after: () => '</details>\n'
    }],
    ['vuepress-plugin-presentation-mode'],
  ],
  serviceWorker: true,
  themeConfig: {
    nav: [
      { text: 'devbit', link: 'https://www.devbit.be/' },
      { text: 'IoT Incubator', link: 'https://iot-incubator.be/' },
      { text: 'EAVISE', link: 'https://iiw.kuleuven.be/onderzoek/eavise' }
    ],
    repo: 'vives-ai-edge/workshop',
    docsDir: 'src',
    docsBranch: 'master',
    sidebarDepth: 1,
    sidebar: [
      // {
      //   title: 'chapter 1',   // required
      //   collapsable: true, // optional, defaults to true
      //   sidebarDepth: 0,    // optional, defaults to 1
      //   children: [
      //     '/chapters/01-demo/',
      //   ]
      // },
    ]
  },
}