From: yuyufen@huawei.com (Yufen Yu)
Date: Wed, 10 Apr 2019 16:00:29 +0800
Subject: [PATCH RFC 0/6] nvme: introduce a new flag NVME_ADMIN_QID
Message-ID: <20190410080035.82529-1-yuyufen@huawei.com>

Hi, all

This patchset introduces a new flag NVME_ADMIN_QID for admin queue.
Now that, all drivers in host or target are use index '0' as admin
queues. Thus, we can use a flag NVME_ADMIN_QID instead of using '0',
which can make code more easy to read and understand.

This patchset is RFC, and it just use NVME_ADMIN_QID for drivers in
nvme host. I am not sure whether this patchset actually make sense. 
Any suggestion is welcome and thanks in advance.

Yufen Yu (6):
  nvme: add new flags NVME_ADMIN_QID for nvme admin queue
  nvme-pci: use NVME_ADMIN_QID for admin queue
  nvme-rdma: use flag NVME_ADMIN_QID for admin queue
  nvme-tcp: use flag NVME_ADMIN_QID for admin queue
  nvme-fc: use flag NVME_ADMIN_QID for admin queue
  nvme-fabrics: use flag NVME_ADMIN_QID

 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/fc.c      | 16 ++++++++--------
 drivers/nvme/host/pci.c     | 18 +++++++++---------
 drivers/nvme/host/rdma.c    | 22 +++++++++++-----------
 drivers/nvme/host/tcp.c     | 24 ++++++++++++------------
 include/linux/nvme.h        |  3 +++
 6 files changed, 44 insertions(+), 41 deletions(-)

-- 
2.16.2.dirty
