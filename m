Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B713EC79F82
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hcG/JNsYG4XlM/F44l1BRu/e1s4p2porjzayn+O62Bw=; b=0tiXA86MzM05OogH9Z6J4iO3Yt
	L1s+cSTg2kcigQyx9Gs/SZE6kccRST83MOFV8fL7TLw+/Zx6ErJqoekHfDzcSuZuhiSXVLZo2Z3HN
	JpDEJ2XcdbLd+26zPXLlBbZwciUnySOA/VpHnm3j5Y9nbyFsvvmwYI+E7IUNmuzdY00uYXG3c1Kn/
	q0cJTIbUjEhU3RKLrNljyH09ceLTDPq6n0ro8WSjSkStviDe7ZPbU/X547wYXBw5bIEOAmUvYTZ/D
	wRt0/VdXQ1/p48OGuiamheUQZ1zGFvbn/bhc1NeCixlRfVw4dZOYt777Kco6O+Y0o3N+8U5vwR3NC
	oQcNEJ7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3wuP-00000009HuG-1JIR;
	Tue, 08 Sep 2026 14:34:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3wuM-00000009HtY-2zli
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 14:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788878083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hcG/JNsYG4XlM/F44l1BRu/e1s4p2porjzayn+O62Bw=;
	b=BrzptRC9sV0CFawcbodMJ0qQ7azXWvRMC2bhzcKCqhGTh8d+Nd+5wBoNqCLm3obOO2Y5R1
	cr++KwAlNYmF3h2qxvTa1JVhPkkZ3ZBZFHcIcbRcGrOCAScDdQHcYI8JTZFR1QHfsFifR9
	wVUlk12EV/z+MWxdeLiaAgsgTAhWRtI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-xV6-EpDgNCyDRczbG5H7vQ-1; Tue,
 08 Sep 2026 10:34:40 -0400
X-MC-Unique: xV6-EpDgNCyDRczbG5H7vQ-1
X-Mimecast-MFC-AGG-ID: xV6-EpDgNCyDRczbG5H7vQ_1788878079
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC8BF184B3A7;
	Tue,  8 Sep 2026 14:34:38 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5428D18005AA;
	Tue,  8 Sep 2026 14:34:36 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mlombard@arkamax.eu,
	dwagner@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: do not warn on controller removal race
Date: Tue,  8 Sep 2026 16:34:34 +0200
Message-ID: <20260908143434.105513-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dS34oBfzAJF4bbXg3i9PkAPknP2kqtms6Bs2s8qKF1M_1788878079
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_073446_822634_4E31144C 
X-CRM114-Status: GOOD (  13.57  )
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

In nvme_fc_reconnect_or_delete(), the system attempts to remove
the controller when reconnect limits are reached by calling
nvme_delete_ctrl(). This call is currently wrapped in a WARN_ON().

If a user concurrently deletes the controller via sysfs, the
controller's state may have already transitioned out of the
CONNECTING state. When this happens, nvme_delete_ctrl() correctly
rejects the operation and returns -EBUSY. Because of the WARN_ON()
wrapper, this race condition triggers an unnecessary kernel warning
stack trace.

Remove the WARN_ON() macro around nvme_delete_ctrl();
this allows the system to safely ignore the -EBUSY return value
if the controller is already being deleted.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 48454cb7a0fc..3a4030bcfab7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3338,7 +3338,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 				ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
 					(ctrl->ctrl.opts->max_reconnects *
 					 ctrl->ctrl.opts->reconnect_delay)));
-		WARN_ON(nvme_delete_ctrl(&ctrl->ctrl));
+		nvme_delete_ctrl(&ctrl->ctrl);
 	}
 }
 
-- 
2.55.0


