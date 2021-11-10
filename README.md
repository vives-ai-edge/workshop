# AI@EDGE workshop

[![Netlify Status](https://api.netlify.com/api/v1/badges/9f9d3a17-b45c-40ff-870d-bb213b7bcd5d/deploy-status)](https://app.netlify.com/sites/ai-edge-workshop/deploys)

Course materials for AI@EDGE workshop.

## Install software packages

Setup script to add default users to Linux instances. It will create the users, add a password and add theire public keys.

```shell
bash <(curl -sL ai-edge-workshop.netlify.app/setup.sh)
```

## Installation

Clone the project and run the following npm command:

```shell
npm install
```

## Development

To start developing you can start up a webserver with the flowing command:

```shell
npm run dev
```

You can now view the result in your webbrowser at [`http://localhost:8080/`](http://localhost:8080/)

## Issues

Feel free to submit issues and enhancement requests.

## Contributing

Please refer to each project's style and contribution guidelines for submitting patches and additions. In general, we follow the "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

NOTE: Be sure to merge the latest from "upstream" before making a pull request!

## License

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
