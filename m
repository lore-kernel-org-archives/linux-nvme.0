From: hare@suse.de (Hannes Reinecke)
Date: Thu,  7 Jun 2018 09:35:52 +0200
Subject: [PATCH 0/4] nvme: ANATT handling
Message-ID: <20180607073556.39050-1-hare@suse.de>

Hi all,

this patchset implements ANA transition timeout handling for NVMe-oF.
On the target side it implements a delayed workqueue for updating the
ANA state, and on the host side a simple timer is started when either
a namespace is found to be in ANA state change state or if an I/O
command is returned with a status indicating a non-matching ANA state.
If the timer expires the controller is reset.

Patches are relative to hchs block.git nvme-ana branch.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  nvmet: make ANATT configurable
  nvmet: ANA transition timeout handling
  nvme: ANA transition timeout handling
  nvme: start ANATT timer on out-of-order state changes

 drivers/nvme/host/core.c        |  3 ++
 drivers/nvme/host/multipath.c   | 62 +++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h        |  6 ++++
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/configfs.c  | 39 ++++++++++++++++++++-
 drivers/nvme/target/core.c      | 78 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     | 14 ++++++++
 7 files changed, 193 insertions(+), 11 deletions(-)

-- 
2.12.3
