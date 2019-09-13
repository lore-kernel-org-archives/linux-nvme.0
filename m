Return-Path: <SRS0=imtT=XI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD891C4CEC7
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 02:45:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E02F20692
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 02:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dhf41UkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E02F20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amzn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=26Sa8MIkyZQJ0Myfirl1ObsWOURSW1+PGBwMGfeEREY=; b=Dhf41UkJ5BwFGu
	a9i4HvCxTC4Aq6ruzgX0oPvWbxTM3PKa26sBaP5kLGMsd2+DHRP4XYAnFy+B4TqZ69UmlbHQMpoii
	LPoqM/yD4Z2SmUy4Afd110CTKkvk93fU1KENG4/o3gzqQ1m8SV2ILq3P46di0f0kEe8OREgYipOvN
	fbNQrIbaMPgZasak8iB0bYjD4g8Jqi5sBcAmQpCwEyqQANxxszYP6ZkRKLyQSJ3B8po9D4tSN8KuC
	RmIdO0s0ZzwGR04cuoYNcYvYjTEMdLkIDbyRxQMLpykAVvJhiorGA+00NkbHmFOw69ChUzbXIenT5
	7dvFQiaeMlPeqxGx4oeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8bZu-0002Tl-SE; Fri, 13 Sep 2019 02:44:55 +0000
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8bZq-0002Sy-1y
 for linux-nvme@lists.infradead.org; Fri, 13 Sep 2019 02:44:53 +0000
X-IronPort-AV: E=Sophos;i="5.64,499,1559520000"; d="scan'208";a="415032740"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
 13 Sep 2019 02:44:37 +0000
Received: from EX13MTAUEA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS
 id 1BA42A1D31; Fri, 13 Sep 2019 02:44:39 +0000 (UTC)
Received: from EX13D05UEE001.ant.amazon.com (10.43.62.120) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 02:44:38 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D05UEE001.ant.amazon.com (10.43.62.120) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 02:44:38 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 13 Sep 2019 02:44:38 +0000
From: Balbir Singh <sblbir@amzn.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 1/2] nvme/host/pci: Fix a race in controller removal
Date: Fri, 13 Sep 2019 02:44:31 +0000
Message-ID: <20190913024432.7705-1-sblbir@amzn.com>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
Precedence: Bulk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190912_194450_222255_6B55FC10 
X-CRM114-Status: GOOD (  12.37  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, axboe@fb.com, Balbir Singh <sblbir@amzn.com>, hch@lst.de,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This race is hard to hit in general, now that we
have the shutdown_lock in both nvme_reset_work() and
nvme_dev_disable()

The real issue is that after doing all the setup work
in nvme_reset_work(), when get another timeout (nvme_timeout()),
then we proceed to disable the controller. This causes
the reset work to only partially progress and then fail.

Depending on the progress made, we call into
nvme_remove_dead_ctrl(), which does another
nvme_dev_disable() freezing the block-mq queues.

I've noticed a race with udevd with udevd trying to re-read
the partition table, it ends up with the bd_mutex held and
it ends up waiting in blk_queue_enter(), since we froze
the queues in nvme_dev_disable(). nvme_kill_queues() calls
revalidate_disk() and ends up waiting on the bd_mutex
resulting in a deadlock.

Allow the hung tasks a chance by unfreezing the queues after
setting dying bits on the queue, then call revalidate_disk()
to update the disk size.

NOTE: I've seen this race when the controller does not
respond to IOs or abort requests, but responds to other
commands and even signals it's ready after its reset,
but still drops IO. I've tested this by emulating the
behaviour in the driver.

Signed-off-by: Balbir Singh <sblbir@amzn.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b45f82d58be8..45b96c6ac2d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -103,10 +103,15 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	 */
 	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
-	revalidate_disk(ns->disk);
 	blk_set_queue_dying(ns->queue);
+	/*
+	 * Allow any pending udevd commands to be unblocked
+	 * so that revalidate_disk can then get bd_mutex
+	 */
+	blk_mq_unfreeze_queue(ns->queue);
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	blk_mq_unquiesce_queue(ns->queue);
+	revalidate_disk(ns->disk);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
-- 
2.16.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
