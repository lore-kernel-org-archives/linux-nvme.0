Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34057C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jzIEFp92Qwvzs+HVtoyiopqNf/QJIcsXZA6HBGfKMb8=; b=msKTOJs3mm29yJM0CW2DLzVJ2i
	uUuRMLg62VI1+YvtDKj8BXpas+I+d8clAgy/sHMJE+2aFWnqxcnIy9x83WuMFOc50liW57cXzSlAQ
	VoYEqnL/Uw5BAtJ5VoRDWsXUx/5LXUi8PMPBbgXdZMpQX7qzq24Xo5bmzvIMIYHi+R0tOnxqYOLyx
	us6CMcNF4oRIBlmVsg5d2aZQdnBPIj78fes+28Vg99VS69FtHnjKsNWOcWstBZzFPkBYoOAlmYAs9
	S0SBDojxaZGbzaLdHTEp3BgKRJ8ilkmarD5pEo2e68l+AbZBTK6cvDTDpV/FrF4h/DGIG28VpMoeq
	tbQLpqVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxSTj-009AhP-Js; Tue, 22 Nov 2022 12:34:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxSTd-009AaX-WC
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 12:34:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 884FA68D05; Tue, 22 Nov 2022 13:34:09 +0100 (CET)
Date: Tue, 22 Nov 2022 13:34:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, lengchao@huawei.com,
	linux-nvme@lists.infradead.org, Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Message-ID: <20221122123409.GA5958@lst.de>
References: <20221116072711.1903536-1-hch@lst.de> <e5de54b2-4906-9902-c150-732718a77571@grimberg.me> <20221116132225.GA8071@lst.de> <1ee364d8-4aef-acf6-1cf9-38787ddac288@grimberg.me> <20221116132805.GA8496@lst.de> <2b6bae87-b008-6f8d-3c70-2334b5bd48b7@grimberg.me> <20221122123154.GA5610@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122123154.GA5610@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_043414_214203_85AD1740 
X-CRM114-Status: GOOD (  19.84  )
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

On Tue, Nov 22, 2022 at 01:31:54PM +0100, Christoph Hellwig wrote:
> This would be the queue_count version.  I have to say I much prefer
> the tagset check, as it is self-documenting and matches what
> nvme_queue_scan, nvme_cancel_tagset and nvme_cancel_admin_tagset
> do.

And here is the actual patch:

---
From 167d14d9613014142ee285c2912dadc089d80e86 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 16 Nov 2022 08:14:46 +0100
Subject: nvme: don't call blk_mq_{,un}quiesce_tagset when ctrl->tagset is NULL

The NVMe drivers support a mode where no tagset is allocated for the I/O
queues and only the admin queue is usable.  In that case
ctrl->queue_count is smaller than two and we must not call the block
per-tagset quiesce helpers that dereference it.

Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
Reported-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3195ae17df309..6c8a110d6738a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5215,6 +5215,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl)
 {
+	if (ctrl->queue_count < 2)
+		return;
 	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
 		blk_mq_quiesce_tagset(ctrl->tagset);
 	else
@@ -5224,6 +5226,8 @@ EXPORT_SYMBOL_GPL(nvme_quiesce_io_queues);
 
 void nvme_unquiesce_io_queues(struct nvme_ctrl *ctrl)
 {
+	if (ctrl->queue_count < 2)
+		return;
 	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
 		blk_mq_unquiesce_tagset(ctrl->tagset);
 }
-- 
2.30.2


