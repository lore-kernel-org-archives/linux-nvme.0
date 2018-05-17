From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 17 May 2018 13:52:50 +0200
Subject: [PATCH v3] nvme: fix lockdep warning in nvme_mpath_clear_current_path
Message-ID: <20180517115250.10027-1-jthumshirn@suse.de>

When running blktest's nvme/005 with a lockdep enabled kernel the test
case fails due to the following lockdep splat in dmesg:

 =============================
 WARNING: suspicious RCU usage
 4.17.0-rc5 #881 Not tainted
 -----------------------------
 drivers/nvme/host/nvme.h:457 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 3 locks held by kworker/u32:5/1102:
  #0:         (ptrval) ((wq_completion)"nvme-wq"){+.+.}, at: process_one_work+0x152/0x5c0
  #1:         (ptrval) ((work_completion)(&ctrl->scan_work)){+.+.}, at: process_one_work+0x152/0x5c0
  #2:         (ptrval) (&subsys->lock#2){+.+.}, at: nvme_ns_remove+0x43/0x1c0 [nvme_core]

The only caller of nvme_mpath_clear_current_path() is nvme_ns_remove()
which holds the subsys lock so it's likely a false positive, but when
using rcu_access_pointer(), we're telling rcu and lockdep that we're
only after the pointer falue.

Fixes: 32acab3181c7 ("nvme: implement multipath access to nvme subsystems")
Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Suggested-by: Paul E. McKenney <paulmck at linux.vnet.ibm.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>

---
Changes to v2:
- Added Christoph's R-b
- Removed most of the lockdep splat from commit log

Changes to v1:
- Change rcu_dereference_protected() to rc_access_pointer() (Paul)

---
 drivers/nvme/host/nvme.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 17d2f7cf3fed..af2bb6bc984d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -22,6 +22,7 @@
 #include <linux/lightnvm.h>
 #include <linux/sed-opal.h>
 #include <linux/fault-inject.h>
+#include <linux/rcupdate.h>
 
 extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
@@ -454,7 +455,7 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
 
-	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
+	if (head && ns == rcu_access_pointer(head->current_path))
 		rcu_assign_pointer(head->current_path, NULL);
 }
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
-- 
2.16.3
