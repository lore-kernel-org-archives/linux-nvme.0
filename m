Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5822C4727E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13AD52396D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="v60tPAYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AD52396D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xv1R7W8JCVe5K+ZVY/0oQVvDhuSY0l1wXl68fFLmQAY=; b=v60tPAYpQva5WjVcXMYQCo1JNX
	TaQps34PNNhrtUspRNx8M0yQUnBQwusAZwohaUNx7pRb3IA4Jd68E2y7qE7UJWoSF9XNdZbRVAMOB
	TX+5ECCoeP2aaxrfZ0zr+VlnzQBU0CvuLLZqqe01/8YNYMi+ymiWyCvFzCSLzNPs9NAR+ithfXUw5
	CafysQUQZn6KcbgmTYlJOaaNQ2rEc9CaYUDRbgYZD/CZh5T/vPAbAOH5IamKY0/t8CJFWbpt4918E
	ibNAVWj8QLKBvc69eFgmhQ2VTQKrFe7BVakn5NyAReVVbqjQDixZl6h4Z2G+C+h5vB+N/KKafLA2e
	D07+XryQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKhCe-0003or-Ii; Tue, 22 Sep 2020 12:15:24 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKhCU-0003lf-Kg
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 12:15:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9EFDEAF54;
 Tue, 22 Sep 2020 12:15:48 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/7] nvme-fcloop: flush workqueue before calling
 nvme_fc_unregister_remoteport()
Date: Tue, 22 Sep 2020 14:14:55 +0200
Message-Id: <20200922121501.32851-2-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200922121501.32851-1-hare@suse.de>
References: <20200922121501.32851-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_081514_833505_A3A0E56F 
X-CRM114-Status: GOOD (  15.27  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_fc_unregister_remoteport() will be sending LS requests, which then
would end up on a workqueue for processing. This will deadlock with
fcloop_remoteport_delete() which would try to flush the very same queue.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fcloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c97e60b71bbc..082aa4dee406 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -979,7 +979,6 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
 
-	flush_work(&rport->ls_work);
 	fcloop_nport_put(rport->nport);
 }
 
@@ -1313,6 +1312,7 @@ __remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
 	if (!rport)
 		return -EALREADY;
 
+	flush_work(&rport->ls_work);
 	return nvme_fc_unregister_remoteport(rport->remoteport);
 }
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
