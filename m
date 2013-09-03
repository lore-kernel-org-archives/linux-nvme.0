From: alma.diaz@gmx.com (alma diaz)
Date: Tue, 03 Sep 2013 01:01:21 -0400
Subject: Nvme Pcie hotplug
Message-ID: <20130903050121.59290@gmx.com>

Hi All,
 
I have been trying to use Linux NVMe dirver for testing hotplug on HP and dell servers. But I see some problems. So I wanted to know if the opensource NVMe driver supports 'hotplug', or any code changes required to support the feature?
 
All the hotplug related modules acpiphp, pciehp and pci_hotplug were loaded before performing tests. The first problem seen is that the device is not detected once the surprise remove-inertion is done. Second is that, the device gets detected sometime after surprise remove-inertion, but the IOs do not resume on the device. The application just hangs.
 
Any pointers on what should be done to make it work. I would appreciate the help.
 
Thanks in advance.
 
chao
~alma
