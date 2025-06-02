Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A9DC5B549
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 05:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2kxEPIoB8ki91Lb/1I8M98ge6TFfSpRzzcaIlvRvipY=; b=sLLXY2HNqn0TKHvLWd2Irj4d44
	yetB11MK0CRmsgt9hWxO+K07nzxl1WIjl/0kMzV2KLVKIaSQ7h6pbAi9NLpILczikR3PlDyOqvEaY
	Jc/G1I1KeWjXRpq3iawneDlLqDjlfT41FteMMToCN6UJY1KW25qvF+Cwz0xCiEcV7oLe9BCF+UBGt
	AkELYxBdGjJw5mXJqzvDG6xbaGLK3XZ7OQLw1XBmxylpecD5TX0vHs4We71B6ZphFmViUyy5ybBvA
	OzlBiE/zytSr75BOW2Q81gDvi7C8xHFm1EhmuGah4phm0AAKWyi+cHrJ75THu7jexi+xYI1qdXxOl
	7PtB02rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLy6b-00000006myB-1AnH;
	Mon, 02 Jun 2025 05:53:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLy6Y-00000006mxn-3s3l
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 05:53:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBF9968C7B; Mon,  2 Jun 2025 07:52:58 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:52:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [bug report]BUG: workqueue leaked atomic, lock or RCU:
 kworker/u67:3[365] observed from v6.15-rc7
Message-ID: <20250602055258.GA22318@lst.de>
References: <CAHj4cs93WutyoPLFMr0JidHhRAxHC1ZDcj-RvdnX=R7OaV5ejg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs93WutyoPLFMr0JidHhRAxHC1ZDcj-RvdnX=R7OaV5ejg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_225303_104737_123E0354 
X-CRM114-Status: GOOD (  14.44  )
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

On Thu, May 29, 2025 at 08:41:36PM +0800, Yi Zhang wrote:
> Hi
> 
> My regression test found this issue from v6.15-rc7, please help check
> it and let me know if you need any infor/test for it, thanks.

Hi Zi,

The new code seems to be missing a queue_limits_cancel_update,
the patch below fies it.  But what kind of devices is this?
PCIe muti-controller subsystems aren't that command, and this
looks like a grave bug, combined with the I/O page fault that
looks really odd.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f69a232a000a..4bb3c68b3451 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2388,6 +2388,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	 * atomic write capabilities.
 	 */
 	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
+		queue_limits_cancel_update(ns->disk->queue);
 		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
 		ret = -ENXIO;
 		goto out;

