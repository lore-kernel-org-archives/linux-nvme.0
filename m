From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Mon, 12 Nov 2018 13:56:32 -0800
Subject: [PATCH v3 0/8] nvmet: Enable AENs support for Discovery controllers
Message-ID: <1542059800-35938-1-git-send-email-jay.e.sternberg@intel.com>

v2 - corrected two patch descriptions and a patch's author
v3 - rework based on comments from Christoph

Technical proposal 8002 defines enhancements to provide NVMe-oF with
the same level of resource enumeration as is available with local
PCIe-based NVMe devices. It defines an NVMe-oF level mechanism for
notifying provisioned hosts about remote resource state changes
(i.e., added, removed, modified), specifically Discovery Log changes.

These changes allow an optional explicit persistent connection to
Discovery controllers, and defines a mechanism to indicate changes
occurring on Subsystems and Namespace controllers via Asynchronous
Event Notifications.

Jay Sternberg (7):
  nvmet: Provide aen bit functions for multiple controller types
  nvmet: Change aen mask functions to use bit numbers
  nvmet: Allow Keep Alive for Discovery controller
  nvmet: Make kato and AEN processing for use by other controllers
  nvmet: Add defines for discovery change async events
  nvmet: Add support to Discovery controllers for commands
  nvmet: Enable Discovery Controller AENs

Sagi Grimberg (1):
  nvmet: allow host connect even if no allowed subsystems are exported

 drivers/nvme/target/admin-cmd.c |  73 +++++++++++++----------
 drivers/nvme/target/configfs.c  |  30 +++++++---
 drivers/nvme/target/core.c      |  83 +++++++-------------------
 drivers/nvme/target/discovery.c | 127 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h     |  41 +++++++++++--
 include/linux/nvme.h            |  15 ++++-
 6 files changed, 257 insertions(+), 112 deletions(-)

-- 
1.8.3.1
