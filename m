From: jsmart2021@gmail.com (James Smart)
Date: Tue, 16 Jul 2019 14:12:31 -0700
Subject: [PATCH 00/10] nvme-cli: nvmf auto-connect scripts
Message-ID: <20190716211241.7650-1-jsmart2021@gmail.com>

This is a formal posting of the patches, not an RFC.

This posting is a combination of the RFC postings of nvme-fc
auto-connect scripts by Hannes, Sagi, and I. The auto-connect
scripts are utilized on nvme-fc and for persistent discovery
controllers that send AENs.  It does not contain the code that
handles the persistent discovery controller AEN and generates the
event.

The auto-connect scripts are now commonized with the exception
of the nvme-fc boot connections service.  It's expected that both
the persistent discovery controllers and nvme-fc can post the same
udev event. Whenever the discovery aen generates an event, the
new --device=<name> argument will be used to identify the persistent
discovery controller. When --device is used, the other connect
attributes will be specified, set to the values of the discovery
controller, and will be used by the cli to validate the device is
who it should be or a new discovery controller will be created.
When nvme-fc generates it's events, it will specify --device=none
and specify the discovery controller addressing arguments.  If a
persistent discovery controller exists on nvme-fc, will do nothing
special and AEN's from it will follow the --device=<name> syntax.

The udev event handler supports both the new event to be used
by discovery controllers as well as the existing nvme-fc transport
event. The nvme-fc transport will be migrated to issue the new
event syntax. The udev script will continue to support the older
style nvme-fc event info in case the cli is running against an
older kernel.

Since last rfc:
 Add reviewed-by's
 Parsing for ctlr_list_item left as is.
 Moved SYS_NVME from fabrics.c to nvme.h
 Changed udev device variable to NVME_CTRL_NAME
 Removed full pathname for nvme and echo in systemd service that
    invokes connect-all
 Moved --quiet option. Rather than include in "arguments" in
    systemd service name, add directly to systemd service that
    invokes connect-all
 Makefile:
   Created install-systemd and install-dracut Make targets
   Changed PREFIX to /usr to match nvme.spec.in's %install target
   Changed LIBDIR to use PREFIX as base path


James Smart (8):
  nvme-cli: ignore arguments that pass in "none"
  nvme-cli: allow discover to address discovery controller by persistent
    name
  nvme-cli: Refactor to create a get_nvme_ctrl_info routine
  nvme-cli: extend ctrl_list_item for connect attributes
  nvme-cli: Add routine to compare ctrl_list_item to connect args
  nvme-cli: Add routine to search for controller with specific
    attributes
  nvme-cli: Expand --device argument processing
  nvme-cli: nvmf auto-connect scripts

Sagi Grimberg (2):
  nvme-cli: support persistent connections to a discovery controller
  nvme-cli: add --quiet option

 Makefile                                         |  22 ++-
 fabrics.c                                        | 118 +++++++++---
 fabrics.h                                        |   2 +
 nvme.c                                           | 226 +++++++++++++++++++----
 nvme.h                                           |  24 +++
 nvme.spec.in                                     |   9 +
 nvmf-autoconnect/70-nvmf-autoconnect.conf        |   1 +
 nvmf-autoconnect/70-nvmf-autoconnect.rules       |  18 ++
 nvmf-autoconnect/nvmefc-boot-connections.service |   9 +
 nvmf-autoconnect/nvmf-connect.target             |   2 +
 nvmf-autoconnect/nvmf-connect at .service           |  14 ++
 11 files changed, 386 insertions(+), 59 deletions(-)
 create mode 100644 nvmf-autoconnect/70-nvmf-autoconnect.conf
 create mode 100644 nvmf-autoconnect/70-nvmf-autoconnect.rules
 create mode 100644 nvmf-autoconnect/nvmefc-boot-connections.service
 create mode 100644 nvmf-autoconnect/nvmf-connect.target
 create mode 100644 nvmf-autoconnect/nvmf-connect at .service

-- 
2.13.7
