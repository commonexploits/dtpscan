DTPScan
========

Detects DTP modes for VLAN Hopping (passive check)

DTPscan will passively sniff the network and detect which switchport mode the switch is configured in to assist with VLAN hopping attacks.

Frogger script can be used to actively attack DTP in an attempt to VLAN hop, but until now the only real way to tell was to review the Cisco switch config file to see how the port is configured to know if it is possible.

This will detect the hex code from DTP and know which mode the switch port is in and give you a result to say if VLAN hopping is possible. As this is passive (does not attack DTP) this is very useful to know it advance.


* This will be a feature of Frogger version 2 soon -  releasing DTPscan for now. Frogger 2 will have major changes and will support passive gathering, active attacks and will support ISL as well as 802.1Q.


Developed by Daniel Compton

https://github.com/commonexploits/dtpscan

Released under AGPL see LICENSE for more information


Installing
========

    git clone https://github.com/commonexploits/dtpscan.git

How To Use
========

    ./dtpscan.sh


Features
========

* Passively detects the DTP mode of a Cisco switch for VLAN hopping
* Reports if switch is in Default mode, trunk, dynamic, auto or access mode

Screen Shots
========

![](http://commonexploits.com/wp-content/uploads/2013/09/dtp1.jpg)

![](http://commonexploits.com/wp-content/uploads/2013/09/dtp2.jpg)

![](http://commonexploits.com/wp-content/uploads/2013/09/dtp3.jpg)


Change Log
========
* Version 1.3 - Small message typo in output fixed.
* Version 1.2 - Fixed script. Updates to tshark caused script to break. 
* Version 1.1 - Updated working
* Version 1.0 - First release. * it may need to work on some of the DTP codes/modes with more testing.