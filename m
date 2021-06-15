Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EFEC48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:29:03 +0000 (UTC)
X-Greylist: delayed 94 seconds by postgrey-1.34 at mail.kernel.org; Tue, 15 Jun 2021 14:29:03 UTC
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099036109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099036109D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PrA1K1aSLXuXRAuAqxWzsoc/HKoeruu7S5CPITfSpms=; b=1qHHXsmf3EhO/0
	Wtma1DRiGL+qfCIZs6mG3iplI3/PdQTCzETjp0VYpJa150KEav9M2RDEdHsiVGa08m/X7DkH1dAjn
	cO8RtPXvUA0bdnaXSbR1Rbxd2azeRdRe9BHInv2FfrT3PRXW6E8xFeWjj+srBqKOw2r7GGCJ+/JaF
	HetjkmyyjWWhzrWHbLuDAyYvzGeEubZy01UHPM5ivNQy6OFUq1IKYxkx+dJ/9NHyOOZ4qbjRfHI0R
	HsjqUvjXBWfAdfUY+F/ryqP+/P/ssFCUPGWtCexNgAzm/e3qdIcfE2LEqSKhvlbG3+Ns79s2PZwez
	t22aeVA9NiPuEnxLFEmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltA3C-000akU-Lb; Tue, 15 Jun 2021 14:28:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9Kq-000FmL-R4
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:42:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=kCJ45HeumX/2D3TeKCg4q9zYk3ZP/sAnAbbdW5UB8NE=; b=e1Jz0OaiVhkdkJ8uBfarnrj7cd
 RBnVvqoDILdPkewoYbrQAr2HnBx5DgYEHNeUWuJW/+bs3If3roWdV/m08dOcwqRj2RgFen3b8R8Ok
 /6oTHL0e8O33cUBZPXp/GZ4fkyBBr7SB0zo1eQcaI5S+71fCX/rmy9h6R916JMPXak+JV4QBojM6I
 PV8WQ1NPl+SVh+F0eHxN9pkXkqt2haB98Vn/uHOV7Gsao3xmN6dUUxYMXEGNaHcRtzHL0TnpDlQ4v
 my/uBsfP/VnDNN9Ymf+dtKNUwKyjzNr2gANiWHu64TbgamZtEU9Xuna1Sr4a33r4fmyeRcOLvUYnZ
 iwcAH9AQ==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt8ty-006nQh-Fr; Tue, 15 Jun 2021 13:14:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 15/16] nvme-multipath: set QUEUE_FLAG_NOWAIT
Date: Tue, 15 Jun 2021 15:10:33 +0200
Message-Id: <20210615131034.752623-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c1b4d627c05b..f77b774699de 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -449,6 +449,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 			ctrl->subsys->instance, head->instance);
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, head->disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, head->disk->queue);
+
 	/* set to a default value of 512 until the disk is validated */
 	blk_queue_logical_block_size(head->disk->queue, 512);
 	blk_set_stacking_limits(&head->disk->queue->limits);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
