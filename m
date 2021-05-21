Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22136C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 08:23:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2F760FD8
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 08:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2F760FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JPe3whm0QsbkHy7yEB+rz5WGwImTx90GCARBjDL9/Kw=; b=jOdY3G1JJwynMjqxe4LvwfErzk
	izqT2bat6Cgz1XHDVGJ2jSUV8MSViYaYHAimqQV+AW0r/h1gOfq/hYyau+AXCh9mauPw4uyx1+eKO
	FLPqLMNwNJ1GCuUJ5aAKNA2BKYKlukH1Q5RcLvkp+XUcA9wmlEKotAXupvXgoufAancrcmFrFzylf
	+w2hkQ+MrBKWaJ2IJtWXqPOqnhFwuQTgUrMYWuZc2m9/7KHcyW1BRQdbCtveK9sJd5etVuMEmcOte
	MjZ9AS92fz/V4bRBEScoMtan6syWDBU0wb3r3wl4Bn/QRtTeroGo1djJUGRSfkmtoPHxJn0BKSenz
	TD3rgjWg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk0RD-004P99-Ar; Fri, 21 May 2021 08:23:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk0RA-004P8w-ST
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 08:23:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=5i0l3fxbFullip5p+wmbRxGl5SKFSaZzmBezLvOEJLg=; b=2d+uyKt2htPVYToeELvXHGLRNu
 OSp2xG+uvI5y90bKa87Rp4Y04DRL0jb/hZ8zGZ3LfrcV5no/J8yscNACfzxeZwr2RyGQG3jptxYmR
 B2a4nnp4w/FI38HB8YQvkXNejEzRCX3fE8BvpCGrC1dgsAT80/9XM6xsRt0nwOfJ9c+DOyEIed3Tt
 LpIcqjwT2a1m53KP2bipXR1pM/6sqovwrrZDz2DIvxh6kgAQyzqtaOm///AvIsFG/zbtvjV4dlUvE
 6vxghDnbwTJxucTMpNW+rr+rN/Jq1hyR05DevxCJp2L2vMopp9DMctDiOOZhxBeRLSzxYYqgoJtf1
 DYft7hUQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk0R8-00GwSd-2f
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 08:23:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D0A69AACA;
 Fri, 21 May 2021 08:23:09 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme/fc: Short-circuit reconnect retries
Date: Fri, 21 May 2021 10:23:00 +0200
Message-Id: <20210521082300.146648-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_012314_289085_3DF16AC4 
X-CRM114-Status: GOOD (  13.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Returning an nvme status from nvme_fc_create_association() indicates
that the association is established, and we should honour the DNR bit.
If it's set a reconnect attempt will just return the same error, so
we can short-circuit the reconnect attempts and fail the connection
directly.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fc.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d9ab9e7871d0..b16acab5d8d8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3095,6 +3095,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (ctrl->ctrl.icdoff) {
 		dev_err(ctrl->ctrl.device, "icdoff %d is not supported!\n",
 				ctrl->ctrl.icdoff);
+		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto out_disconnect_admin_queue;
 	}
 
@@ -3102,6 +3103,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (!(ctrl->ctrl.sgls & ((1 << 0) | (1 << 1)))) {
 		dev_err(ctrl->ctrl.device,
 			"Mandatory sgls are not supported!\n");
+		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto out_disconnect_admin_queue;
 	}
 
@@ -3268,11 +3270,13 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING)
 		return;
 
-	if (portptr->port_state == FC_OBJSTATE_ONLINE)
+	if (portptr->port_state == FC_OBJSTATE_ONLINE) {
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
 			ctrl->cnum, status);
-	else if (time_after_eq(jiffies, rport->dev_loss_end))
+		if (status > 0 && (status & NVME_SC_DNR))
+			recon = false;
+	} else if (time_after_eq(jiffies, rport->dev_loss_end))
 		recon = false;
 
 	if (recon && nvmf_should_reconnect(&ctrl->ctrl)) {
@@ -3286,12 +3290,17 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 
 		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
 	} else {
-		if (portptr->port_state == FC_OBJSTATE_ONLINE)
-			dev_warn(ctrl->ctrl.device,
-				"NVME-FC{%d}: Max reconnect attempts (%d) "
-				"reached.\n",
-				ctrl->cnum, ctrl->ctrl.nr_reconnects);
-		else
+		if (portptr->port_state == FC_OBJSTATE_ONLINE) {
+			if (status > 0 && (status & NVME_SC_DNR))
+				dev_warn(ctrl->ctrl.device,
+					 "NVME-FC{%d}: reconnect failure\n",
+					 ctrl->cnum);
+			else
+				dev_warn(ctrl->ctrl.device,
+					 "NVME-FC{%d}: Max reconnect attempts "
+					 "(%d) reached.\n",
+					 ctrl->cnum, ctrl->ctrl.nr_reconnects);
+		} else
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: dev_loss_tmo (%d) expired "
 				"while waiting for remoteport connectivity.\n",
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
