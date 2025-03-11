Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4B4C28B2E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MVKpdm1gZY4T2isVEz7X8NgzsVPgs+Mn66sbMM4uXUM=; b=3OMjvghbwsW1pXkILRZSvJ99oE
	RVkN4qsAK7Wpq/BRf6LITyFPDIw+27ciYY9akaWhSxGqmbi+M2KonlSu/rgjYUXWSvvS88cDxJzRd
	aucaZj98B8rzxXi4X59WcMZg6xhW8wngFd4C7KRauZERbI2nr1H6vp3+2L34cn9waoBmK9C/GnPjo
	DngkHbNXpiN6tKE+65aAFbvmmjmeizl+kVwiRNKJjycunY929fXzRrvL9ypAgKlsjmN9qMp34x0lB
	9tWklfNuoNo+aOilcKgdxemem/VLMNuNb3fbCnnLRaGaUQF0AwNX9H6KWY7IPJPwB7I4hbLzA9EYU
	eP5z+tuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaw-00000005GaH-1fJj;
	Tue, 11 Mar 2025 10:12:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwas-00000005GUS-3X1x
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:12:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 867175C569E;
	Tue, 11 Mar 2025 10:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9124C4CEEE;
	Tue, 11 Mar 2025 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687934;
	bh=IeQSZtd0MPY3LXioFxehoJwhXdwFjGUg/LwHWngWZ8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YvjEhBeko1ayMoipx+MMOD6l/48tG2RrdoA7v3xFh3KcqG3cI6MhExTbJCQgq+oSA
	 Q/2JzrqzQ/RjkXNIMfxlF/UBycsLvJI7KPpPhDJrXSZ6OThz/qmRmyL0dG84RUnJ1c
	 wA+HEotn1JvJ4u2LIEfsViCvourHOw8F/6R8IGRxgCWAE4iqChQkSJeOm6p3P9zuO1
	 mRZs07jkXILpuo5aycwXRSF16zQJcpVT+yqx9VwXIX6GGNutLtX0SDlvEzp3WYpZbQ
	 OvGrNi1Ba8/Xfk+1vgqGz4T9eEMVfZUfuQ+lVzkaWaFCDhYPloPxSPZdUmYKTRMV5H
	 a8iFJ2fbBZS9g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:39 +0100
Subject: [PATCH v2 13/15] nvmet-fc: inline nvmet_fc_free_hostport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-13-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031214_931861_DABB892C 
X-CRM114-Status: GOOD (  11.51  )
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

No need for this tiny helper with only one user, let's inline it.

And since the hostport ref counter needs to stay in sync, it's not
optional anymore to give back the reference.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7ff6f065fccb3f772b785e393c122e45d624c802..d8c7efa6b6937aa9f5b99735f6669da973bf9ed3 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1009,16 +1009,6 @@ nvmet_fc_hostport_get(struct nvmet_fc_hostport *hostport)
 	return kref_get_unless_zero(&hostport->ref);
 }
 
-static void
-nvmet_fc_free_hostport(struct nvmet_fc_hostport *hostport)
-{
-	/* if LLDD not implemented, leave as NULL */
-	if (!hostport || !hostport->hosthandle)
-		return;
-
-	nvmet_fc_hostport_put(hostport);
-}
-
 static struct nvmet_fc_hostport *
 nvmet_fc_match_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 {
@@ -1193,7 +1183,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	/* Send Disconnect now that all i/o has completed */
 	nvmet_fc_xmt_disconnect_assoc(assoc);
 
-	nvmet_fc_free_hostport(assoc->hostport);
+	nvmet_fc_hostport_put(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1460,11 +1450,6 @@ nvmet_fc_free_tgtport(struct kref *ref)
 	struct nvmet_fc_tgtport *tgtport =
 		container_of(ref, struct nvmet_fc_tgtport, ref);
 	struct device *dev = tgtport->dev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
-	list_del(&tgtport->tgt_list);
-	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_free_ls_iodlist(tgtport);
 
@@ -1656,6 +1641,11 @@ int
 nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 {
 	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
+	list_del(&tgtport->tgt_list);
+	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_portentry_unbind_tgt(tgtport);
 

-- 
2.48.1


