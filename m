From: parav@mellanox.com (Parav Pandit)
Date: Mon, 27 Feb 2017 23:20:24 -0600
Subject: [PATCHv1 0/2] nvmet: cleanup around error logs 
Message-ID: <1488259224-62321-1-git-send-email-parav@mellanox.com>

This patchset performs cleanup around error logs.
It also introduces helper function for checking controller status.
It converts parsing routine return status from int
to u16 to align to spec.
It prints qid on certain error logs as well.

Changes from v0 to address Sagi's two comments:
1. Split one patch to two related patches.
2. Changed return status from int to u16.

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Parav Pandit <parav at mellanox.com>

Parav Pandit (2):
  nvmet: Fixed avoided printing nvmet: twice in error logs.
  nvmet: Introduced helper routine for controller status check.

 drivers/nvme/target/admin-cmd.c   | 19 +++++++------------
 drivers/nvme/target/core.c        | 21 +++++++++++++++++++--
 drivers/nvme/target/discovery.c   | 19 +++++++++----------
 drivers/nvme/target/fabrics-cmd.c |  4 ++--
 drivers/nvme/target/io-cmd.c      | 22 ++++++++--------------
 drivers/nvme/target/nvmet.h       | 11 ++++++-----
 6 files changed, 51 insertions(+), 45 deletions(-)

-- 
1.8.3.1
