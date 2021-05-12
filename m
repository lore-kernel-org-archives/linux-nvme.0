Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF45C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:25:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28674611CE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28674611CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wBlnnafg3KPP/+O3x3/ELs0vJsAo6p1QgahPxRNVcUA=; b=BJr+M8bHDD+iGlS2bAryMadvc
	pdhJZOka0QoLYdXwQH4IDnPHcDbgFc18HFMrrOKOKYbHjPg6pJgVv/k1RzfqNL9/8B6ibmJlC7Xz9
	X7UodenyFsQST3YFhqPoBlU8s0fyPSIP8JAFDcLCfClH58kIMzSrSm9cLHvH4K7n/wR0P5NDj9IBc
	OS7GnN2HWliweB0naBvVEQxKs/PE7cFKfdT4XcBj9n9v+701n4ZwGiNijx086/kBvxDiyeoZh72V1
	92cWqFoj39OLvc1ZFnst/CxQImYnYV6a7nHrIXRLIU1A5aZxXVx598t/pC42GesKhN3zCpNKrJ7t4
	wVb1Vu+Jg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgorZ-002t7S-JF; Wed, 12 May 2021 13:25:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoj0-002rfb-Tu
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 13:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=PWp5GWUmwMmy7IuWpaRzqy+L9+Y1AjYA6yCgQ3sSgvc=; b=2jgNoGGjA5FbUMdzUkhiNCq6jb
 HHfKQim1kGBM9+4BfRWrmSP3h25FiasH6VB90L6NmCxKViScIk5hhE04UYQuZadhutqUp4vVWDW0K
 Fy0nzzMpKioMcOpcy+POqPRJKZFz4pRsHvI5BpAdNA10B++WUBpjVmXWiuHKmnqvYJgtwgrsBgpNd
 /MTfVdk9EGC/ZsHo6CrKxCXbflgxVEuOmRg55odvGnENJ5LjsfjTFXPfA1BoS3udzmEeunXxs3xoJ
 hpfjNGlwnEzPjvxRrjw5GV/alRF4pEOg14uii636yafZGcytQRLmMmIps+K6S00czzfMlgebbcVVL
 LjEH9p6Q==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiz-00AO62-77; Wed, 12 May 2021 13:16:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 15/15] nvme-multipath: enable polled I/O
Date: Wed, 12 May 2021 15:15:45 +0200
Message-Id: <20210512131545.495160-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Set the poll queue flag to enable polling, given that the multipath
node just dispatches the bios to a lower queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 516fe977606d..e95b93655d06 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -446,6 +446,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		goto out;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
+	/*
+	 * This assumes all controllers that refer to a namespace either
+	 * support poll queues or not.  That is not a strict guarantee,
+	 * but if the assumption is wrong the effect is only suboptimal
+	 * performance but not correctness problem.
+	 */
+	if (ctrl->tagset->nr_maps > HCTX_TYPE_POLL &&
+	    ctrl->tagset->map[HCTX_TYPE_POLL].nr_queues)
+		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
 
 	/* set to a default value for 512 until disk is validated */
 	blk_queue_logical_block_size(q, 512);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
