From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 23 Jan 2019 13:42:52 -0800
Subject: [GIT PULL] nvme fixes for 5.0-rc4
Message-ID: <20190123214252.27491-1-sagi@grimberg.me>

Hey Jens,

Couple of nvme fixes for the next rc round.

- Fix nvme-rdma and nvme-tcp timeout handlers racing with queue
  disconnections and initial connect failuers
- fix nvme-rdma regression in queue maps assignment introduced
  in read/write queue map separation
- fix nvmet-rdma null dereference when we run out of rsps under
  heavy load
- fix multipath ana log underallocation when static group ids are used

The following changes since commit eda14f8977df052dce3a9c54a6bf8d8f76c96eb1:

  nvme-pci: fix nvme_setup_irqs() (2019-01-15 06:50:52 +0100)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.0


for you to fetch changes up to 4dd1dbde7b167cf39e43923ce6c8360498149cf6:

  nvme-multipath: drop optimization for static ANA group IDs (2019-01-21 09:48:57 -0800)

----------------------------------------------------------------
Hannes Reinecke (1):
      nvme-multipath: drop optimization for static ANA group IDs

Raju Rangoju (1):
      nvmet-rdma: fix null dereference under heavy load

Sagi Grimberg (3):
      nvme-rdma: fix timeout handler
      nvme-tcp: fix timeout handler
      nvme-rdma: rework queue maps handling

 drivers/nvme/host/multipath.c |  3 +-
 drivers/nvme/host/rdma.c      | 64 +++++++++++++++++++++++++++++--------------
 drivers/nvme/host/tcp.c       | 19 +++++++------
 drivers/nvme/target/rdma.c    | 15 +++++++++-
 4 files changed, 69 insertions(+), 32 deletions(-)
