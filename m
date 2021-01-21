Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A40C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:50:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8565A23977
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8565A23977
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iOPM+y7IoSvdF6bo+q6xqM/mgAVQdMmd0qEq8eswKcM=; b=ec4+frZc4AduCZ/QcosKWw3wiO
	kmuad/RchT/4VJ1VDhzNjhHmCPES5phxTmjFJ2QNZtDpeNwYJFBicW26DiG7cIHLBva3YwiTyQoud
	dKPwfQg1Qp6L98iC04/U9Uxxl9wQlXsO573El56BCyvY5dJfR8E23KVge+CL/dkLVEs2UikEnYTIO
	mSKXsyj+y4VUWy08QFFnIfTE2QwOncPLatTNKWg+QHjRYA6Qr8qFCPuEJ/yD0w08Rz8LH5ejSxHQc
	eJ98NJ2quMVYolOB1qaxSHpkW3b7lOTF1ah7EcZWAEKOh897KjJEcz+1rwEpRsHVbcxmqo536ab17
	BgpiWv/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2Wbj-00083Q-RP; Thu, 21 Jan 2021 09:50:27 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2Wbh-00082i-KS
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 09:50:26 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0B81AAD11;
 Thu, 21 Jan 2021 09:50:24 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: do not ignore nvme status in nvme_set_queue_count()
Date: Thu, 21 Jan 2021 10:50:21 +0100
Message-Id: <20210121095021.22807-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_045025_812895_B05ED185 
X-CRM114-Status: GOOD (  16.79  )
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
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the call to nvme_set_queue_count() fails with a status we should
not ignore it but rather pass it on to the caller.
It's then up to the transport to decide whether to ignore it
(like PCI does) or to reset the connection (as would be appropriate
for fabrics).

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b61519441..ddf32f5b4534 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1486,7 +1486,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 		*count = min(*count, nr_io_queues);
 	}
 
-	return 0;
+	return status;
 }
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
