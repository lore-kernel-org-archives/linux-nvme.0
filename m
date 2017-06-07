From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  7 Jun 2017 19:02:36 +0300
Subject: [PATCH v5 for-4.13 0/6] Automatic affinity settings for nvme over rdma
Message-ID: <1496851362-1344-1-git-send-email-sagi@grimberg.me>

Doug, please consider this patch set for 4.13.

This patch set is aiming to automatically find the optimal
queue <-> irq multi-queue assignments in storage ULPs (demonstrated
on nvme-rdma) based on the underlying rdma device irq affinity
settings.

Changes from v4:
- rebased to upstream 4.12-rc4

Changes from v3:
- Renamed mlx5_disable_msix -> mlx5_free_pci_vectors for symmetry reasons

Changes from v2:
- rebased to 4.12
- added review tags

Changes from v1:
- Removed mlx5e_get_cpu as Christoph suggested
- Fixed up nvme-rdma queue comp_vector selection to get a better match
- Added a comment on why we limit on @dev->num_comp_vectors
- rebased to Jens's for-4.12/block
- Collected review tags

Sagi Grimberg (6):
  mlx5: convert to generic pci_alloc_irq_vectors
  mlx5: move affinity hints assignments to generic code
  RDMA/core: expose affinity mappings per completion vector
  mlx5: support ->get_vector_affinity
  block: Add rdma affinity based queue mapping helper
  nvme-rdma: use intelligent affinity based queue mappings

 block/Kconfig                                      |   5 +
 block/Makefile                                     |   1 +
 block/blk-mq-rdma.c                                |  54 +++++++++++
 drivers/infiniband/hw/mlx5/main.c                  |  10 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  14 +--
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     | 106 ++++-----------------
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   1 -
 drivers/nvme/host/rdma.c                           |  29 ++++--
 include/linux/blk-mq-rdma.h                        |  10 ++
 include/linux/mlx5/driver.h                        |   2 -
 include/rdma/ib_verbs.h                            |  25 ++++-
 14 files changed, 152 insertions(+), 118 deletions(-)
 create mode 100644 block/blk-mq-rdma.c
 create mode 100644 include/linux/blk-mq-rdma.h

-- 
2.7.4
