From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Apr 2018 08:44:12 +0200
Subject: [PATCH] nvme: Fix disk names when not using nvme multipath
In-Reply-To: <20180417220344.14698-1-keith.busch@intel.com>
References: <20180417220344.14698-1-keith.busch@intel.com>
Message-ID: <20180418064412.GB11757@lst.de>

On Tue, Apr 17, 2018@04:03:44PM -0600, Keith Busch wrote:
> When CONFIG_NVME_MULTIPATH is set, but we're not using nvme to multipath,
> namespaces with multiple paths were not creating unique names due to
> reusing the same instance number from the namespace's head.

Hmm.  They should still differ in the controller instance, though.

Shouldn't we need something like this instead (untested):


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 197a6ba9700f..bfd67bc71455 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3001,10 +3001,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
 				ctrl->cntlid, ns->head->instance);
 		flags = GENHD_FL_HIDDEN;
-	} else {
-		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
-				ns->head->instance);
-	}
+	} else
 #else
 	/*
 	 * But without the multipath code enabled, multiple controller per
