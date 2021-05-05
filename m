Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE5C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 10:33:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA26613C0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 10:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA26613C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FDHFOfvwLhuj0KsvogecsLv3vH+yccE3PTnAq3K0pBw=; b=DYWlITe0MxjzDcTSxKn4AfdqUn
	rzgYXSPXP5PvO7OxWJhihMA9klwJeBan93a/OyTjDzUP6Wj0o/UOSw5SlC/kVptUTI+dLRGqI8PIy
	lOCSaywCy+usAaNa/16zTq+EwrYLoH5mesGElTaX0epVFbmrBiSfiGexCUeefw6xc8H0LPHnERESV
	3HHY9Sw7qWwZRbfP/K51EM0oiBqZJxbW0fS8mIbNaTKxoGUVZ+hsDMbQNXNPhGsuj98X5/L82uPCB
	E/Go3+x0W5GjZfybvmPR1IlngM1qlZW5ELu38YxdPLB8y9mF6Ak641sPKmuswkceEH+8L17nHqJ3f
	4+djUJkw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leEqC-000yPe-1c; Wed, 05 May 2021 10:33:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leEq7-000yOf-Mm
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 10:33:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=RNp7hpx1vVGSlmeLDxVFJUeY6xVw8tD6aRcyw7hoVMU=; b=1wACyp/U/isW8lHrkyQsR3o2BA
 DMvyjqDoIHPg65YhM8tsHgzDKxDVWmIAqP8KAhxNh1V8GknCwcH+nhQdrcwjLi0JQW16BMG1dHBUX
 YuAx8+5VyBDCnOaH+rUJHvL3jgp5YnmkhyfOuw4yuaVyUOpegKx5U5qrpeux8OXlGZkii6oXLFFq1
 XRVLPtcFZW3hqvhG7FMpPQJYERwV/HP9YzXhi0FZuZiJvsrHiwVOO2DRPzYD48WloG+lW+9h0Vyt5
 s7l4E22tI31NGewLEfmC2N9sUGJ+zU2lazA4yybQPgkwSvzRQp2u+/1YaogUaqFMG9r09jkqJfZW1
 gq2tSjLQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leEq4-004g4B-Ny
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 10:33:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 242B3B190;
 Wed,  5 May 2021 10:33:07 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: generate uevent once a multipath namespace is
 operational again
Date: Wed,  5 May 2021 12:33:05 +0200
Message-Id: <20210505103305.107475-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_033308_942913_AC14BAA3 
X-CRM114-Status: GOOD (  10.18  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0551796517e6..f099897aea59 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -100,8 +100,12 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 
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
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
