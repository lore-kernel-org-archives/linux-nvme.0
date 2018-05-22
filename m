From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 May 2018 11:09:53 +0200
Subject: [PATCHv2 00/11] nvme: ANA support
Message-ID: <20180522091004.39620-1-hare@suse.de>

Hi all,

here's now the second round of adding ANA support to the nvme subsystem.
It's the combined patchset from hch and me, and I've included
all reviews I've had so far.

There are actually two parts to it:
The first patches update AEN configuration support as ANA relies on AENs to be sent.
So we should better make sure that we have them enabled.
The second part is then the ANA support proper.

As usual, comments and reviews are welcome.

Christoph Hellwig (8):
  nvme.h: untangle AEN notice definitions
  nvmet: refactor AER handling
  nvme.h: add ANA definitions
  nvme: add support for the log specific field
  nvme: always failover on path or transport errors
  nvme: add ANA support
  nvmet: add a new nvmet_zero_sgl helper
  nvmet: split log page implementation

Hannes Reinecke (3):
  nvme: submit AEN event configuration on startup
  nvmet: Add AEN configuration support
  nvmet: ANA support

 drivers/nvme/host/core.c        | 390 ++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/lightnvm.c    |   2 +-
 drivers/nvme/host/multipath.c   |  43 ++++-
 drivers/nvme/host/nvme.h        |  20 ++-
 drivers/nvme/target/admin-cmd.c | 247 +++++++++++++++++++------
 drivers/nvme/target/configfs.c  | 381 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 120 +++++++++++--
 drivers/nvme/target/discovery.c |  49 +++--
 drivers/nvme/target/io-cmd.c    |  36 ++++
 drivers/nvme/target/nvmet.h     |  52 ++++++
 include/linux/nvme.h            |  65 ++++++-
 11 files changed, 1275 insertions(+), 130 deletions(-)

-- 
2.12.3
