## Introduction 🉑
### What is tasktifer?
> Tasktifier, most likely the same as a Todo List integrate with the GoogleClassroomAPI. Where you will able to see your classworks/activities/assignment
> from the Google Classroom here to our app **Tasktifier**

![image](https://github.com/KiyoScript/tasktifier/assets/89757149/9228ae32-35c1-49e6-85e9-8388b5b21021)

### How to use?
- Go to this page [https://tasktifier.fly.dev/sign_in](https://tasktifier.fly.dev/sign_in)
- New user?, no problem you can sign in using your google account instead of creating an account. Just click the sign in with Google.
  [Login Page](https://github.com/KiyoScript/tasktifier/assets/89757149/c6ca7ef5-8b9a-4e16-afae-8d0ec9303638)
- Student User?, used GoogleAccount that you're using to used the GoogleClassroom.
- Regular User?, register manually go to this page [tasktifier.fly.dev/sign_up](https://tasktifier.fly.dev/sign_up)

### Difference between the Student user and Regular user.
#### Student User
- Able to fetch its Activities/Schoolwork from the GoogleClassroom.
- Able to create a task, update, view and delete.
- Able to crate a specific category which can bundle or group the all the tasks including the update, view and delete function.
- Able to navigatate the Google Classrom Link and knowing the Classworks Statuses.
- Can view its own profile, change the its information including the password
- Can Deactivate and Reactovate account. 


#### Regular User
- **Most likely the same as the Student** user except for Fetching the Google Classroom Class Works.
- Some of the Regular user used their Gmail for Logged In the app however that gmail account don't have GoogleClassroom. 

#### Admin User
- Has all the abilities except for deleting an user account.

## Instruction 📝
### How to run this app to your Local? 

1. Install Ruby:

    - Download the Ruby+Devkit installer from the RubyInstaller website (https://rubyinstaller.org/downloads/).
    - Run the installer and follow the instructions to install Ruby on your system.
    - Make sure to select the option to "Add Ruby executables to your PATH" during the installation.

2. Install Node.js:
    - Download the Node.js installer from the official Node.js website (https://nodejs.org/en/download/).
    - Run the installer and follow the instructions to install Node.js on your system.

3. Install the Rails gem:
    - Open a command prompt or terminal window.
    - Run the following command to install the Rails gem:
    - Run: `gem install rails`


4. Install database dependencies:
    - Download and install PostgreSQL from the official website (https://www.postgresql.org/download/). Since this app used **Postgresql**


5. Clone this app:
    - Run the following command.
    - Run: `git clone https://github.com/KiyoScript/tasktifier.git`
    - Navigate the tasktifer directory or cd pathname/tasktifer if you're using WSL.
    - Run: `rails db:create && rails db:seed && bundle install && rails db:migrate`

6. To run the App
    - Run: `rails s` or `rails s -p 5000`  
