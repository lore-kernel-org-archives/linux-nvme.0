Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC4CC3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NaF9q8ZBmSkejGe0vkL2ZGIYpL4DlkzIF5JZq88JGGU=; b=GDHxL/VnoBugw2+FpstQZy2hHH
	6+8kOrAD5CsEByOUjFhS80mnUDjtI6xbt3l63JDIi033L8LGFu1ua2lzw2w6S1UahkB03AsGA9d2E
	iz/RECE9PitSxWQ0ZXlyNQcGL3zZVnquRsmVK5qvRyZnyn6w0JqeOfSbjUEjn42hwOf0K9oygqTcI
	cxUz6o3yVUGbh4kTgPL42LM0rmoksx8UcNMtQrxLasZFoiwPfc3X6ObLzazGuYhCpBC3UPviRzt1r
	KlEFXnuxPUOtOimmlWtBUiTCJWXhhR++Y9n4cNX4zq3TOl7hY2itONROS/vXWnjsDfZ0COkDcCf6a
	uirjKjww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdoA-0000000FN5k-14Eh;
	Wed, 07 May 2025 12:23:30 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdo9-0000000FN4V-0kKw
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 860FA629E6;
	Wed,  7 May 2025 12:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6069C4CEE7;
	Wed,  7 May 2025 12:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620608;
	bh=zJE7i5AqqWtsdNIH2Blhd4mWVmfdm4N3ZoNMw7jKQ7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HhNcqvhfcSI4WhpkJidYNlCaZhxT41q5n9dO10YlxFtNCfKCn1iIu0eDV8YUtk6Vg
	 2lCjiBmGUBdVCbp663J5YO2tZa9QkBBuSEaDBatuI5lO3A/9T4/cGPRWAMhBg8B3qN
	 KiDcEYmx0cgnSPGYPQrGmB6QuMBwKh6+7U1SuW2/P43G7SGbwoJMrztstoBI2L9ZWI
	 B971E6rKGReF62Bm1Uh40+kANCJJAv1kJ9AHe+0snIPgivnmdU/pIQ+CC6jkxX1crT
	 NcZxPCvxalPKLIIE/eRBBasNGCZdwN9mAnuOPLtkkSVzMgKzyD1o3iGNMIAOCtk/PA
	 RfUgm3w8Gw5jw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:23:05 +0200
Subject: [PATCH v6 09/14] nvmet-fcloop: allocate/free fcloop_lsreq directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-9-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

fcloop depends on the host or the target to allocate the fcloop_lsreq
object. This means that the lifetime of the fcloop_lsreq is tied to
either the host or the target. Consequently, the host or the target must
cooperate during shutdown.

Unfortunately, this approach does not work well when the target forces a
shutdown, as there are dependencies that are difficult to resolve in a
clean way.

The simplest solution is to decouple the lifetime of the fcloop_lsreq
object by managing them directly within fcloop. Since this is not a
performance-critical path and only a small number of LS objects are used
during setup and cleanup, it does not significantly impact performance
to allocate them during normal operation.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 63 +++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c74baa7f6e43c8bddd9e6948f806f27b032b1d4d..f999bd6513c19b19af64e0ea547db26b627aab69 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -293,6 +293,9 @@ struct fcloop_ini_fcpreq {
 	spinlock_t			inilock;
 };
 
+/* SLAB cache for fcloop_lsreq structures */
+static struct kmem_cache *lsreq_cache;
+
 static inline struct fcloop_lsreq *
 ls_rsp_to_lsreq(struct nvmefc_ls_rsp *lsrsp)
 {
@@ -343,6 +346,7 @@ fcloop_rport_lsrqst_work(struct work_struct *work)
 		 * callee may free memory containing tls_req.
 		 * do not reference lsreq after this.
 		 */
+		kmem_cache_free(lsreq_cache, tls_req);
 
 		spin_lock(&rport->lock);
 	}
@@ -354,10 +358,13 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 			struct nvme_fc_remote_port *remoteport,
 			struct nvmefc_ls_req *lsreq)
 {
-	struct fcloop_lsreq *tls_req = lsreq->private;
 	struct fcloop_rport *rport = remoteport->private;
+	struct fcloop_lsreq *tls_req;
 	int ret = 0;
 
+	tls_req = kmem_cache_alloc(lsreq_cache, GFP_KERNEL);
+	if (!tls_req)
+		return -ENOMEM;
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
@@ -394,14 +401,17 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 
 	lsrsp->done(lsrsp);
 
-	if (remoteport) {
-		rport = remoteport->private;
-		spin_lock(&rport->lock);
-		list_add_tail(&tls_req->ls_list, &rport->ls_list);
-		spin_unlock(&rport->lock);
-		queue_work(nvmet_wq, &rport->ls_work);
+	if (!remoteport) {
+		kmem_cache_free(lsreq_cache, tls_req);
+		return 0;
 	}
 
+	rport = remoteport->private;
+	spin_lock(&rport->lock);
+	list_add_tail(&tls_req->ls_list, &rport->ls_list);
+	spin_unlock(&rport->lock);
+	queue_work(nvmet_wq, &rport->ls_work);
+
 	return 0;
 }
 
@@ -427,6 +437,7 @@ fcloop_tport_lsrqst_work(struct work_struct *work)
 		 * callee may free memory containing tls_req.
 		 * do not reference lsreq after this.
 		 */
+		kmem_cache_free(lsreq_cache, tls_req);
 
 		spin_lock(&tport->lock);
 	}
@@ -437,8 +448,8 @@ static int
 fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 			struct nvmefc_ls_req *lsreq)
 {
-	struct fcloop_lsreq *tls_req = lsreq->private;
 	struct fcloop_tport *tport = targetport->private;
+	struct fcloop_lsreq *tls_req;
 	int ret = 0;
 
 	/*
@@ -446,6 +457,10 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	 * hosthandle ignored as fcloop currently is
 	 * 1:1 tgtport vs remoteport
 	 */
+
+	tls_req = kmem_cache_alloc(lsreq_cache, GFP_KERNEL);
+	if (!tls_req)
+		return -ENOMEM;
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
@@ -462,6 +477,9 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	ret = nvme_fc_rcv_ls_req(tport->remoteport, &tls_req->ls_rsp,
 				 lsreq->rqstaddr, lsreq->rqstlen);
 
+	if (ret)
+		kmem_cache_free(lsreq_cache, tls_req);
+
 	return ret;
 }
 
@@ -481,14 +499,17 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 				lsreq->rsplen : lsrsp->rsplen));
 	lsrsp->done(lsrsp);
 
-	if (targetport) {
-		tport = targetport->private;
-		spin_lock(&tport->lock);
-		list_add_tail(&tls_req->ls_list, &tport->ls_list);
-		spin_unlock(&tport->lock);
-		queue_work(nvmet_wq, &tport->ls_work);
+	if (!targetport) {
+		kmem_cache_free(lsreq_cache, tls_req);
+		return 0;
 	}
 
+	tport = targetport->private;
+	spin_lock(&tport->lock);
+	list_add_tail(&tls_req->ls_list, &tport->ls_list);
+	spin_unlock(&tport->lock);
+	queue_work(nvmet_wq, &tport->ls_work);
+
 	return 0;
 }
 
@@ -1127,7 +1148,6 @@ static struct nvme_fc_port_template fctemplate = {
 	/* sizes of additional private data for data structures */
 	.local_priv_sz		= sizeof(struct fcloop_lport_priv),
 	.remote_priv_sz		= sizeof(struct fcloop_rport),
-	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
 };
 
@@ -1150,7 +1170,6 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.target_features	= 0,
 	/* sizes of additional private data for data structures */
 	.target_priv_sz		= sizeof(struct fcloop_tport),
-	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 };
 
 static ssize_t
@@ -1670,15 +1689,20 @@ static const struct class fcloop_class = {
 };
 static struct device *fcloop_device;
 
-
 static int __init fcloop_init(void)
 {
 	int ret;
 
+	lsreq_cache = kmem_cache_create("lsreq_cache",
+				sizeof(struct fcloop_lsreq), 0,
+				0, NULL);
+	if (!lsreq_cache)
+		return -ENOMEM;
+
 	ret = class_register(&fcloop_class);
 	if (ret) {
 		pr_err("couldn't register class fcloop\n");
-		return ret;
+		goto out_destroy_cache;
 	}
 
 	fcloop_device = device_create_with_groups(
@@ -1696,6 +1720,8 @@ static int __init fcloop_init(void)
 
 out_destroy_class:
 	class_unregister(&fcloop_class);
+out_destroy_cache:
+	kmem_cache_destroy(lsreq_cache);
 	return ret;
 }
 
@@ -1761,6 +1787,7 @@ static void __exit fcloop_exit(void)
 
 	device_destroy(&fcloop_class, MKDEV(0, 0));
 	class_unregister(&fcloop_class);
+	kmem_cache_destroy(lsreq_cache);
 }
 
 module_init(fcloop_init);

-- 
2.49.0


