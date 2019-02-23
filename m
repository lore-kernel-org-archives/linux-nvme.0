From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 22 Feb 2019 18:32:51 -0800
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
Message-ID: <20190223023257.21227-1-sagi@grimberg.me>

This series corresponds to the nvme-core discovery uevent notification
for discovery log changes.

The motivation is that whenever we get a discovery log change event from
a discovery controller, we want to query the discovery log page again
and connect to the new controllers in the fabric.

To support this we have a couple of steps:
1. establish a "persistent" discovery controller
2. allow discovery over an existing "persisent" discovery controller device
   node
3. allow users to pass "none" to nvme-cli for arguments that they don't
   care about (this will be useful when we have udev rule that catches events
   and simply feed them to nvme-cli without checking any parameters or building
   a commandline arg string).
4. add udev+systemd scripting to make this all automatic.

Review and feedback is welcome.

Hannes Reinecke (1):
  fc: add autoconnect systemd service and udev rule for fc discovery log
    changes

Sagi Grimberg (5):
  fabrics: ignore arguments that pass in "none"
  fabrics: support persistent connections to a discovery controller
  fabrics: allow user to retrieve discovery log from existing discovery
    controller
  fabrics: add --quiet option
  fabrics: systemd and udev support for automatic discovery log changes

 Makefile                                | 10 +++-
 fabrics.c                               | 62 ++++++++++++++++++-------
 fabrics.h                               |  2 +
 nvme.spec.in                            |  7 +++
 systemd/nvmefc-boot-connections.service |  9 ++++
 systemd/nvmf-connect at .service           | 15 ++++++
 udev/70-nvmf-autoconnect.rules          | 11 +++++
 7 files changed, 98 insertions(+), 18 deletions(-)
 create mode 100644 systemd/nvmefc-boot-connections.service
 create mode 100644 systemd/nvmf-connect at .service
 create mode 100644 udev/70-nvmf-autoconnect.rules

-- 
2.17.1
