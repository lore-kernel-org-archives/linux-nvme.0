Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FF9C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DE2rRQbddUtYZiXryJi6dfqBvhjtsvZMxZ6nV3V8lk4=; b=bFdm+4HeIHeLf+dZizYB1RIhiC
	FpocmRdOF18/XP2Y33oqLiW6jfaB0tjI8v0g227nTWwrpYWv2OQfnSIQYoCzlviSIFa/TEUxfSot2
	4LSxHQZt5wpAeSFVkMEeARDf2GB+8s6hv1GuixGjjtHuZo4IteO/OMRq3UWTU2dntGJ3BL7vPSGFT
	RzKjvxVpHDgJ9SRkojyTt8jLP6MWddbFQ+BP7KxJJNb3v4XgPPWa0H0i31xitmW3f8zNDW1EhHsc4
	zMcQu7/qoZ9zIfIXNIT33pFDzzxyQjKJ3Z6D522CYiatMIvyR3jcAKH+Lmt/XSt9ytaXBd6GTuTGf
	TRe0vV/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMo-00000005Xjy-1max;
	Tue, 18 Mar 2025 10:40:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMi-00000005Xhl-2D8W
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 033725C58A6;
	Tue, 18 Mar 2025 10:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611C0C4CEE3;
	Tue, 18 Mar 2025 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294407;
	bh=uYbbJ9Lv9B3WY9bnHVcEuJUkAEU2zR7VmzonuvW3zrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZtXEn89DkL7cjlYUGmmA9hqR/oWTB7wDcEXCOH7GG6L3tu9JMgKAHYYFogak98jvi
	 Sq9b1ZUzUSFPvoOibUcrG3YQd8KpUDK8Ocx1ETIJPWbxRtmXn6ZLI/2bp3HcyezFhD
	 Vbjj/MqkYamStI/qa3B6uehOEzpx6vz+kluMyD9CUgEvZwfUCZ25f3ZUZnAzKKXRlo
	 gQJPg+Yi1kWyW8m9gphxBKABOLbmTUrEAAqGsrEXRIhTtBsNazPeB4v5cAGSbO55HC
	 JZcOyOKP1GAGEu2gi3AA4XK5A1LfefxBKPwEOE+5R8jpmv8k8I+Ol4QnahpcuOor5k
	 VpUMieQrBpTTQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:39:56 +0100
Subject: [PATCH v3 02/18] nvmet-fcloop: replace kref with refcount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-2-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034008_684388_2371689D 
X-CRM114-Status: GOOD (  12.42  )
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

The kref wrapper is not really adding any value ontop of refcount. Thus
replace the kref API with the refcount API.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 09546c3161fd9828234e58641de3e53519e27824..cfce70d1b11ff305b203d716f78fad23f114e9c3 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -239,7 +239,7 @@ struct fcloop_nport {
 	struct fcloop_tport *tport;
 	struct fcloop_lport *lport;
 	struct list_head nport_list;
-	struct kref ref;
+	refcount_t ref;
 	u64 node_name;
 	u64 port_name;
 	u32 port_role;
@@ -273,7 +273,7 @@ struct fcloop_fcpreq {
 	u32				inistate;
 	bool				active;
 	bool				aborted;
-	struct kref			ref;
+	refcount_t			ref;
 	struct work_struct		fcp_rcv_work;
 	struct work_struct		abort_rcv_work;
 	struct work_struct		tio_done_work;
@@ -533,24 +533,18 @@ fcloop_tgt_discovery_evt(struct nvmet_fc_target_port *tgtport)
 }
 
 static void
-fcloop_tfcp_req_free(struct kref *ref)
+fcloop_tfcp_req_put(struct fcloop_fcpreq *tfcp_req)
 {
-	struct fcloop_fcpreq *tfcp_req =
-		container_of(ref, struct fcloop_fcpreq, ref);
+	if (!refcount_dec_and_test(&tfcp_req->ref))
+		return;
 
 	kfree(tfcp_req);
 }
 
-static void
-fcloop_tfcp_req_put(struct fcloop_fcpreq *tfcp_req)
-{
-	kref_put(&tfcp_req->ref, fcloop_tfcp_req_free);
-}
-
 static int
 fcloop_tfcp_req_get(struct fcloop_fcpreq *tfcp_req)
 {
-	return kref_get_unless_zero(&tfcp_req->ref);
+	return refcount_inc_not_zero(&tfcp_req->ref);
 }
 
 static void
@@ -747,7 +741,7 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
 	INIT_WORK(&tfcp_req->fcp_rcv_work, fcloop_fcp_recv_work);
 	INIT_WORK(&tfcp_req->abort_rcv_work, fcloop_fcp_abort_recv_work);
 	INIT_WORK(&tfcp_req->tio_done_work, fcloop_tgt_fcprqst_done_work);
-	kref_init(&tfcp_req->ref);
+	refcount_set(&tfcp_req->ref, 1);
 
 	queue_work(nvmet_wq, &tfcp_req->fcp_rcv_work);
 
@@ -1000,12 +994,13 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 }
 
 static void
-fcloop_nport_free(struct kref *ref)
+fcloop_nport_put(struct fcloop_nport *nport)
 {
-	struct fcloop_nport *nport =
-		container_of(ref, struct fcloop_nport, ref);
 	unsigned long flags;
 
+	if (!refcount_dec_and_test(&nport->ref))
+		return;
+
 	spin_lock_irqsave(&fcloop_lock, flags);
 	list_del(&nport->nport_list);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
@@ -1013,16 +1008,10 @@ fcloop_nport_free(struct kref *ref)
 	kfree(nport);
 }
 
-static void
-fcloop_nport_put(struct fcloop_nport *nport)
-{
-	kref_put(&nport->ref, fcloop_nport_free);
-}
-
 static int
 fcloop_nport_get(struct fcloop_nport *nport)
 {
-	return kref_get_unless_zero(&nport->ref);
+	return refcount_inc_not_zero(&nport->ref);
 }
 
 static void
@@ -1253,7 +1242,7 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 		newnport->port_role = opts->roles;
 	if (opts->mask & NVMF_OPT_FCADDR)
 		newnport->port_id = opts->fcaddr;
-	kref_init(&newnport->ref);
+	refcount_set(&newnport->ref, 1);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
 

-- 
2.48.1


