Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C840EC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 02:49:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7FA2070C
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 02:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="juCYYcvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7FA2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ja3oOPQ70W4magqZYIAW1uD/35XjgjSjtLraipbibqw=; b=juCYYcvBxalCJDtUlfm8ne6rQR
	kFXUa1qDaF9EfzUnymoAsKg2xHRqZiwTCmzxXBdLba7oVQAvftwy9TBsOXqOr4a8Tp5vSGdPONnBe
	qCrVodHmiW/o3zRYhbrowNAfM56NFBRBTMZsz6xcV29/g341x/0fyho6S9c9kogXKnI9kIhTxMO3D
	ndI6teZQJzppuciQTCxmfRwVJo1ClXDGoH/hXdHdGvAEHVdszBF7bJLvYXxBLnkhDbY3yPcpQ86xy
	rxahI0bxM0vwHp5ofCEL/Gs8Q41Ntfkp2bPS45o2h7S/uZaNqanvpZdeQcD5uVu25Jb+FxCqaOvCC
	0ceddMsA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrBlz-00072S-1Q; Fri, 03 Jul 2020 02:49:55 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrBlx-00071H-08
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 02:49:53 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01422;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U1XMeTf_1593744587; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U1XMeTf_1593744587) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 03 Jul 2020 10:49:47 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 3/5] nvme-pci: Remove redundant segment validation
Date: Fri,  3 Jul 2020 10:49:22 +0800
Message-Id: <84ef8fd8eb4d7289fa92b5be12cc71eb1af46c5b.1593743937.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_224953_306570_276EB2ED 
X-CRM114-Status: UNSURE (   7.48  )
X-CRM114-Notice: Please train this message.
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
Cc: baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We've validated the segment counts before calling nvme_map_data(),
so there is no need to validate again in nvme_pci_use_sgls() only
called from nvme_map_data().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d0e9bbf..63bfb8b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -501,9 +501,6 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 	int nseg = blk_rq_nr_phys_segments(req);
 	unsigned int avg_seg_size;
 
-	if (nseg == 0)
-		return false;
-
 	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
 
 	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
