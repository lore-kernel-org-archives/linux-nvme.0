From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed,  2 May 2018 21:00:43 -0400
Subject: [PATCH V2 0/6] nvmet: implement target passthru commands support
Message-ID: <20180503010049.3010-1-chaitanya.kulkarni@wdc.com>

This patchset aims to enable passing through entire physical NVMe drive
through an NVMe over fabrics interface. This implies that all 
namespaces on the target drive are passed through to the initiator
one-to-one and all admin commands from the initiator are forwarded back
to the target drive. This allows for exposing Vender Unique Commands
(VUCs) over the NVMe-OF interface.

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

Chaitanya Kulkarni (6):
  nvme-core: add new interfaces
  nvme-core: export existing ctrl and ns interfaces
  nvmet: export nvmet_add_async_event api
  nvmet: add global subsystem list
  nvmet: add and integrate passthru code with core
  nvmet: add configfs interface for target passthru

 drivers/nvme/host/core.c           |  80 +++++++-
 drivers/nvme/host/nvme.h           |  10 +
 drivers/nvme/target/Makefile       |   2 +-
 drivers/nvme/target/configfs.c     | 145 +++++++++++++-
 drivers/nvme/target/core.c         | 203 ++++++++++++++++++-
 drivers/nvme/target/nvmet.h        |  18 ++
 drivers/nvme/target/passthru-cmd.c | 398 +++++++++++++++++++++++++++++++++++++
 7 files changed, 838 insertions(+), 18 deletions(-)
 create mode 100644 drivers/nvme/target/passthru-cmd.c

-- 
2.9.5
