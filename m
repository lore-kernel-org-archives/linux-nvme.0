From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 10 Oct 2017 14:40:29 +0300
Subject: [PATCH 0/4] Add controllers to nvmet configfs
Message-ID: <1507635633-16665-1-git-send-email-israelr@mellanox.com>

This patch series expands nvmet configfs.
It adds to nvmet two main features
 - Close an active connection from target side.
 - Show all connections from the target point of view.

Those functionalities have some benefits:
 - Give the administrator more control and information
 - Enforce new ACL while there are active connections
 - Disconnect from unreachable Hosts

Israel Rukshin (4):
  nvmet: Add port pointer to nvmet_ctrl structure
  nvmet: Fix error flow in nvmet_alloc_ctrl()
  nvmet: Add controllers to configfs
  nvmet: Add feature close connection from target side

 drivers/nvme/target/configfs.c | 86 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     | 18 +++++++--
 drivers/nvme/target/nvmet.h    | 11 ++++++
 3 files changed, 111 insertions(+), 4 deletions(-)

-- 
1.8.4.3
