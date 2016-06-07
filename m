From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Tue,  7 Jun 2016 06:36:48 +0000
Subject: [RFC 0/8] nvmet: Add support for multi-tenant configfs
Message-ID: <1465281416-28355-1-git-send-email-nab@linux-iscsi.org>

From: Nicholas Bellinger <nab@linux-iscsi.org>

Hi folks,

Here's the first pass of a nvmet multi-tenant configfs layout,
following what we've learned in target_core_fabric_configfs.c
wrt to independent operation of storage endpoints.

Here is how the running RFC-v1 code currently looks:

/sys/kernel/config/nvmet/subsystems/
??? nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep
    ??? namespaces
    ??? ??? 1
    ???     ??? ramdisk0 -> ../../../../../target/core/rd_mcp_1/ramdisk0
    ??? ports
        ??? loop
            ??? addr_adrfam
            ??? addr_portid
            ??? addr_traddr
            ??? addr_treq
            ??? addr_trsvcid
            ??? addr_trtype
            ??? enable

Namely, it allows existing /sys/kernel/config/target/core/ backends
to be configfs symlinked into ../nvmet/subsystems/$SUBSYS_NQN/
as nvme namespaces.

The series exposes T10-PI from /sys/kernel/config/target/core/ as
ID_NS.ms + ID_NS.dps feature bits, and enables block integrity
support with nvme/loop driver.

Note this series depends upon the following prerequisites of
target-core:

  http://marc.info/?l=linux-scsi&m=146527281416606&w=2

and of course, today's earlier release of nvmet + friends:

  http://lists.infradead.org/pipermail/linux-nvme/2016-June/004754.html

Note the full set of patches is available from:

  https://git.kernel.org/cgit/linux/kernel/git/nab/target-pending.git/log/?h=nvmet-configfs-ng

Comments..?

--nab

Nicholas Bellinger (8):
  nvmet: Add nvmet_fabric_ops get/put transport helpers
  nvmet: Add support for configfs-ng multi-tenant logic
  nvmet: Hookup nvmet_ns->dev to nvmet_ns_enable
  nvmet/io-cmd: Hookup sbc_ops->execute_rw backend ops
  nvmet/io-cmd: Hookup sbc_ops->execute_sync_cache backend ops
  nvmet/io-cmd: Hookup sbc_ops->execute_unmap backend ops
  nvmet/admin-cmd: Hookup T10-PI to ID_NS.ms + ID_NS.dps feature bits
  nvme/loop: Add support for bio integrity handling

 drivers/nvme/target/Makefile      |   2 +-
 drivers/nvme/target/admin-cmd.c   |  17 ++
 drivers/nvme/target/configfs-ng.c | 585 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/configfs.c    |   5 +-
 drivers/nvme/target/core.c        |  83 +++---
 drivers/nvme/target/io-cmd.c      | 169 ++++++-----
 drivers/nvme/target/loop.c        |  19 ++
 drivers/nvme/target/nvmet.h       |  27 +-
 8 files changed, 799 insertions(+), 108 deletions(-)
 create mode 100644 drivers/nvme/target/configfs-ng.c

-- 
1.9.1
