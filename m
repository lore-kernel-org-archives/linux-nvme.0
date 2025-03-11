Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D71C28B30
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hNfrKbJeueAsIAdj7b0oe7qGhBBCcNSresjt9sA5hPQ=; b=Wew7Vo0e6/GXzikeI6Hv05kUCn
	EWybNVQumONLPGl7hMtTBsreYSdM6TGP897a53n2Vip3WOjP+8cKZVXuPljoRjfy092kwxNagwTNh
	i6cgpODLkWgmAz0S9ZON3XGHBkngL06GJcKM+5Y6wJnAS8cs80TNfxuo9Atf/ivio9zXhqJZMiWtq
	1L5uwOnMAU3TfY0EAjWKybcMyA1OY+Ykj72ws/IKfi+fx20aQM2/FuckEHkomkFRB6csKu6D9mqM3
	LrwYapgTe2A9MmbuZSrZdHputc/Nvf19p6rVJ5D0dTrZVi6W//EMhlTggMWekQAso7YlwAJxQHpjL
	KTiJs76g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaT-00000005G2d-06MY;
	Tue, 11 Mar 2025 10:11:49 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaR-00000005G17-1MJ2
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:11:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 801F3A46A4F;
	Tue, 11 Mar 2025 10:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBE9C4CEEB;
	Tue, 11 Mar 2025 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687906;
	bh=Re6JnAPJGLA4JFG856r1n2YeoKiYwnht9Nqi1eaEqH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N1kbDNslx4aTMEsQ+rbRNO6W1ROODIG85ZYCmLbBynyX9gWsFHOe6MdiPi9c0g6JN
	 Qs4uMQjeO2D2hijfZcwfUx5lbNZS9WnllzBCZrYk27FoNrs+err3D0gCkPmAZXtbKu
	 s6E45tbvhmQicCRWFjSKLGOMd11CBvWtBYsYjf8vm7vbU271qYfd3Ep1jd6s05Yd5y
	 Y6/vHQQ2JbO79uwq6DBjLt/K6WQws0HRsthlJNUeaQRgMj4VzVxzq9KEuGJFs3lvai
	 SiZu2U/Ts7bXsSCWDMpVr1UBJYhSZFumtxdXkPa/6YMAO/oGjeoSOghmOz0hRe4C8E
	 S3Np8mqgfjuDw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:28 +0100
Subject: [PATCH v2 02/15] nvmet-fcloop: replace kref with refcount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-2-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031147_505936_AB389EA9 
X-CRM114-Status: GOOD (  12.29  )
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
index 5493677a948d34391c7c08055dfefd91cc3ff33f..762ba908130b37bbd41f6888c9cb2a56ef3b7afe 100644
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
@@ -274,7 +274,7 @@ struct fcloop_fcpreq {
 	u32				inistate;
 	bool				active;
 	bool				aborted;
-	struct kref			ref;
+	refcount_t			ref;
 	struct work_struct		fcp_rcv_work;
 	struct work_struct		abort_rcv_work;
 	struct work_struct		tio_done_work;
@@ -534,24 +534,18 @@ fcloop_tgt_discovery_evt(struct nvmet_fc_target_port *tgtport)
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
@@ -748,7 +742,7 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
 	INIT_WORK(&tfcp_req->fcp_rcv_work, fcloop_fcp_recv_work);
 	INIT_WORK(&tfcp_req->abort_rcv_work, fcloop_fcp_abort_recv_work);
 	INIT_WORK(&tfcp_req->tio_done_work, fcloop_tgt_fcprqst_done_work);
-	kref_init(&tfcp_req->ref);
+	refcount_set(&tfcp_req->ref, 1);
 
 	queue_work(nvmet_wq, &tfcp_req->fcp_rcv_work);
 
@@ -1001,12 +995,13 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
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
@@ -1014,16 +1009,10 @@ fcloop_nport_free(struct kref *ref)
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
@@ -1254,7 +1243,7 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 		newnport->port_role = opts->roles;
 	if (opts->mask & NVMF_OPT_FCADDR)
 		newnport->port_id = opts->fcaddr;
-	kref_init(&newnport->ref);
+	refcount_set(&newnport->ref, 1);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
 

-- 
2.48.1


