# Local Git Server

To create the server, you should install the Vagrant tool and also a hypervisor on your machine.

The Git server can be set up by running the `vagrant up` command.

The server uses an internal network.

The characteristics of the machine are 1 CPU core and 2 gigabytes of RAM. These can be adjusted in the Vagrantfile.

## How to Set Up

1.  Install the Vagrant and hypervisor tools on your machine.
2.  Clone the project.
3.  Inside the project directory, run the command `vagrant up`.

## How to Use

To create a new remote repository, run `ssh creator@192.168.33.33`. The address should be the same as the one set in the Vagrantfile.

The prompt will ask you for the repository name and then return the remote URL.

Use this URL to add the remote to your local Git repository.