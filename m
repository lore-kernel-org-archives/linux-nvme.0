From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  4 Apr 2017 13:09:02 +0300
Subject: [GIT PULL] nvme patches for kernel 4.12 - early merge to
 for-4.12/block
Message-ID: <1491300542-7500-1-git-send-email-sagi@grimberg.me>

Hey Jens,

We're sending you an early pull request to avoid conflicts of
some more developments we have going on. We have some more
stuff in the pipes that will be sent closer to the merge window.

Here are the highlights:
- Centralize nvme request completion handlers from Christoph
- Some nvmet cleanups from Parav
- Set of nvme-fc updates/cleanups from James
- IPv6 support for nvme over rdma (with an net/core patch acked
  by DaveM)
- Add controller loss timeout functionality for fabrics drivers
  (similar to scsi's dev_loss_tmo)
- CPU hotplug fixes in rdma/loop host drivers
- nvmet-rdma fix possible resource overflow under heavy rate of
  queues establishment/teardown
- Bunch of other cleanups for fabrics drivers

please consider pulling from:

  git://git.infradead.org/nvme.git nvme-4.12

Thanks!

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme-fc: drop ctrl for all command completions
      nvme: factor request completion code into a common helper

James Smart (6):
      nvme_fc: Sync FC-NVME header with standard
      nvme_fc: Add check of status_code in ERSP_IU
      nvmet_fc: Sync NVME LS reject reasons with spec
      nvme_fc: correct LS validation
      nvmet_fc: Clear SG list to avoid double frees
      nvme_fc: Clean up host fcpio done status handling

Max Gurtovoy (1):
      nvmet: use symbolic constants for log identifiers

Parav Pandit (2):
      nvmet: Fixed avoided printing nvmet: twice in error logs.
      nvmet: Introduced helper routine for controller status check.

Sagi Grimberg (23):
      nvme-loop: fix a possible use-after-free when destroying the admin queue
      nvmet: confirm sq percpu has scheduled and switched to atomic
      nvmet-rdma: Fix a possible uninitialized variable dereference
      nvme-rdma: handle cpu unplug when re-establishing the controller
      nvme-loop: handle cpu unplug when re-establishing the controller
      nvmet-rdma: occasionally flush ongoing controller teardown
      nvme-rdma: Give some more grace for rdma connection establishment
      nvme-loop: remove some code duplication
      net/utils: generic inet_pton_with_scope helper
      nvmet-rdma: use generic inet_pton_with_scope
      nvme-rdma: use inet_pton_with_scope helper
      iscsi-target: use generic inet_pton_with_scope
      nvme-rdma: fix module_init (theoretical) error path
      nvme-loop: fix module_init (theoretical) error path
      nvme-fc: fix module_init (theoretical) error path
      nvme-loop: remove unneeded includes
      nvme-loop: retrieve iod from the cqe command_id
      nvme-rdma: get rid of local reconnect_delay
      nvme-fabrics: Allow ctrl loss timeout configuration
      nvme-rdma: Support ctrl_loss_tmo
      nvme-rdma: increment request retries counter before requeuing
      nvme-loop: increment request retries counter before requeuing
      nvme-fc: increment request retries counter before requeuing

 drivers/nvme/host/core.c                     |  35 +++++-
 drivers/nvme/host/fabrics.c                  |  28 +++++
 drivers/nvme/host/fabrics.h                  |  10 ++
 drivers/nvme/host/fc.c                       |  53 ++++----
 drivers/nvme/host/nvme.h                     |   9 +-
 drivers/nvme/host/pci.c                      |  32 +----
 drivers/nvme/host/rdma.c                     | 173 ++++++++++++---------------
 drivers/nvme/target/admin-cmd.c              |  31 ++---
 drivers/nvme/target/core.c                   |  32 ++++-
 drivers/nvme/target/discovery.c              |  19 ++-
 drivers/nvme/target/fabrics-cmd.c            |   4 +-
 drivers/nvme/target/fc.c                     |  21 ++--
 drivers/nvme/target/io-cmd.c                 |  22 ++--
 drivers/nvme/target/loop.c                   | 169 +++++++++++++++-----------
 drivers/nvme/target/nvmet.h                  |  12 +-
 drivers/nvme/target/rdma.c                   |  55 ++++++---
 drivers/target/iscsi/iscsi_target_configfs.c |  46 ++-----
 include/linux/inet.h                         |   6 +
 include/linux/nvme-fc-driver.h               |   6 +-
 include/linux/nvme-fc.h                      |  68 +++++++++--
 net/core/utils.c                             | 103 ++++++++++++++++
 21 files changed, 576 insertions(+), 358 deletions(-)
