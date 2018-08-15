From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 15:58:45 -0400
Subject: [PATCH V4 0/9] nvmet: add target passthru commands support
Message-ID: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>

This patchset aims to enable passing through entire physical NVMe drive
through an NVMe over fabrics interface. This implies that all 
namespaces on the target drive are passed through to the initiator
one-to-one and all admin commands from the initiator are forwarded back
to the target drive. This allows for exposing Vender Unique Commands
(VUCs) over the NVMe-OF interface.

Changes since V3:-
1. Add request polling interface to the block layer.
2. Use request polling interface in the NVMEoF target passthru code path.
3. Add checks suggested by Sagi for creating one target ctrl per
   passthru ctrl.
4. Don't enable the namespace if it belongs to the configured passthru
   ctrl.
5. Adjust the code latest kernel.

Changes since V2:-
1. Split the addition of passthru command handlers and integration into
   two different patches since we add guards to create one target controller 
   per passthru controller. This way it will be easier to review the code.
2. Adjust the code for 4.18.

Changes since V1:-
1. Update the new nvme core controller find API naming and
   changed the string comparison of the ctrl.
2. Get rid of the newly added #defines for target ctrl values.
3. Use the newly added structure members in the same patch where
   they are used. Aggregate the passthru command handling support
   and integration with nvmet-core into one patch. 
4. Introduce global NVMe Target subsystem list for connected and
   not connected subsystems on the target side.
5. Add check when configuring the target ns and target
   passthru ctrl to allow only one target controller to be created
   for one passthru subsystem.
6. Use the passthru ctrl cntlid when creating the target controller.

Chaitanya Kulkarni (9):
  nvme-core: add new interfaces to access nvme-ctrl
  nvme-core: export existing ctrl and ns interfaces
  nvmet: export nvmet_add_async_event api
  nvmet: add global subsystem list
  nvmet: add passthru cmd handlers
  nvmet: integrate passthru code with core
  nvmet: add configfs interface for target passthru
  block: add helper to get the request based cookie
  nvmet: add request polling support

 block/blk-mq.c                 |  20 +++
 drivers/nvme/host/core.c       |  81 ++++++++-
 drivers/nvme/host/nvme.h       |  11 ++
 drivers/nvme/target/Makefile   |   2 +-
 drivers/nvme/target/configfs.c | 145 ++++++++++++++-
 drivers/nvme/target/core.c     | 197 ++++++++++++++++++--
 drivers/nvme/target/nvmet.h    |  17 ++
 drivers/nvme/target/pt-cmd.c   | 398 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h         |   1 +
 9 files changed, 852 insertions(+), 20 deletions(-)
 create mode 100644 drivers/nvme/target/pt-cmd.c

-- 
2.14.1
