From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 13 Nov 2017 12:29:39 +0000
Subject: [PATCH v2 0/4] Add controllers to nvmet configfs
Message-ID: <1510576183-17215-1-git-send-email-israelr@mellanox.com>

This patch series expands nvmet configfs.
It adds to nvmet two main features
 - Close an active connection from target side.
 - Show all connections from the target point of view.

Those functionalities have some benefits:
 - Give the administrator more control and information
 - Enforce new ACL while there are active connections
 - Disconnect from unreachable Hosts

Changes from v1:
 - Split commit "Fix error flow in nvmet_alloc_ctrl()" to two
 - Embed some port info (traddr and trsvcid) in nvmet_ctrl struct

Israel Rukshin (4):
  nvmet: Fix error flow in nvmet_alloc_ctrl()
  nvmet: Rearrange nvmet_ctrl_free()
  nvmet: Add controllers to configfs
  nvmet: Add feature close connection from target side

 drivers/nvme/target/configfs.c | 86 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     | 19 ++++++++--
 drivers/nvme/target/nvmet.h    | 12 ++++++
 3 files changed, 113 insertions(+), 4 deletions(-)

-- 
1.8.3.1
