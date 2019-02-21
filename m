From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 20 Feb 2019 20:13:33 -0800
Subject: [PATCH 0/2] nvme-fc/rdma: use blk_rq_nr_phys_segments
Message-ID: <20190221041335.22806-1-chaitanya.kulkarni@wdc.com>

Hi,
Here are two patches to fix the issue reported by Ming :-
(https://marc.info/?l=linux-block&m=155071174416909&w=2).

Ming has tested rdma patch. I've added the code changes for the
host/fc also but I've *not* tested the 2nd patch due to
availability of hardware.

James can you please take a look ? 

Regards,
Chaitanya


Chaitanya Kulkarni (2):
  nvme-rdma: use nr_phys_segments when map rq to sgl
  nvme-fc: use nr_phys_segments when map rq to sgl

 drivers/nvme/host/fc.c   | 4 ++--
 drivers/nvme/host/rdma.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.0
