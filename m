From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  9 Jul 2018 12:49:04 +0300
Subject: [PATCH for 4.19 0/3] Few improvements for nvme-rdma host driver
Message-ID: <20180709094907.8683-1-sagi@grimberg.me>

Patch 1 fixes a possible controller deletion hang during I/O, the other
patches are centralizing code such that common paths can be taken in
multiple flows.

Sagi Grimberg (3):
  nvme-rdma: unquiesce queues when deleting the controller
  nvme-rdma: centralize controller setup sequence
  nvme-rdma: centralize admin/io queue teardown sequence

 drivers/nvme/host/rdma.c | 194 ++++++++++++++++++++---------------------------
 1 file changed, 82 insertions(+), 112 deletions(-)

-- 
2.14.1
