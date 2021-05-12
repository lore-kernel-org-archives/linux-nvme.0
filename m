Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72A2C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:23:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7404B611CE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7404B611CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5A6l62FwsJs0SMTTPImr75STJoID2oMhE/RwIooeIrI=; b=GRdeDkJMJKHDWkuzbt8tVdGRB
	GMlNN+uIeX/t7/wOapeU/uqgMl1phv1SFGL0jQwtdtVDGFELnwTqDiVKQSEBUN287kXXf7tPf0855
	mpVepqVEtWSLcTm9ms7qa6gR8Tmx8a/0wID6yLptTNCXqRfMUuCKPBAQMetRFshFBNGWPl3W/lEcz
	9zBM8EX5ypvVEz1Zm17M+MYEB3shYQyhWjWrsLZb7V2/L9/OIyiqTWFCJ0Br1dVI3tL5oG3yTe5+V
	Wi+3SO1RmQ8rN4PfA+1T9A0f9pc0vUr3Wq6yPF5F3sxGvzZOyFqubsrU+yl/vU58CIuBCCASAqKxn
	pEcgI4gtw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgopt-002sun-Aq; Wed, 12 May 2021 13:23:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiy-002rf8-Bn
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 13:16:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ErQiIq/YOmz4YzZ4E99a6RCK5eOX97ipCw7O3ph9DFs=; b=EQDE4xee/RkNRgVsT4OjfS6yh4
 ruKZgSDj7EHjo6N4MP7LWp/Z9GNkxpGCZQagOyTBpNK12CkFqg/UD4nSmtRHwXqhoTHyfZWQfjqrG
 9RIThTi0y3AB2WXSIpC4Pxo2phhhm7maPm+Sz7SyDf/qEThHO0yp3Yzyz9nRoJwxtyzwxW1X5jmjI
 qYjVqfbcDOQ2G0SbOBvS4TZcn8XC1OieR6AfhLDuwFPtREuMWk+mP0Q++P/9WimijUU6cTLQWMNlt
 27CaKQKjdv+DIEv+3SBIQvq4dL2RhVoW20+2YmzNeAo7D7HmMMpXsGdsaFmngES4fNGG9wxTxJLVQ
 0ajtsp/g==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiw-00AO5j-FW; Wed, 12 May 2021 13:16:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 14/15] nvme-multipath: set QUEUE_FLAG_NOWAIT
Date: Wed, 12 May 2021 15:15:44 +0200
Message-Id: <20210512131545.495160-15-hch@lst.de>
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

The nvme multipathing code just dispatches bios to one of the blk-mq
based paths and never blocks on its own, so set QUEUE_FLAG_NOWAIT
to support REQ_NOWAIT bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74455960337b..516fe977606d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -445,6 +445,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (!q)
 		goto out;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
+
 	/* set to a default value for 512 until disk is validated */
 	blk_queue_logical_block_size(q, 512);
 	blk_set_stacking_limits(&q->limits);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
