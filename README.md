The Ohio State University - CSE 5915 - Information Systems Project – Capstone Class
==========
Honda of America, CAE Material Database Project
==========
Joint Collaboration of CSE and MSE student enrolled in their respective Capstone Classes
==========
Virtual Machine/Server Configuration:


<p>
Setting up a virtual machine involves the following steps: </p>
<ol>
  <li> Downloading Ubuntu and Virtual Box </li>
  <li> Creating a virtual machine running Ubuntu </li>
  <li> Customizing the Ubuntu installation </li>
  <li> Installing Ruby and Rails on the virtual machine </li>
<!--  <li> Installing RubyMine on the virtual machine </li> -->
</ol>

<p>
Each of these steps is described below.
If you encounter a problem, please see this
<a href="vm-troubleshooting.shtml">troubleshooting guide</a>.
</p>

<h3> Step 1: Downloading Ubuntu and Virtual Box </h3>

<ol>
<li> Download Ubuntuu 12.04 desktop 32-bit ISO
from <a href="http://www.ubuntu.com/download/desktop">
http://www.ubuntu.com/download/desktop</a>.
  <ol>
  <li> Option 1 (slow): click "Start download" (32 bit) and wait.
  </li>
  <li> Option 2 (faster): with a BitTorrent client (e.g.,
<a href="http://www.bittorrent.com/">http://www.bittorrent.com</a>)
follow "Alternative options" and choose the torrent
ubuntu-12.04-desktop-i386.iso.torrent
  </li>
  </ol>
</li>
<li> Download Virtual Box from
<a href="https://www.virtualbox.org/wiki/Downloads">
https://www.virtualbox.org/wiki/Downloads</a>.
</li>
</ol>

<h3> Step 2: Creating a virtual machine running Ubuntu </h3>

<ol>
<li> Install Virtual Box on your home machine 
(accepting Oracle drivers if prompted).
</li>
<li> Run Virtual Box.
</li>
<li> Machine > New... then use the
following values in the wizard:
  <dl>
  <dt>Name</dt> <dd>Something of your choosing (e.g., CleanUbuntu 12.04 32bit).</dd>
  <dt>OS: Operating System</dt> <dd>Linux</dd>
  <dt>OS: Type</dt> <dd>Ubuntu</dd>
  <dt>Memory Size</dt> <dd>512 MB or bigger (recommend about 1/4-1/2 of your 
machine's installed RAM)</dd>
  <dt>Start-up Disk</dt> <dd>checked (Create new hard disk also checked)</dd>
  <dt>File Type</dt> <dd>VDI</dd>
  <dt>Storage</dt> <dd>Dynamically allocated</dd>
  </dl>
</li>
<li> Install Ubuntu on new virtual machine by first starting the
newly created machine (Machine > Start), then with the "First Use"
wizard selecting the Ubuntu ISO file downloaded in step 1.  As
Ubuntu boots up for the first time, use the following responses:
  <ol>
  <li> Select "install Ubuntu" (not "try") </li>
  <li> Download updates and install 3rd party software </li>
  <li> Yes, erase the hard disk (don't worry, it's the <em>virtual
machine's</em> hard disk that will be erased!)</li>
  <li> Set location: Columbus, OH </li>
  <li> keyboard layout: English US </li>
  <li> Enter your name (e.g., Jane Doe), a computer name (e.g. cse3901-VirtualBox)
an admin user id (e.g. jdoe), and password  </li>
  <li> Reboot  (When prompted to "please eject media", just hit enter) </li>
  </ol>
</li>
<li> Configure the virtual machine to make it easier to work with.
  <ol>
  <li> With the virtual machine running, locate the top menu of that
    window and click Devices > Shared Clipboard > Bidirectional.  This
    allows you to cut-and-paste from the guest to host and vice versa.
  <li> In the same menu, click Devices > Install Guest Additions....
    Then run the CD, eject the CD, and finally reboot.  The guest
    additions allow you to resize the guest desktop.
  </li>
  </ol>
</li>
<li> (optional, only for newer host machines) Enable 3D acceleration.
First shut down the virtual machine (click the power icon in upper right corner,
then Shut Down...), then from the Virtual Box Manager window
click Settings > Display > Enable 3d acceleration.
</li>
<li> (optional, only for multicores) If your VM is sluggish, you
might get better perfomance by allocating more processors.
First shut down the virtual machine,
then from the Virtual Box Manager window
click Settings > Processor > choose 2 or more.
</ol>

<h3> Step 3: Customizing the Ubuntu installation </h3>

<p>Starting with this step, you may find it easiest to
  read these directions using your virtual machine's
  browser.  That will let you easily download as well as
  cut-and-paste as necessary.</p>

<h4> Required Customizations </h4>

<ol>
<li> Start the virtual machine and log in.  The account you
created in the previous step has administrator privileges
which will allow you to do the following customization steps.
</li>
<li> Update the distribution by openning a terminal window and
typing the following (the "$" is the command prompt, don't type that!):
<pre>
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get dist-upgrade
$ sudo reboot
</pre>
</li>
<li> Install some useful linux tools:
<!-- $ sudo apt-get install vim -->
<!-- sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install sublime-text -->
<pre>
$ sudo apt-get install emacs
$ sudo apt-get install curl
$ sudo apt-get install git-core
$ sudo apt-get install mercurial
</pre>
</li>
<li> Customize firefox by installing the following add-ons:
live http headers, firebug, total validator, web developer,
colorzilla, yslow, and sqlite manager.
<!--  total validator requires java!!
Maybe this isn't the best choice for the VM -->
To install an add-on, first launch firefox, then use
the top-level toolbar menu item: Tools > Add-ons.
</li>
</ol>

<h4> Optional (but recommended) Customizations </h4>

<ol>
<li> Add the terminal to the launcher:
  <ol>
  <li> Open the Dash Home
(top icon in the launcher along the left margin of the display) </li>
  <li> Search for "terminal" </li>
  <li> Run terminal and while it is open, find its icon in the launcher </li>
  <li> Right-click on terminal's launcher icon and select "Lock to launcher" </li>
  </ol>
</li>
<li> Create an SSH private-public key pair to facilitate logging
  in to a remote machine without typing a password:
  <ol>
  <li> Create the key pair. When prompted, accept the default location
    (ie ~/.ssh/id_rsa) and default passphrase (ie empty for none):
    <pre> $ ssh-keygen -t rsa </pre> </li>
  <li> Copy the generated public key (~/.ssh/id_rsa.pub)
    to the remote machine you will be logging in to
    (eg your CSE account on stdlinux):
    <pre> $ ssh-copy-id doeja@stdlinux.cse.ohio-state.edu </pre>
    You will be prompted for your stdlinux password to complete
    the operation.</li>
  <li> Confirm that you can now log in to the remote machine from
    the virtual machine without typing your password:
<pre> [jdoe@cse3901-VirtualBox ~] $ ssh doeja@stdlinux.cse.ohio-state.edu
 [doeja@beta ~] $ </pre> </li>
  </ol>
</li>
<li> Customize the terminal prompt:
  <ol>
  <li> Edit the file .bashrc in your home directory </li>
  <li> Change the line that sets PS1.  For detailed
  instructions see
  <a href="https://help.ubuntu.com/community/CustomizingBashPrompt">
  https://help.ubuntu.com/community/CustomizingBashPrompt</a>.
  For a short, simple prompt, you can use:
    <pre>PS1="[${debian_chroot:+($debian_chroot)}\u \W]\\$ "</pre> </li>
  </ol>
</li>  
</ol>

