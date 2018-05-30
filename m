From: hch@lst.de (Christoph Hellwig)
Date: Wed, 30 May 2018 14:54:52 +0200
Subject: [PATCH] nvme: avoid hang on inaccessible paths
In-Reply-To: <20180530143020.50a299b8@pentland.suse.de>
References: <20180530111637.22223-1-hare@suse.de>
 <20180530121241.GA1850@lst.de> <20180530143020.50a299b8@pentland.suse.de>
Message-ID: <20180530125452.GA2763@lst.de>

On Wed, May 30, 2018@02:30:20PM +0200, Hannes Reinecke wrote:
> > Now it might make sense to have a (configurable) timeout to give
> > up in all those case, and if my vague memory serves me right you
> > actually volunteered to implement that a while ago.
> > 
> The problem is that this particular code path is triggered for the
> revalidate_disk() case; when opting for requeue (as the original code
> did) the system will hang during revalidate_disk(), via

So we add the first path, which in inaccessible.  So yes, the I/O
should block for now (that is until we have a timeout for that)

> As this blocks the nvmf_dev_mutex we don't have any chance to connect
> the other, optimized path.

And I guess this where the real issue starts.  We should not do block
I/O under nvmf_dev_mutex.

James has some work on asynchronous connects pending for FC, so I guess
we could look into generalizing that and always exectute the real connect
work in a different thread.

Or we could move create_ctrl outside the lock, which Johannes had
patch for a few days ago, although that didn't work as-is.  I'll attach
my completely untested attempt at that below.

> I had been thinking of implementing that particular handling from the
> ANA spec, but that would mean we're adding an ANA TT delay for each
> inaccessible path, which with the current defaults would mean booting
> is delayed by 10 seconds per inaccessible path.

No.  We should only retry on an inaccessible or change path if we
don't have an optimized or non-optimized path available.

---
>From bf729292705351639aa1eac1bde2e1afc25f11b7 Mon Sep 17 00:00:00 2001
From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Wed, 30 May 2018 14:46:39 +0200
Subject: nvme: don't hold nvmf_transports_rwsem for more than transport
 lookups

Only take nvmf_transports_rwsem when doing a lookup of registered
transports, so that a blocking ->create_ctrl doesn't prevent other
actions on /dev/nvme-fabrics.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
[hch: increased lock hold time a bit to be safe, added a comment
 and updated the changelog]
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fabrics.c | 3 ++-
 drivers/nvme/host/fabrics.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index aa318136460e..5f9618a2fd3d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -969,6 +969,7 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 		ret = -EBUSY;
 		goto out_unlock;
 	}
+	up_read(&nvmf_transports_rwsem);
 
 	ret = nvmf_check_required_opts(opts, ops->required_opts);
 	if (ret)
@@ -985,11 +986,11 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 	}
 
 	module_put(ops->module);
-	up_read(&nvmf_transports_rwsem);
 	return ctrl;
 
 out_module_put:
 	module_put(ops->module);
+	goto out_free_opts;
 out_unlock:
 	up_read(&nvmf_transports_rwsem);
 out_free_opts:
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index ef46c915b7b5..d778f14bff20 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -124,6 +124,9 @@ struct nvmf_ctrl_options {
  *	1. At minimum, 'required_opts' and 'allowed_opts' should
  *	   be set to the same enum parsing options defined earlier.
  *	2. create_ctrl() must be defined (even if it does nothing)
+ *	3. struct nvmf_transport_ops must be statically allocated in the
+ *	   modules .bss section so that a pure module_get on @module
+ *	   prevents the memory from beeing freed.
  */
 struct nvmf_transport_ops {
 	struct list_head	entry;
-- 
2.17.0
