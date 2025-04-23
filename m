Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534FFC369D7
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wLU3727wlw2bmFpVPooVCmxYaH7XcPO+YYdgFlBRlBM=; b=JLHHgYthLZjJ7h59xTzTj3rSZO
	rcKD/L07WaB79+hvlFyib0WxFcJilJUJHsJy6J/LyfR0zfnMSTkEXYAcnMJduH6Sc1e8PRc4BrvAe
	8GAOIWCzJZpipNW9/QSK4n7PgyqqiZ0Pn9XoofFnACDIXy1uBNgtR93uRD0iMcTwu5kExcQMl/0BG
	GEyg7JKSeqpgBPKXKWtEpUsjFNRV7jEL1LkpnDC0IDQ2rOQtPcmDmaiFL8GLX/hDOLx002tk/Z+sO
	g8sWjRI19SWPoJykonD5NbZu+7RMwoa/CE+CrbspuzDP0cf97l7ZPdKzkau+5ec7p7UMV8T2rJAwc
	IG6ROpTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aXQ-0000000Ahpu-2w2g;
	Wed, 23 Apr 2025 13:53:20 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7a3O-0000000AamY-2I3L
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:22:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AD758A4CF12;
	Wed, 23 Apr 2025 13:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31D1C4CEE2;
	Wed, 23 Apr 2025 13:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414537;
	bh=mXSrbFVuNJV6VkeoxAR0XoweTJRrbm3vnqZ/Tfb8XTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gqgaASzFrGaQ7hgzyOZ253A9OOodhuZ984ZBcefakydnwEx3Rx+fwcFQjekk1KczO
	 DAAeyEvvX4mXTMcFLmImJtT/THXXotUC2D1XMxSNLejSYBMsqT+QgMScFKyvmI8Ih5
	 lyXbx1qPAV5AJsVMbfjq7ikwdCbgwFeidJlSUeoay8vNMkUh8PjEYWnaGEzNQuExUw
	 jtpHa5CAJHv9WmYqS3MNcV91AsiUOWoG0VAj++rcx2poXlCTcP2JtjfFgGvgLmQ/ih
	 kKd9k22NU1g4FuLwMjf28kYHf4gxjMJaoRNqu3AXRzLNGHHQ+F1viEx8s8rsO2ZstF
	 LQOIy/Jsz4org==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 23 Apr 2025 15:21:52 +0200
Subject: [PATCH v5 09/14] nvmet-fcloop: allocate/free fcloop_lsreq directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-nvmet-fcloop-v5-9-3d7f968728a5@kernel.org>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
In-Reply-To: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_062218_744410_87486021 
X-CRM114-Status: GOOD (  20.32  )
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

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 63 +++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 014cc66f92cb1db0a81a79d2109eae3fff5fd38a..47ce51183a66b4b37fc850cced2ddf70be2cdb42 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -293,6 +293,9 @@ struct fcloop_ini_fcpreq {
 	spinlock_t			inilock;
 };
 
+/* SLAB cache for fcloop_lsreq structures */
+struct kmem_cache *lsreq_cache;
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
 
@@ -1131,7 +1152,6 @@ static struct nvme_fc_port_template fctemplate = {
 	/* sizes of additional private data for data structures */
 	.local_priv_sz		= sizeof(struct fcloop_lport_priv),
 	.remote_priv_sz		= sizeof(struct fcloop_rport),
-	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
 };
 
@@ -1154,7 +1174,6 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.target_features	= 0,
 	/* sizes of additional private data for data structures */
 	.target_priv_sz		= sizeof(struct fcloop_tport),
-	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 };
 
 static ssize_t
@@ -1674,15 +1693,20 @@ static const struct class fcloop_class = {
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
@@ -1700,6 +1724,8 @@ static int __init fcloop_init(void)
 
 out_destroy_class:
 	class_unregister(&fcloop_class);
+out_destroy_cache:
+	kmem_cache_destroy(lsreq_cache);
 	return ret;
 }
 
@@ -1765,6 +1791,7 @@ static void __exit fcloop_exit(void)
 
 	device_destroy(&fcloop_class, MKDEV(0, 0));
 	class_unregister(&fcloop_class);
+	kmem_cache_destroy(lsreq_cache);
 }
 
 module_init(fcloop_init);

-- 
2.49.0


