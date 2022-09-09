# devops-task

## Goal: Demonstrate the ability to automate the deployment of dockerized application

### Infrastructure and tools

- AWS EC2 (or other AWS server-less service)
- AWS S3
- Docker and your preferred docker image
- Ansible / terraform
- Python

### Task

  1. Download regularly (e.g. daily / hourly) some dataset from the free data provider.  
  If you down know any, choose from:  
    - <https://github.com/CSSEGISandData/COVID-19/>  
    - <https://openweathermap.org/current>  
    - <https://covid19datahub.io/>  
  2. Store downloaded dataset to S3 bucket
  3. From every downloaded dataset, extract some specific data (eg data relevant for Czechia, Prague, ...)
  4. Display all extracted data using a single HTML page served from S3. A simple table is enough.
  5. Present the result

### Instructions

- Use well-known language (preferable  Python 3) to create an application
- Create a docker to encapsulate the application logic
- Use the latest ansible / terraform to automate the deployment of the application (docker)
- Put all your source code in a public git repository (e.g. Github)
- Use Readme.MD file for the documentation (while evaluating we will use it)
- If you find problems or do not implement something, you should mention it there

### Bonus points

- Replace EC2 with AWS serverless offering
- Document the next steps to make this small application being ready for production
- Create CI / CD pipelines for your deployment
- Use your imagination and provide more than expected

### [Documentation](docs/README.md)
