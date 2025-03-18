Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D297C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZWETNUdSVVnPLOIgB3+KzsG0S3g9o2WsiDM+zzlIHxE=; b=xDDoQzP98v41ydfjKTjwxZhVp+
	kam8K40Kgsa8/QDMyhaXXDPFJwJjpB3VXgqbq2ZngWzvJWPLnpP3ppL0ZbC8jttDeTAuLDnSjpU7z
	AG/Z5o1TrSoGUoMtpNxxtxCt0+uWW0sz2b6ZHkD9/+f+EFadns+iF7Yk8kfsSjZaOlbVZPhMtgdFe
	ThGa28M+OQGiinNfFBGQrQa09gT1fMWrLEwNNdGiZMVhv+nLxuwIURhmo83wazoDX5CjGIunhAobN
	63rFR3p+4CL9fs93C4sYIh7F+NqtMjTH/VGs7s8QDwVM/f3pvVqoZJI+fPX7rjvUwU5NiTmXRKH+6
	0AOTmnLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUNM-00000005YVm-32Ih;
	Tue, 18 Mar 2025 10:40:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUNH-00000005YNn-1nYa
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E5E2E5C589E;
	Tue, 18 Mar 2025 10:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BF3C4CEF3;
	Tue, 18 Mar 2025 10:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294442;
	bh=LsxWRr6DZwClzttPCXevbMAdxFVVZCkmwtITF4CNm6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=soz2KTn7sSTwHvisSf3FNLsnFKA3B5v7bXlcXTsytIt+LuILWxJi1CAkbp0INx/Mi
	 9lBzZs4QjhlN55kCwTGjN4K8Y1hg9Uf8M4HWOhpXEt/zW673csJnwG8xN+2IJrI3Pf
	 XxdMJraGkm/3Wp1CZARbe2egbaRUq2kG2ilr+FrlxjpzrTQMPwGfT03cxiJkenEtne
	 BWYx7xgtbUrPa4w29Lui2ipMqwTHhebJDpxWZy1OTP5z68F1TEDB4NyWF3QxEd1amW
	 hj/MLWsF3pah3rXipL6qNq5BHM2gbY/VUuyzFE7+gYa1bofaySoUidyY4YKuAl+TqL
	 lmqX+oyvQ9kyA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:10 +0100
Subject: [PATCH v3 16/18] nvmet-fc: take tgtport refs for portentry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-16-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034043_617698_96298302 
X-CRM114-Status: GOOD (  15.03  )
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

Ensure that the tgtport is not going away as long portentry has a
pointer on it.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d10ddcb57c1b09d871152f0d9a48f93ec6dc8685..649afce908bbade0a843efc4b8b76105c164b035 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1265,6 +1265,7 @@ nvmet_fc_portentry_bind(struct nvmet_fc_tgtport *tgtport,
 {
 	lockdep_assert_held(&nvmet_fc_tgtlock);
 
+	nvmet_fc_tgtport_get(tgtport);
 	pe->tgtport = tgtport;
 	tgtport->pe = pe;
 
@@ -1284,8 +1285,10 @@ nvmet_fc_portentry_unbind(struct nvmet_fc_port_entry *pe)
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
@@ -1303,8 +1306,10 @@ nvmet_fc_portentry_unbind_tgt(struct nvmet_fc_tgtport *tgtport)
 
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
@@ -1327,6 +1332,9 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
 	list_for_each_entry(pe, &nvmet_fc_portentry_list, pe_list) {
 		if (tgtport->fc_target_port.node_name == pe->node_name &&
 		    tgtport->fc_target_port.port_name == pe->port_name) {
+			if (!nvmet_fc_tgtport_get(tgtport))
+				continue;
+
 			WARN_ON(pe->tgtport);
 			tgtport->pe = pe;
 			pe->tgtport = tgtport;
@@ -1664,7 +1672,6 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 }
 EXPORT_SYMBOL_GPL(nvmet_fc_unregister_targetport);
 
-
 /* ********************** FC-NVME LS RCV Handling ************************* */
 
 
@@ -2901,12 +2908,17 @@ nvmet_fc_add_port(struct nvmet_port *port)
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
@@ -2922,11 +2934,21 @@ static void
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
@@ -2935,10 +2957,21 @@ static void
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


