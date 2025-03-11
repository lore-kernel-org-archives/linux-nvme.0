Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775C3C28B30
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YvcPq8wr4ImsT/5/z4bpopIwxbHziZvR/bmYSkhcYiw=; b=TJwPGV8zlYMYGWZcIn5xfMRtSA
	7Mv1sEPZcGdV5yjzGh3RUbSAeCRqEo8FEdNxnn/Ocbn9kmyxnrcUT2eIujSBsNyrF5Dj5UGrqjVHB
	w4dx/xdXAfcZ1qGwx0OvAT7QJcCZE4O3yJgFznG8Kwrpcow2f9SRKGEAW3tQ2Xhml3aeToIUZhSN9
	MCT07yJ1lB8JElLe8e7/vIYjqNmIGWwTCvQgRhNceTPo8ltAqnohvJe4AhvWD57owVhQQcH4PyTRu
	AdXQKWOj3lanLLIcNqsDbOD04xGn1RoTJ8Dukml8H7hYARvBDTXhTw/1hFM1PmqOEkcoi+EVk4kSS
	mX6dnjXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trway-00000005GcH-0opQ;
	Tue, 11 Mar 2025 10:12:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwav-00000005GYI-2SVF
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:12:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0F6795C5D67;
	Tue, 11 Mar 2025 10:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C3DC4CEE9;
	Tue, 11 Mar 2025 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687936;
	bh=7ig0DLd7nkzl08O52hRpSPTMJ+VqCd+IrpqOT21+7Jw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LM0rkk1EHl86/DU5oigIinXNK3Q8CHY5SZikIrn+94WM2zp/ovucEUzfmi1fkMizJ
	 1xJWw3XxckodAY/GDAnNC1vHhYMLHlL4Vel1qlPeVss9WbC/e8+IKOEE4nUpmd8WVC
	 /R+HvPpk+V0xkAOw/b6H4hKznYDhIFXwBXHT9HxBBWS3nzhGkUTAnHdD07fYKBBHyG
	 YU8PHzpgT+rprhB57/qly+/0bGScpuhoCBp8r/ANjggWC0/tJ4H6zZqL+Wk4YxUGNe
	 j39nOSdJQAzCkLQepZ+ivrys1136UuyTDcXdsEaQq3Nn47EBWf1QMFheQHOtL8Y8LD
	 OwwGfuL8cO66w==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:40 +0100
Subject: [PATCH v2 14/15] nvmet-fc: take tgtport refs for portentry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-14-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031217_761888_14783CE8 
X-CRM114-Status: GOOD (  14.80  )
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

Ensure that the tgtport is not going away as long portentry is a pointer
on it.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d8c7efa6b6937aa9f5b99735f6669da973bf9ed3..50cfa02bf8cd1bc39ee8ca3f0b260c5a8733a9df 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1269,6 +1269,7 @@ nvmet_fc_portentry_bind(struct nvmet_fc_tgtport *tgtport,
 {
 	lockdep_assert_held(&nvmet_fc_tgtlock);
 
+	nvmet_fc_tgtport_get(tgtport);
 	pe->tgtport = tgtport;
 	tgtport->pe = pe;
 
@@ -1288,8 +1289,10 @@ nvmet_fc_portentry_unbind(struct nvmet_fc_port_entry *pe)
 	unsigned long flags;
 
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
-	if (pe->tgtport)
+	if (pe->tgtport) {
+		nvmet_fc_tgtport_put(pe->tgtport);
 		pe->tgtport->pe = NULL;
+	}
 	list_del(&pe->pe_list);
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 }
@@ -1307,8 +1310,10 @@ nvmet_fc_portentry_unbind_tgt(struct nvmet_fc_tgtport *tgtport)
 
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
 	pe = tgtport->pe;
-	if (pe)
+	if (pe) {
+		nvmet_fc_tgtport_put(pe->tgtport);
 		pe->tgtport = NULL;
+	}
 	tgtport->pe = NULL;
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 }
@@ -1331,6 +1336,9 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
 	list_for_each_entry(pe, &nvmet_fc_portentry_list, pe_list) {
 		if (tgtport->fc_target_port.node_name == pe->node_name &&
 		    tgtport->fc_target_port.port_name == pe->port_name) {
+			if (!nvmet_fc_tgtport_get(tgtport))
+				continue;
+
 			WARN_ON(pe->tgtport);
 			tgtport->pe = pe;
 			pe->tgtport = tgtport;
@@ -1661,7 +1669,6 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 }
 EXPORT_SYMBOL_GPL(nvmet_fc_unregister_targetport);
 
-
 /* ********************** FC-NVME LS RCV Handling ************************* */
 
 
@@ -2900,12 +2907,17 @@ nvmet_fc_add_port(struct nvmet_port *port)
 	list_for_each_entry(tgtport, &nvmet_fc_target_list, tgt_list) {
 		if ((tgtport->fc_target_port.node_name == traddr.nn) &&
 		    (tgtport->fc_target_port.port_name == traddr.pn)) {
+			if (!nvmet_fc_tgtport_get(tgtport))
+				continue;
+
 			/* a FC port can only be 1 nvmet port id */
 			if (!tgtport->pe) {
 				nvmet_fc_portentry_bind(tgtport, pe, port);
 				ret = 0;
 			} else
 				ret = -EALREADY;
+
+			nvmet_fc_tgtport_put(tgtport);
 			break;
 		}
 	}
@@ -2921,11 +2933,21 @@ static void
 nvmet_fc_remove_port(struct nvmet_port *port)
 {
 	struct nvmet_fc_port_entry *pe = port->priv;
+	struct nvmet_fc_tgtport *tgtport = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
+	if (pe->tgtport && nvmet_fc_tgtport_get(pe->tgtport))
+		tgtport = pe->tgtport;
+	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_portentry_unbind(pe);
 
-	/* terminate any outstanding associations */
-	__nvmet_fc_free_assocs(pe->tgtport);
+	if (tgtport) {
+		/* terminate any outstanding associations */
+		__nvmet_fc_free_assocs(tgtport);
+		nvmet_fc_tgtport_put(tgtport);
+	}
 
 	kfree(pe);
 }
@@ -2934,10 +2956,21 @@ static void
 nvmet_fc_discovery_chg(struct nvmet_port *port)
 {
 	struct nvmet_fc_port_entry *pe = port->priv;
-	struct nvmet_fc_tgtport *tgtport = pe->tgtport;
+	struct nvmet_fc_tgtport *tgtport = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
+	if (pe->tgtport && nvmet_fc_tgtport_get(pe->tgtport))
+		tgtport = pe->tgtport;
+	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
+
+	if (!tgtport)
+		return;
 
 	if (tgtport && tgtport->ops->discovery_event)
 		tgtport->ops->discovery_event(&tgtport->fc_target_port);
+
+	nvmet_fc_tgtport_put(tgtport);
 }
 
 static ssize_t

-- 
2.48.1


