#!/bin/bash

re=^[A-Za-z0-9_-]+$

project=""
while ! [[ "${project?}" =~ ${re} ]]
do
  read -p "🔷 Enter the project name (can use letters, numbers, dash or underscore): " project
done

service=""
while ! [[ "${service?}" =~ ${re} ]]
do
  read -p "🔷 Enter the micro frontend name (can use letters, numbers, dash or underscore): " service
done


while true; do
    read -p "🔷 Do you want to use Semantic Release? [y/N]: " yn
    case $yn in
        [Yy]* )
          domContainerElement=""
          sed -i "s/mf-content/$domContainerElement/g" src/project-micro-frontend-name.tsx
          repository=""
          currentRepo="https://github.com/edwardramirez31/micro-frontend-utility-module"
          read -p "🔷 Enter your GitHub repository URL name to add semantic release: " repository
          sed -i "s,$currentRepo,$repository,g" .releaserc
          break
        ;;
        [Nn]* )
          rm .releaserc
          sed -i.bak -e '44,48d' .github/workflows/main.yml && rm .github/workflows/main.yml.bak
          sed -i.bak -e '46,47d;74d' package.json && rm package.json.bak
          break
        ;;
        * ) echo "Please answer yes or no like: [y/N]";;
    esac
done

while true; do
    read -p "🔷 Do you want to release this utility module to NPM? [y/N]: " yn
    case $yn in
        [Yy]* )
          echo "⚠️  Don't forget setting NPM_TOKEN secret at your repository with an NPM Automation Access Token so that your utility can be deployed to NPM"
          break
        ;;
        [Nn]* )
          rm .npmignore
          sed -i.bak -e '51,56d' .github/workflows/main.yml && rm .github/workflows/main.yml.bak
          break
        ;;
        * ) echo "Please answer yes or no like: [y/N]";;
    esac
done

sed -i "s/my-app/$project/g" package.json
sed -i "s/utility/$service/g" package.json
sed -i "s/my-app-utility/$project-$service/g" tsconfig.json
sed -i "s/'my-app'/'$project'/g" webpack.config.js
sed -i "s/utility/$service/g" webpack.config.js
mv src/my-app-utility.tsx "src/$project-$service.tsx"


echo "🔥🔨 Installing dependencies"
yarn install
echo "🔥⚙️ Installing Git Hooks"
yarn husky install
echo "🚀🚀 Project setup complete!"
echo "✔️💡 Run 'yarn start' to boot up your single-spa root config"
