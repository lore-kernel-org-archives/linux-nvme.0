Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76C9C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ELsm5LsFBJiyeaJxWaxPEmwQATZaO0XtqvWf4XvV0vw=; b=hg2FzMsAdhfxyzC81gJFjkq8nQ
	N6eRUpPxGUkoDVZeCtTUr1fgthFkeUltSO6tgKKgjkiqp48bY7yZmFZNfkuBspaZ64hraoSiwJZOU
	2YAaAlj36QiUXc4TNzm121iS0gu1yxiALig2SktcUi5JnJtPbk2OttDYcvAuesx8bKn7aW/BCoUVg
	Zu/1tZAFGb+C8gl8e5BPyEGIUwbnoNRHVU9T5NadPpWspOtB6S8ALahlIkJ7QOvD/e6B61X6waJ30
	5ami6n0+jZg9UU3o/sj43dcOqnkH8YI0z30Te+GLMDvEE8CBRaH/r0rLM+NVTk77dMNEhkldHyQji
	h8bHnndA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9Ox4-00AMnx-Aq; Sun, 25 Dec 2022 11:13:58 +0000
Received: from [88.128.92.76] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OJ6-00A2Z0-SZ; Sun, 25 Dec 2022 10:32:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@fb.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hugh Dickins <hughd@google.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] nvme: fix setting the queue depth in nvme_alloc_io_tag_set
Date: Sun, 25 Dec 2022 11:32:31 +0100
Message-Id: <20221225103234.226794-2-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221225103234.226794-1-hch@lst.de>
References: <20221225103234.226794-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

While the CAP.MQES field in NVMe is a 0s based filed with a natural one
off, we also need to account for the queue wrap condition and fix undo
the one off again in nvme_alloc_io_tag_set.  This was never properly
done by the fabrics drivers, but they don't seem to care because there
is no actual physical queue that can wrap around, but it became a
problem when converting over the PCIe driver.  Also add back the
BLK_MQ_MAX_DEPTH check that was lost in the same commit.

Fixes: 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e26b085a007aea..cda1361e6d4fbb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4897,7 +4897,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
-	set->queue_depth = ctrl->sqsize + 1;
+	set->queue_depth = min_t(unsigned, ctrl->sqsize, BLK_MQ_MAX_DEPTH - 1);
 	/*
 	 * Some Apple controllers requires tags to be unique across admin and
 	 * the (only) I/O queue, so reserve the first 32 tags of the I/O queue.
-- 
2.35.1


