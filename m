Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C547CC4363D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 04:28:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7C123A1E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 04:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mR0Ln8Mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7C123A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JyWnLzZf5mL4E8DylA5Hs9Y97O3rHJxMTHDYhI8xRrE=; b=mR0Ln8MuVbBMsrBBvf5P7X0CUq
	bK11JR4PyTdA9j/nzih1DMT7aT4C6d2OFC3Y8NFTCL5Xwz2DUPWZihn8JDz6JEmBIoVPuuWa79a9D
	oyAFax8bf07xTEDwfHZKlZGhTj6n/91n3F8tFqOKhyUjRXgloau2HKE8Wtz8L8mBx+AL9NdDmYF7c
	VHPVn6Cby2Un4WR7HC5BKucwuxp4k0Q6VIBHdmQHru5TiopqV9VZU2AZgTCV9kxsVmdStCFMDj15p
	Fqn0jrGrB+8s+7FrxaAbzdx4E17vbR3q+OF19zvk9vlIDP4EOsTcgqiypQH8OGsQPoDKr2rmlQg7m
	RHSg2AOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKZuo-0002np-Sw; Tue, 22 Sep 2020 04:28:30 +0000
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKZum-0002m2-2M
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 04:28:29 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0U9k6psd_1600748896; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0U9k6psd_1600748896) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 22 Sep 2020 12:28:17 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: axboe@fb.com,
	hch@lst.de
Subject: [RFC] nvme/pci: allocate separate interrupt for reserved non-polled
 IO queue
Date: Tue, 22 Sep 2020 12:28:16 +0800
Message-Id: <20200922042816.92192-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_002828_344308_EEF27591 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: joseph.qi@linux.alibaba.com, linux-nvme@lists.infradead.org,
 xiaoguang.wang@linux.alibaba.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

One queue will be reserved for non-polled IO when nvme.poll_queues is
greater or equal than the number of IO queues that the nvme controller
can provide. Currently the reserved queue for non-polled IO will reuse
the interrupt used by admin queue in this case, e.g, vector 0.

This can work and the performance may not be an issue since the admin
queue is used unfrequently. However this behaviour may be inconsistent
with that when nvme.poll_queues is smaller than the number of IO
queues available.

Thus allocate separate interrupt for this reserved queue, and thus make
the behaviour consistent.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 899d2f4d7ab6..ff3e28a8a9e0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2042,12 +2042,14 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 
 	/*
 	 * Poll queues don't need interrupts, but we need at least one IO
-	 * queue left over for non-polled IO.
+	 * queue left over for non-polled IO. Also one interrupt for admin
+	 * queue.
 	 */
 	this_p_queues = dev->nr_poll_queues;
 	if (this_p_queues >= nr_io_queues) {
 		this_p_queues = nr_io_queues - 1;
-		irq_queues = 1;
+		/* Allocate separate interrupt for reserved non-polled IO queue. */
+		irq_queues = 2;
 	} else {
 		irq_queues = nr_io_queues - this_p_queues + 1;
 	}
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
