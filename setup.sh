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

repository=""
currentRepo="https://github.com/edwardramirez31/micro-frontend-utility-module"
read -p "🔷 Enter your GitHub repository URL name to add semantic release: " repository
sed -i "s,$currentRepo,$repository,g" .releaserc

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
