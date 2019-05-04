From: jsmart2021@gmail.com (James Smart)
Date: Fri,  3 May 2019 17:04:51 -0700
Subject: [PATCH nvme-cli rfc 0/5] nvmf auto-connect scripts
Message-ID: <20190504000456.3888-1-jsmart2021@gmail.com>

This rfc is a combination of the nvme-fc auto-connect scripts
posted by Hannes and the RFC from Sagi to allow auto-connect for
persistent discovery controllers that send AENs. It does not
contain the code that handles the AEN and generates the event.

The auto-connect scripts are now commonized with the exception
of the nvme-fc boot connections service.  It's expected that both
the persistent discovery controllers and nvme-fc can post the same
udev event. Whenever the discovery aen generates an event, the
new --device=<name> argument will be used to identify the persistent
discovery controller. Other connect attributes will be no-op'd by a
"none" value.  When nvme-fc generates it's events, it will specify
--device=none and specify the discovery controller addressing
arguments.  If a persistent discovery controller exists on nvme-fc,
will do nothing special and AEN's from it will follow the
--device=<name> syntax.

The udev event handler supports both the new event to be used
by discovery controllers. The nvme-fc transport will be migrated
to issue the new event syntax as well. But the udev script will
continue to support the older style nvme-fc event info in case
it's running against an older kernel.

Feedback is welcome.


James Smart (3):
  fabrics: ignore arguments that pass in "none"
  fabrics: allow discover to address discovery controller by persistent
    name
  nvmf auto-connect scripts

Sagi Grimberg (2):
  fabrics: support persistent connections to a discovery controller
  fabrics: add --quiet option

 Makefile                                         | 10 +++-
 fabrics.c                                        | 70 +++++++++++++++++-------
 fabrics.h                                        |  2 +
 nvme.spec.in                                     |  8 +++
 nvmf-autoconnect/70-nvmf-autoconnect.conf        |  1 +
 nvmf-autoconnect/70-nvmf-autoconnect.rules       | 18 ++++++
 nvmf-autoconnect/nvmefc-boot-connections.service |  9 +++
 nvmf-autoconnect/nvmf-connect.target             |  2 +
 nvmf-autoconnect/nvmf-connect at .service           | 14 +++++
 9 files changed, 114 insertions(+), 20 deletions(-)
 create mode 100644 nvmf-autoconnect/70-nvmf-autoconnect.conf
 create mode 100644 nvmf-autoconnect/70-nvmf-autoconnect.rules
 create mode 100644 nvmf-autoconnect/nvmefc-boot-connections.service
 create mode 100644 nvmf-autoconnect/nvmf-connect.target
 create mode 100644 nvmf-autoconnect/nvmf-connect at .service

-- 
2.13.7
