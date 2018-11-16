From: hare@suse.de (Hannes Reinecke)
Date: Fri, 16 Nov 2018 08:34:58 +0100
Subject: [PATCH nvme-cli 0/3] Print out controller and ANA state for
 list-subsys
Message-ID: <20181116073501.7867-1-hare@suse.de>

Hi all,

this patchset implements the ability to check the path / controller state
on each namespace. It does so by enhancing the 'list-subsys' command to
optionally accept a device name for the namespace to check; with that we
are able to print out the controller and the ANA state per controller leading
up to that namespace.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme: introduce get_nvme_ctrl_attr()
  nvme: print out controller state for 'list-subsys'
  nvme-list-subsys: Add device name argument and print out ANA state

 Documentation/nvme-list-subsys.txt |   4 +-
 fabrics.c                          |   2 +-
 nvme-print.c                       |  13 ++-
 nvme.c                             | 226 ++++++++++++++++++++++++++-----------
 nvme.h                             |   4 +-
 5 files changed, 175 insertions(+), 74 deletions(-)

-- 
2.13.7
