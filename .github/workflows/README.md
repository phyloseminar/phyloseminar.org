

## CI / CD

Phyloseminar uses github actions for contionuous integation and deployment.
The workflow build.yml contains the jobs build, which will run on any PR
submitted against `main`. Upon any push to `main` (or triggered manually on gh), 
the build _and_ deploy jobs are run to install the necesarry depenencies 
(Ruby and Python, mainly) and sync the updated build files 
(in website/\_site/) to Erick's phyloseminar.org
