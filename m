Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF97ECAAD3
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Sep 2022 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kjdUm7Zas4EOzX2PTotuzTaNFY8GH8PLvM2npCp3dYc=; b=MIUU7sKewNv0qD3wnvjwu8JQZL
	vIlD5MKl7HqZrr++wsJ0wRU1y2zXEvPgHyTifhoCMI/suUlMcouOOhinP8klEljj6c+dAXP2p+KTD
	fpox4irO0frUBEHdkC/d96ClhPnRqWbs0z8pJoOL9gjrqanX/78H5hFVHoehPHJhjXgMDRBAMyfC2
	Duw0WxYexsgM6EEv3C6Ga3bgtDSWwhr6KCTy1UXfqM7UwNt1nNC6PceZpVbx6Qv1UGkXyixbp24qy
	GKr5CHBOCZcWzB3ghCns7eylAu+9DBh1cVfc4IGg48rw6/TCCzL/WZUnZjE4EF/UHVqU0H5S/MSQ8
	f2PSoMrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZasp-007GkV-Cf; Sat, 17 Sep 2022 16:41:35 +0000
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZask-007Gcu-3l
	for linux-nvme@lists.infradead.org; Sat, 17 Sep 2022 16:41:32 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQ.PTTI_1663432858;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQ.PTTI_1663432858)
          by smtp.aliyun-inc.com;
          Sun, 18 Sep 2022 00:41:21 +0800
From: Liu Song <liusong@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nvme: request remote is usually not involved for nvme devices
Date: Sun, 18 Sep 2022 00:40:58 +0800
Message-Id: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220917_094130_706793_C94A3117 
X-CRM114-Status: UNSURE (   7.98  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Liu Song <liusong@linux.alibaba.com>

NVMe devices usually have a 1:1 mapping between "ctx" and "hctx",
so when "nr_ctx" is equal to 1, there is no possibility of remote
request, so the corresponding process can be simplified.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 drivers/nvme/host/nvme.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 216acbe..cc21896 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -672,6 +672,10 @@ static inline bool nvme_try_complete_req(struct request *req, __le16 status,
 	nvme_should_fail(req);
 	if (unlikely(blk_should_fake_timeout(req->q)))
 		return true;
+	if (likely(req->mq_hctx->nr_ctx == 1)) {
+		WRITE_ONCE(req->state, MQ_RQ_COMPLETE);
+		return false;
+	}
 	return blk_mq_complete_request_remote(req);
 }
 
-- 
1.8.3.1


