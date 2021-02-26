Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906E5C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 08:06:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B8464EE1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 08:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B8464EE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gfqdPiRn1/1TRMNkWoje5LsYKb3uZTlvK5uA7pdozz4=; b=EGFEexcj6nFgTd+1WgOi33IWrv
	jOY1lsIG1QMjCF3nrIosn8wKA4dPLjpKjUtAByc3l7uYw0euXM0NBv04hFgnwVOjovoGCXM7bVvk3
	3iCqK9wGQBT/pVyuA7i/kypr7+77LbwJzSHd52I/fiORp3YpEJdLqNI8I91ml4BpM771yqYKzZqpK
	uTddfXC++D982XHHk1t0GMCLLkcXcg2JH0rs/MPSwUrZXE0XcScZjaeT/xyDPun1E9Eqd4jMSUzsg
	7IA0ADc3BLXdEjjVRKAnNjUbvIDB1qCbLV5sC6KtEw9OZ7EX7khTb0nYaWre4x62ahwLZkOkuNXsC
	037X/QnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFY8D-0003mv-Vj; Fri, 26 Feb 2021 08:05:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFY87-0003mM-De
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 08:05:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 48151ADDC;
 Fri, 26 Feb 2021 08:05:41 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Keith Busch <keith.busch@wdc.com>
Subject: [PATCH] nvme: send uevent once a multipath namespace is operational
 again
Date: Fri, 26 Feb 2021 09:05:38 +0100
Message-Id: <20210226080538.108392-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_030543_604432_399A9182 
X-CRM114-Status: GOOD (  13.16  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In an all paths down scenario I/O will be requeued or aborted, and no
further I/O will be ongoing on this namespace.
This leaves the upper layers unable to determine if the namespace
becomes operational again eg. after a successful controller reset.
With this patch a 'change' uevent will be sent per multipathed namespace
once the underlying controller moved to LIVE and started I/O processing
by calling nvme_kick_requeue_lists().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7d38f9272490..844d952bd86f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -97,8 +97,12 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->head->disk)
-			kblockd_schedule_work(&ns->head->requeue_work);
+		if (!ns->head->disk)
+			continue;
+		kblockd_schedule_work(&ns->head->requeue_work);
+		if (ctrl->state == NVME_CTRL_LIVE)
+			kobject_uevent(&disk_to_dev(ns->head->disk)->kobj,
+				       KOBJ_CHANGE);
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
