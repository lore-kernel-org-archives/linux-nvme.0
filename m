Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71387C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GCjExXiMToo/aixqg1ZjyDz+VC6KWyYZp5t03PW3Fv8=; b=JnzToMT8NknCjOUKdQuiHrk8f6
	HeIMqDisvzNn2nlTTUgwn+C9xc7QnPSHXM3JIkpqnbTgdWyr3Uhm67B+D0UEAoKAc6lVPpU+3dwMU
	B6oM/L38fCug9ylXQ+alTRGiNGNdP8MAQ6gPb+1H+paiFdxnLZ4XU+QaJwv1/pg0jkRboetSkYOYa
	TaNToE/2KF4vQYM7s89SmJVCaB/SLjQ/Zup/wY12fdjGEDpLyMwInWFnc3Gn7S9jrMZNbc4LYIi4x
	4CP2KHluhix9LGTMH5Ew8d+C9hz644fy0MCwwF+V5r/HUoHbEtaGu9DuKHogJx1roNJ8lU/4s5w/V
	5X46lNfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os2fs-00F6y3-R7; Mon, 07 Nov 2022 14:00:28 +0000
Received: from [2001:4bb8:191:2450:bd6a:c86c:b287:8b99] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os2fl-00F6xS-PD; Mon, 07 Nov 2022 14:00:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: only allocate a single slab for bvecs
Date: Mon,  7 Nov 2022 15:00:19 +0100
Message-Id: <20221107140019.1503818-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There is no need to have a separate slab cache for each namespaces,
and having separate ones creates duplicate debugs file names as well.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/core.c        | 22 ++++++++++++++--------
 drivers/nvme/target/io-cmd-file.c | 16 +++-------------
 drivers/nvme/target/nvmet.h       |  3 ++-
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index aecb5853f8da4..683b75a992b3d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -15,6 +15,7 @@
 
 #include "nvmet.h"
 
+struct kmem_cache *nvmet_bvec_cache;
 struct workqueue_struct *buffered_io_wq;
 struct workqueue_struct *zbd_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
@@ -1631,26 +1632,28 @@ void nvmet_subsys_put(struct nvmet_subsys *subsys)
 
 static int __init nvmet_init(void)
 {
-	int error;
+	int error = -ENOMEM;
 
 	nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] = 1;
 
+	nvmet_bvec_cache = kmem_cache_create("nvmet-bvec",
+			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec), 0,
+			SLAB_HWCACHE_ALIGN, NULL);
+	if (!nvmet_bvec_cache)
+		return -ENOMEM;
+
 	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
 	if (!zbd_wq)
-		return -ENOMEM;
+		goto out_destroy_bvec_cache;
 
 	buffered_io_wq = alloc_workqueue("nvmet-buffered-io-wq",
 			WQ_MEM_RECLAIM, 0);
-	if (!buffered_io_wq) {
-		error = -ENOMEM;
+	if (!buffered_io_wq)
 		goto out_free_zbd_work_queue;
-	}
 
 	nvmet_wq = alloc_workqueue("nvmet-wq", WQ_MEM_RECLAIM, 0);
-	if (!nvmet_wq) {
-		error = -ENOMEM;
+	if (!nvmet_wq)
 		goto out_free_buffered_work_queue;
-	}
 
 	error = nvmet_init_discovery();
 	if (error)
@@ -1669,6 +1672,8 @@ static int __init nvmet_init(void)
 	destroy_workqueue(buffered_io_wq);
 out_free_zbd_work_queue:
 	destroy_workqueue(zbd_wq);
+out_destroy_bvec_cache:
+	kmem_cache_destroy(nvmet_bvec_cache);
 	return error;
 }
 
@@ -1680,6 +1685,7 @@ static void __exit nvmet_exit(void)
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
 	destroy_workqueue(zbd_wq);
+	kmem_cache_destroy(nvmet_bvec_cache);
 
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 64b47e2a46330..e55ec6fefd7f4 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -11,7 +11,6 @@
 #include <linux/fs.h>
 #include "nvmet.h"
 
-#define NVMET_MAX_MPOOL_BVEC		16
 #define NVMET_MIN_MPOOL_OBJ		16
 
 void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
@@ -26,8 +25,6 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 			flush_workqueue(buffered_io_wq);
 		mempool_destroy(ns->bvec_pool);
 		ns->bvec_pool = NULL;
-		kmem_cache_destroy(ns->bvec_cache);
-		ns->bvec_cache = NULL;
 		fput(ns->file);
 		ns->file = NULL;
 	}
@@ -59,16 +56,8 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	ns->blksize_shift = min_t(u8,
 			file_inode(ns->file)->i_blkbits, 12);
 
-	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
-			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
-			0, SLAB_HWCACHE_ALIGN, NULL);
-	if (!ns->bvec_cache) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
 	ns->bvec_pool = mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_slab,
-			mempool_free_slab, ns->bvec_cache);
+			mempool_free_slab, nvmet_bvec_cache);
 
 	if (!ns->bvec_pool) {
 		ret = -ENOMEM;
@@ -77,9 +66,10 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 
 	return ret;
 err:
+	fput(ns->file);
+	ns->file = NULL;
 	ns->size = 0;
 	ns->blksize_shift = 0;
-	nvmet_file_ns_disable(ns);
 	return ret;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dfe3894205aa7..bda1c1f71f394 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -77,7 +77,6 @@ struct nvmet_ns {
 
 	struct completion	disable_done;
 	mempool_t		*bvec_pool;
-	struct kmem_cache	*bvec_cache;
 
 	int			use_p2pmem;
 	struct pci_dev		*p2p_dev;
@@ -393,6 +392,8 @@ struct nvmet_req {
 	u64			error_slba;
 };
 
+#define NVMET_MAX_MPOOL_BVEC		16
+extern struct kmem_cache *nvmet_bvec_cache;
 extern struct workqueue_struct *buffered_io_wq;
 extern struct workqueue_struct *zbd_wq;
 extern struct workqueue_struct *nvmet_wq;
-- 
2.30.2


