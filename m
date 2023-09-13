Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB534CA550B
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 08:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SnLvLTWbhrC/XUz3Fy0z7AlLzfSz99Ix9EkTAMJlulM=; b=us44BSxAmPctb4/qLm7F/IkUve
	fjnYw26lbPgofECAPR9Qx+BPweDFEAmbHzdyDoU+FuRYm+2L84H1DOUQO/MfwSg1tJG5oV/ah1fZ3
	J6TfA+m1itPO/x8ZJwo0wfmdPViGXo+fIABhS1K0hkoSNkS1GLSyGqxJ9KJowtNtY4H8j8yy9m2L2
	udJYTKISLggRdfV1+1ibsEO8CqhOI1ktnYbk9i8+FO9GnqNomo/ATNfLqtgOez9L31qMal1wBxPZY
	qubDmv3i+EvhxNC1DbUmlrHPjdM3u9LCZiN0gz0g1/iTgUUEZdX9pMLFhn0O6qBqSHDk/OPeOUABB
	BvsjYjJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgLOK-0058B2-06;
	Wed, 13 Sep 2023 08:38:32 +0000
Received: from m12.mail.163.com ([220.181.12.217])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgLOG-00589H-1y
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 08:38:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SnLvL
	TWbhrC/XUz3Fy0z7AlLzfSz99Ix9EkTAMJlulM=; b=POrdJt7IONpqYhy6nJx4/
	OCwh73DXHhnA1msxdY4hErz0yZQr4z2d6cwPV8Y2kJkHo4/3tZ84KDgR7LjLjAE2
	NhQf8gDY4Jg4XcWk7ESzijr7FKn2TY8ZNrL3SW5uoAj+78H3McjObsCQ+Q9jIbtU
	HJi+GSvxmxehjGjOtvxHjQ=
Received: from localhost.localdomain (unknown [223.166.237.2])
	by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wAnln7QdAFli8i+Bw--.56942S3;
	Wed, 13 Sep 2023 16:37:49 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: ping_gan@dell.com,
	jacky_gam_2001@163.com
Subject: [PATCH 1/4] nvmet: Add nvme target polling queue task parameters
Date: Wed, 13 Sep 2023 16:36:41 +0800
Message-Id: <9c3ebdd7a0411bd45512e0bc8eb60700f5bb8a04.1694592708.git.jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1694592708.git.jacky_gam_2001@163.com>
References: <cover.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnln7QdAFli8i+Bw--.56942S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr13tw1DJr4fAFW3CF18AFb_yoW5ZrW3pF
	W7Kwn0yr4xG3yxKwn3Gay5Jry3tw48Ca47Xa4xGw1rAFnY9ay8XFy8trWY9ryUCrW8Ca45
	JF1xCr4Uuw18J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNJPiUUUUUU=
X-Originating-IP: [223.166.237.2]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/xtbBlwPpKWI0aQannwAAsV
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_013828_979509_ACC1D824 
X-CRM114-Status: GOOD (  15.11  )
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

To define a polling task's running parameters when
nvme target submits bio to a nvme polling queue.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/target/core.c | 55 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3935165048e7..6f49965d5d17 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -17,6 +17,29 @@
 
 #include "nvmet.h"
 
+/* Define the polling queue thread's affinity cpu core.
+ *  */
+static int pqt_affinity_core = -1;
+module_param(pqt_affinity_core, int, 0644);
+MODULE_PARM_DESC(pqt_affinity_core,
+			    "nvme polling queue thread's affinity core, -1 for all online cpus");
+
+/* Define a time (in usecs) that polling queue thread shall sample the
+ *  * io request ring before determining it to be idle.
+ *   */
+static int pqt_idle_usecs;
+module_param(pqt_idle_usecs, int, 0644);
+MODULE_PARM_DESC(pqt_idle_usecs,
+				"polling queue task will poll io request till idle time in usecs");
+
+/* Define the polling queue thread ring's size.
+ *  * The ring will be consumed by polling queue thread.
+ *   */
+static int pqt_ring_size;
+module_param(pqt_ring_size, int, 0644);
+MODULE_PARM_DESC(pqt_ring_size,
+				"nvme target polling queue thread ring size");
+
 struct kmem_cache *nvmet_bvec_cache;
 struct workqueue_struct *buffered_io_wq;
 struct workqueue_struct *zbd_wq;
@@ -1648,13 +1671,34 @@ static int __init nvmet_init(void)
 {
 	int error = -ENOMEM;
 
+	if ((pqt_affinity_core >= -1 &&
+		pqt_affinity_core < nr_cpu_ids) ||
+		pqt_idle_usecs > 0 || pqt_ring_size > 0) {
+		if (pqt_idle_usecs == 0)
+			pqt_idle_usecs = 1000; //default 1ms
+		if (pqt_affinity_core < -1 ||
+			pqt_affinity_core >= nr_cpu_ids) {
+			printk(KERN_ERR "bad parameter for affinity core \n");
+			error =  -EINVAL;
+			return error;
+		}
+		if (pqt_ring_size == 0)
+			pqt_ring_size = 4096; //default 4k
+		error = nvmet_init_pq_thread(pqt_idle_usecs,
+						pqt_affinity_core, pqt_ring_size);
+		if (error)
+			return error;
+	}
+
 	nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] = 1;
 
 	nvmet_bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec), 0,
 			SLAB_HWCACHE_ALIGN, NULL);
-	if (!nvmet_bvec_cache)
-		return -ENOMEM;
+	if (!nvmet_bvec_cache) {
+		error = -ENOMEM;
+		goto out_free_pqt;
+	}
 
 	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
 	if (!zbd_wq)
@@ -1688,6 +1732,8 @@ static int __init nvmet_init(void)
 	destroy_workqueue(zbd_wq);
 out_destroy_bvec_cache:
 	kmem_cache_destroy(nvmet_bvec_cache);
+out_free_pqt:
+	nvmet_exit_pq_thread();
 	return error;
 }
 
@@ -1701,6 +1747,11 @@ static void __exit nvmet_exit(void)
 	destroy_workqueue(zbd_wq);
 	kmem_cache_destroy(nvmet_bvec_cache);
 
+	if ((pqt_affinity_core >= -1 &&
+		pqt_affinity_core < nr_cpu_ids) ||
+		pqt_idle_usecs > 0 || pqt_ring_size > 0)
+		nvmet_exit_pq_thread();
+
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
 }
-- 
2.26.2


