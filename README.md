# Zend Vagrant Template

This project provides a very slim Zend edition with a vagrant/puppet support. It can be used as template for new
projects.

## Setup

-   Install vagrant on your system
    see [vagrantup.com](http://vagrantup.com/v1/docs/getting-started/index.html)

-   Get a base box with puppet support
    see [vagrantup.com docs](http://vagrantup.com/v1/docs/getting-started/boxes.html)

-   Install composer on your system
    see [getcomposer.org](http://getcomposer.org/doc/00-intro.md)

-   Create a new project from this template:
    ```bash
        composer create-project tonicospinelli/zend-vagrant <project-path> --stability="dev"
    ```
-   Remember to include the host and ip in file hosts:
    ```bash
        sudo sh -c 'echo "<vm_ip_address> <domain>" >> /etc/hosts'
    ```

-   In your project directory:
    -   Copy `vagrant/BoxConfiguration.dist` to `vagrant/BoxConfiguration` and modify `vagrant/BoxConfiguration` according to your needs.

        Example:

        ```ruby
            $vhost = "test"
            $ip = "192.168.10.42"

            $use_nfs = true

            $base_box = "ubuntu-server-i386"

            $webserver = "nginx"
        ```
    -   Execute "vagrant up" in the directory vagrant.

## Infrastructure

After performing the steps listed above, you will have the following environment set up:

- A running virtual machine with your project on it
- Your project directory will be mounted as a shared folder in this virtual machine
- Your project will be accessible via a browser (go to `http://{$vhost}.dev/[index.php]`)
- You can now start customizing the new virtual machine. In most cases, the machine should correspond to the infrastructure your production server(s) provide.
