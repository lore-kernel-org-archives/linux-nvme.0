From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 25 Oct 2018 08:19:38 -0700
Subject: [PATCH 0/2] nvmet-rdma: Suppress a lockdep complaint
Message-ID: <20181025151940.388-1-bvanassche@acm.org>

Hi Christoph,

This patch series addresses a lockdep complaint that has been
discussed recently on the NVMe mailing list. Please consider this
patch series for the upstream kernel.

Thanks,

Bart.

Bart Van Assche (2):
  nvmet-rdma: Avoid that nvmet_rdma_release_queue_work() triggers a
    lockdep complaint
  nvmet-rdma: Use the system workqueues again for deletion work

 drivers/nvme/target/rdma.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog
