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
        from: '../scripts/setup.sh',
        to: './',
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
      {
        title: 'Hello World',   // required
        collapsable: false, // optional, defaults to true
        sidebarDepth: 0,    // optional, defaults to 1
        children: [
          '/01-hello-world/01-introduction/',
          '/01-hello-world/02-training-a-model/',
          '/01-hello-world/03-run-inference/',
        ]
      },
      {
        title: 'AB Writing',   // required
        collapsable: false, // optional, defaults to true
        sidebarDepth: 0,    // optional, defaults to 1
        children: [
          '/02-ab-writing/01-edge-impulse/',
          '/02-ab-writing/02-creating-a-project/',
          '/02-ab-writing/03-inspecting-firmware/',
          '/02-ab-writing/04-connecting-a-device/',
          '/02-ab-writing/05-capturing-and-importing-data/',
          '/02-ab-writing/06-creating-an-impulse/',
          '/02-ab-writing/07-feature-generation/',
          '/02-ab-writing/08-NN-classification/',
        ]
      },
      {
        title: 'Live Classification',
        collapsable: false,
        sidebarDepth: 0,
        children: [
          '/03-live-classification/01-live-classification/',
          '/03-live-classification/02-deployment/',
        ]
      },
    ]
  },
}
