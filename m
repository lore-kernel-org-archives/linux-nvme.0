From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Tue, 16 Oct 2018 10:11:12 -0700
Subject: [PATCH v2 00/11] nvmet: Enable AENs support for Discovery controllers
Message-ID: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>

v2 - corrected two patch descriptions and a patch's author

Technical proposal 8002 defines enhancements to provide NVMe-oF with
the same level of resource enumeration as is available with local
PCIe-based NVMe devices. It defines an NVMe-oF level mechanism for
notifying provisioned hosts about remote resource state changes
(i.e., added, removed, modified), specifically Discovery Log changes. 

These changes allow an optional explicit persistent connection to
Discovery controllers, and defines a mechanism to indicate changes
occurring on Subsystems and Namespace controllers via Asynchronous
Event Notifications.

Jay Sternberg (10):
  nvmet: Provide aen bit functions for multiple controller types
  nvmet: Change aen mask functions to use bit numbers
  nvmet: Allow Keep Alive for Discovery controller
  nvmet: Make kato and AEN processing for use by other controllers
  nvmet: Add defines for discovery change async events
  nvmet: Add support to Discovery controllers for commands
  nvmet: Add parent to nvmet_referral_disable
  nvmet: Maintain a global list of ports
  nvmet: Allow all hosts access to the Discovery subsystem
  nvmet: Enable Discovery Controller AENs

Phil Cayton (1):
  nvmet: Provide adding AENs for multiple controller types

 drivers/nvme/target/admin-cmd.c |  63 +++++++++++----------
 drivers/nvme/target/configfs.c  |  26 ++++++++-
 drivers/nvme/target/core.c      |  69 ++++++-----------------
 drivers/nvme/target/discovery.c | 121 +++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h     |  49 ++++++++++++++--
 include/linux/nvme.h            |  15 ++++-
 6 files changed, 247 insertions(+), 96 deletions(-)

-- 
1.8.3.1
