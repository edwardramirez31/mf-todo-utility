# React Micro Frontend Utility Template

## Getting Started

1. Run the script to initialize the project and install dependencies:

```bash
./setup.sh
```

2. Run `yarn start --port ${YOUR_PORT}` to run locally

3. Add your new micro frontend at the root config module inside

```html
<script type="systemjs-importmap">
  {
    "imports": {
      "react": "https://cdn.jsdelivr.net/npm/react@16.13.0/umd/react.production.min.js",
      "react-dom": "https://cdn.jsdelivr.net/npm/react-dom@16.13.0/umd/react-dom.production.min.js",
      "single-spa": "https://cdn.jsdelivr.net/npm/single-spa@5.3.0/lib/system/single-spa.min.js",
      "@${PROJECT_NAME}/root-config": "//localhost:9000/${PROJECT_NAME}-root-config.js",
      "@${PROJECT_NAME}/{UTILITY_MODULE_NAME}": "//localhost:${YOUR_PORT}/${PROJECT_NAME}-{UTILITY_MODULE_NAME}.js"
    }
  }
</script>
```

4. Register your utility module as external at `webpack.config.js` for each micro frontend

```js
const { merge } = require('webpack-merge');
const singleSpaDefaults = require('webpack-config-single-spa-react-ts');

module.exports = (webpackConfigEnv, argv) => {
  const defaultConfig = singleSpaDefaults({
    orgName: '${PROJECT_NAME}',
    projectName: '${MICRO_FRONTEND_NAME}',
    webpackConfigEnv,
    argv,
  });

  return merge(defaultConfig, {
    // change the placeholders
    externals: ['${PROJECT_NAME}/{UTILITY_MODULE_NAME}'],
  });
};
```

5. Import your utilities at the micro frontend and use them

```js
import { utilityName } from '@${PROJECT_NAME}/{UTILITY_MODULE_NAME}';
```

6. Run `yarn start` to run your root config module

## Important notes

- Maintain consistency for the project name (all micro service and root project should have the same project name)

- It's recommended to use the root config module template from [this template](https://github.com/edwardramirez31/micro-frontend-root-template) to be consistent with project naming convention

- Set ACTIONS_DEPLOY_ACCESS_TOKEN secret at your repository with a GitHub Personal Access Token so that Semantic Release can work properly

  - This token should have full control of private repositories

- If you don't want to use Semantic Release:

  - Remove the step at `.github` or the entire folder
  - Remove `.releaserc` file
  - Remove `@semantic-release/changelog`, `@semantic-release/git`, `semantic-release` from `package.json`
