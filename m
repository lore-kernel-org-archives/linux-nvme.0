From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Wed,  6 Dec 2017 11:36:24 +0000
Subject: [PATCH] nvmet: Limit num of queues to num of cpus on traget
Message-ID: <20171206113624.989-1-nitzanc@mellanox.com>

Current implementation allocates NVMET_NR_QUEUES cqs/sqs
during admin queue connection, regardless of host's demands
or target's available resources.
Moreover, a low-resourced target is currently unprotected from
host big resources demands (limited only by the magical
NVMET_NR_QUEUES constant). Since there is no real benefit in
allocating more queues than target #CPUs, it is enough to limit 
its max qid value to be min(NVMET_NR_QUEUES, target #CPUs).

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---

Sagi/Christoph,
In case the NVMEoF host asks num_io_queues << num_target_cpus there is
a waste of memory allocated in the target side for the sq's/cq's that
we never use. We might want to check the number of needed queues in
"set_features" cmd and allocate the minimum(wanted, target_capable).
This will block the option of creating more queues in a later stage
of the host lifecycle, but saves resources.

thoughts ?

---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b54748a..3631b64 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -964,7 +964,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 	switch (type) {
 	case NVME_NQN_NVME:
-		subsys->max_qid = NVMET_NR_QUEUES;
+		subsys->max_qid = min(NVMET_NR_QUEUES, num_present_cpus());
 		break;
 	case NVME_NQN_DISC:
 		subsys->max_qid = 0;
-- 
2.9.4
