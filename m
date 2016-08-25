From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 26 Aug 2016 00:41:13 +0300
Subject: [PATCH 0/2] Two small patches for nvme-rdma
Message-ID: <1472161275-6642-1-git-send-email-sagi@grimberg.me>

Both remove redundant code.

Sagi Grimberg (2):
  nvme-rdma: Get rid of duplicate variable
  nvme-rdma: Get rid of redundant defines

 drivers/nvme/host/rdma.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

-- 
1.9.1
