# vagrant-icedtea

Create a vagrant managed machine to access legacy ipmi web portals using icedtea (an open source java web start implementation). Specifically, this project targets ipmi web portals which lack modern security algorithms.

## Prerequisites

### `vagrant` and VirtualBox

This project requires a `vagrant` install using the VirtualBox provider.

If you're new to `vagrant`, installation and basic use can be seen in [Vagrant: Development Environments Made Easy](https://github.com/werekraken/wktt/blob/master/Vagrant/README.md).

### VirtualBox Guest Additions

The VirtualBox Guest Additions shipped with the box are unlikely to match your host VirtualBox installation. Installing the `vagrant-vbguest` plugin is recommended to ensure the Guest Additions features required for display, mouse, keyboard, and shared folders are available.
```
vagrant plugin install vagrant-vbguest
```

`vagrant-vbguest` installation can be seen in [VirtualBox Guest Additions](https://www.youtube.com/watch?v=0JcFdpUITBE).

## Usage

### Starting the VM.

Bring up the machine and you should be presented with a VirtualBox window shortly thereafter. By the time `vagrant up` completes that same window should contain a GUI.
```
vagrant up
```

### Accessing an IPMI (Common Steps).

* Close the "Authentication is required to create a color managed device" prompt.
* Open Firefox.
  * Option 1: select "Web Browser" from the dock at the bottom center of the desktop.
  * Option 2: select "Applications" > "Web Browser" at the upper left corner of the desktop.
* Open a new tab.
* Close the "Welcome to Firefox" tab when ready.
* Close the "Firefox Privacy Notice" tab when ready.
* Enter the ipmi IP address or hostname (if resolvable) in the address bar.
* Firefox may display "Warning: Potential Security Risk Ahead" instead of the page.
  * Click "Advanced..." to display additional information and options.
  * A potential risk commonly triggered by ipmi web portals is "The certificate is not trusted because it is self-signed."
  * Click "Accept the Risk and Continue" if you so choose.
* ipmi web portals generally prompt for login at this point.
  * Enter the ipmi credentials.
* Navigate the ipmi web portal and click as needed to download the `.jnlp` file.
  * For example, "Launch Java KVM Client".
* Click the `.jnlp` in the Firefox downloads menu to open it.
* You may see a "The application's digital signature cannot be verified..." prompt.
  * Click "Run" if you so choose.
* You may see a "The application... uses... resources from the following remote locations..." prompt.
  * Click "Yes" if you so choose.
* You may see a "The connection to... is untrusted..." prompt.
  * Click "Run" if you so choose.
* With a bit of luck, you should now see the ipmi KVM viewer window.
  * If the screen is blank, you may have to press a key for video to display.
  * An arrow key is usually safe.

### Halting the VM.

Halting will shutdown the VM and free up the cpu and memory resources it uses while running. It will still consume storage resources while halted. However, the machine will boot up and be ready for use much faster than during creation.

### Destroying the VM.

Destroying the VM will shutdown and delete the VM. This frees up cpu, memory, and storage resources consumed by the VM environment. However, the machine must be fully recreated the next time it's needed.

## Corners

The screensaver may activate and require a password. The default credentials for this box are:
* username: `vagrant`
* password: `vagrant`
