# WInd_energy_model
Wind_energy_class_model

This is the repository where we have the matlab function codes.

We need a terminal to interact with github easily. Ubuntu and Mac will have inbuilt terminals. Win10 has Ubuntu app but it's a bit pain. So, I suggest all of you to install Cygwin (https://cygwin.com/install.html) and follow these guidelines to install cygwin (http://www.mcclean-cooper.com/valentino/cygwin_install/). 


In the search bar to install stuff, please make sure that you searh for "git" and install all which has word "git".  (this will avoid the errors you are getting "git clone" not found.

Cygwin is terminal emulator and can be used to run python or C++ with MPI also. It helps you interact with your computer via terminal. Infact, geeks use only terminal to do all work but let's not go in there. I also do not know many shortcuts. 

Once you have installed Cygwin. These basic linux commands are important to interact via terminal

The commands are as follows:
"pwd" - present working directory, gives the folder you are in
"cd home/yourdirectory/projectfolder/subfolder" - changes your current directory to the location where your subfolder is
"ls -lrt" - lists down all the files and folders available 
"mkdir" - creates new folder

Now, you know the basic commands. Once you open the terminal, do "pwd" to know the current directory. You might get something like this 

/home/yourusername.

Now, using your mouse just create project folder with name of your interest and in some drive where you would like to keep all your working files and folders. If you have already one, ignore this. Now go into that folder and go to the location bar and right click and do copy. 

Now go into terminal and type "cd" and give a space and paste by using mouse but not (ctrl+v) and press enter. Now you are in the folder
Now type "mkdir code" - this creates the folder called code. Now type "cd code" and enter.

type "gitclone https://github.com/venkatshgithub/WInd_energy_model.git" . This will work only if I added you as collaborator. 

and type "git pull" and enter

If anywhere, it asks for the username and password. Please enter your git username and password.

Now you are good to go.

You can work like all the time and you can keep all the CODE files ONLY in this git repository aka code folder. Please do not keep heavy files. 

The git commands you need to know:

do configure your email first to make commits. That can be done by using this:

>> git config --global user.email "email@example.com"

and check by typing 

>> git config --global user.email

you should get your email id what you entered.

Then you can do the below as described.
Step 1: "git add --a " is usefull to add your changes to the server but no one can see. 
Step 2: git commit -m "your comments for the changes" is to confirm your changes to the serve with comments
Step 3: git push will push your code to everyone and will get a notification about your changes

Always, use Step 1,2 in the order. If someone pushes the code, do always pull to get the updated code.
