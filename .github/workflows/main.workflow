# This is a basic workflow to help you get started with Actions

name: Build-Test-Deploy-1

# Controls when the workflow will run
on:
  # Triggers the workflow on push or pull request events but only for the master branch
  push:
    branches: [ master ]
  #pull_request:
   # branches: [ master ]
  #workflow_dispatch:
  #schedule:
   #- cron: '2 * * * *'
   
jobs:
    Build-Job:
       runs-on: ubuntu-latest
       name: Making builds
       steps:
         - uses: actions/checkout@v1
         - name: Install surge
           uses: actions/setup-node@v1
           with:
             node-version: 14
         - run: npm install -g surge 
    Test-Job1:
         runs-on: ubuntu-latest
         name: test-job1
         needs: Build-Job
         #if: github.ref! = 'refs/heads/production'
         steps:
         - uses: actions/checkout@v1
         - name: Test1
           uses: actions/setup-node@v1
           with:
             node-version: 14
         - run: npm install -g mocha
         - run: npm test
    slackNotification:
        runs-on: ubuntu-latest
        name: slacknotifications
        needs: Build-Job
         #if: github.ref! = 'refs/heads/production'
        steps:
        - uses: actions/checkout@v2
        - name: Slack Notification
          uses: rtCamp/action-slack-notify@v2
          env:
            SLACK_WEBHOOK: https://hooks.slack.com/services/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

