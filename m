Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE7DC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 12:03:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAA26186A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 12:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAA26186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gM1vweEizcq93hrbj4uEcaZ6xm6dS+e69ENpMkqwg7s=; b=XhBOLSsHH3E85qX3GhPmbr5PBR
	+aetfu4yFoDCLqeMy8nH3yNkqdgTQ0ia4loKwr1KG6XR5bSiMzEoIfsA6J1ZSO7ZBXdTVKNYuKewj
	TI8kvcz5a2swD82Qt12IzKtwA/a/ZLTBxCE9TqEh/p4zQhx/TkaizWfLeEvg68R0j741FAXr7c9X1
	32h0w001/DpVs+Yq44vpvHfuAAvMRl/Z/q6gCwRkEqKRPS2bwAe03q9r8ltN/7oBaxnGKxULTn1fb
	COX3aKxoNXYqrgCjiVLj9PPltCP4fznWH+nqiEM2gb4YUSgCg8OUNoa4KCkE5gKzfghwB5lXxKUvE
	DcIJxIeg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgR6H-00HH7W-WE; Tue, 11 May 2021 12:02:58 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgNMJ-00GYgd-QR
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 08:03:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=K9cnI1dH3Q2scfUZJw3TJJVXNzzGPATRYGH5Vvf8RGs=; b=vzMKLz/PoPP5j3wUxpjEbrQZWG
 NE2NV8nHMDhxT8586aKiUCJgqq+YY6VV38y+WOx6FTsk6jrznL/A5GzTcY8ENQt9byHLCAjlis5zI
 HSokg10s3Z1VB1k+AVPFnQY7G4V5GJD3wmM+/rswgYb5/nvgM9UQAAchG4zieOcSE9N1DTlq51iVG
 eeRlRZ4PFV9UvaSn339EI/mx2TIG5K57KQScFpafSQKLsfBnpomeGDgxpVrYvi+C9/URc1O2HObhU
 HLpDr1E8mhLlotRmqodEpDIghJ4QlTPuXA4h3krbhk5KldcVj8zeRYeNxMo5NUpaFH/EKzUIW2Iix
 TroByRLQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgNMG-009NdM-RD
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 08:03:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 893BAADE2;
 Tue, 11 May 2021 08:03:11 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] nvme: generate uevent once a multipath namespace is
 operational again
Date: Tue, 11 May 2021 10:03:08 +0200
Message-Id: <20210511080308.6734-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_010313_046833_AF71ABC1 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_010313_046833_AF71ABC1 
X-CRM114-Status: UNSURE (   5.87  )
X-CRM114-Notice: Please train this message.
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

In an all paths down scenario I/O will be requeued or aborted, so no
further I/O will be ongoing on this namespace.
This leaves upper layers like MD unable to determine if the namespace
becomes operational again after a successful controller reset.
This patch will send an uevent per multipathed namespace once the
underlying controller is LIVE, allowing MD to start resync.

Changes to v1:
- use disk_uevent() as suggested by hch

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0551796517e6..ecc99bd5f8ad 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -100,8 +100,11 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->head->disk)
-			kblockd_schedule_work(&ns->head->requeue_work);
+		if (!ns->head->disk)
+			continue;
+		kblockd_schedule_work(&ns->head->requeue_work);
+		if (ctrl->state == NVME_CTRL_LIVE)
+			disk_uevent(ns->head->disk, KOBJ_CHANGE);
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
