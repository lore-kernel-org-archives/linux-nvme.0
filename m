From: martinus.gpy@gmail.com (martinus.gpy@gmail.com)
Date: Mon,  1 Apr 2019 22:09:55 +0530
Subject: [PATCH 0/2] nvme-cli: update NetApp plugin for ONTAP devices
Message-ID: <20190401163957.2899-1-marting@netapp.com>

From: Martin George <marting@netapp.com>

These patches update the current NetApp plugin to handle
NetApp ONTAP devices.

Martin George (2):
  nvme-cli: add netapp ontapdevices command
  nvme-cli: add netapp ontapdevices man page

 Documentation/nvme-netapp-ontapdevices.1    |  74 ++
 Documentation/nvme-netapp-ontapdevices.html | 814 ++++++++++++++++++++
 Documentation/nvme-netapp-ontapdevices.txt  |  35 +
 plugins/netapp/netapp-nvme.c                | 342 ++++++++
 plugins/netapp/netapp-nvme.h                |   1 +
 5 files changed, 1266 insertions(+)
 create mode 100644 Documentation/nvme-netapp-ontapdevices.1
 create mode 100644 Documentation/nvme-netapp-ontapdevices.html
 create mode 100644 Documentation/nvme-netapp-ontapdevices.txt

-- 
2.17.1
