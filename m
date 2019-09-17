Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E87C4CECD
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 22:41:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27B220678
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 22:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QNDHsWcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27B220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amzn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Nq93LwxjLtzAlFBoHSPzj30bqKeLOBrUTDM8PYterEo=; b=QNDHsWcvo7Sn1q
	zRu/AmVSHR6FFsz6wm2SbZmWNZbjQYnCKBfb0Ck2RoCWUqhFqG/AImtbG63pUXgMLHH/a7Hn+BbSx
	VMvzLa3xCJAdic7ynkvgggxCaBT8nu22MGh8ugJgmfpzigOdrITNoph8B7UD7Tf7zZvfEdcv70HJW
	/iq/ORXNAK4fh437+1uqVJKk8ahyZLFi1cfS43Fad0tipqfBMylu1703nPv4kPL4dXRbaUxY3Fx1G
	IJpcFW2TyjdY8+uP3ow3rmSWt2/35/RR0MWOX0efPV7mH9PRU7wr1GaYN0ybgiKk1B+tqQ1EVe8BV
	m8ccsYFFhozKxc0UWX8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAMA8-0000eB-D0; Tue, 17 Sep 2019 22:41:32 +0000
Received: from smtp-fw-4101.amazon.com ([72.21.198.25])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAM9x-0000XW-Gp
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 22:41:23 +0000
X-IronPort-AV: E=Sophos;i="5.64,518,1559520000"; d="scan'208";a="785466982"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 17 Sep 2019 22:41:10 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS
 id AE9A6A262E; Tue, 17 Sep 2019 22:41:09 +0000 (UTC)
Received: from EX13D32UWB004.ant.amazon.com (10.43.161.36) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Sep 2019 22:41:08 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D32UWB004.ant.amazon.com (10.43.161.36) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Sep 2019 22:41:08 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 17 Sep 2019 22:41:08 +0000
From: Balbir Singh <sblbir@amzn.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v3 1/2] nvme/host/pci: Fix a race in controller removal
Date: Tue, 17 Sep 2019 22:41:04 +0000
Message-ID: <20190917224105.6758-1-sblbir@amzn.com>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_154121_689027_9940C38F 
X-CRM114-Status: GOOD (  12.90  )
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

Changelog v3
  1. Simplify the comment about moving revalidate_disk
Changelog v2
  1. Rely on blk_set_queue_dying to do the wake_all()

 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b45f82d58be8..6ad1f1df9e44 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -103,10 +103,13 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	 */
 	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
-	revalidate_disk(ns->disk);
 	blk_set_queue_dying(ns->queue);
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	blk_mq_unquiesce_queue(ns->queue);
+	/*
+	 * Revalidate after unblocking dispatchers that may be holding bd_butex
+	 */
+	revalidate_disk(ns->disk);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
-- 
2.16.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
