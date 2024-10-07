Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63A3CFB442
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 06:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RYuO/t+hbcLOJ6s2wjPfeA3W9COOd6aAHQcoGgJ0MUA=; b=pHoRdf6JUWSlata8Wy6mHegLz/
	PjbwfLuhMvNoK3YxOoBJ8FGd2M6y4xdNP7729Flul2wsMMD9zfc9z/eSjShw/zqFwpLhUcxNpacgu
	0paRR/vSoE3qzSn36lwntjrSuoDX4vxEH13Ak17IrbNe6Qw22c0eR0afi3inENlbb1+Zvy7eCXLL2
	tc8jZJK0dRtV7Nmv3fgcds9RCm/uHMa3DhJRmYRIhtQ6jcKpFnjCMTE0DqmAgfvrqPYH3aQv/PraM
	1jYV0DIH9Fd/+bKnllxratvVO4z48iI+G1p8KNLVAM+XzDzInJeH4koPWIOju48AF21g56KVO2aGR
	TvRTPFNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhSZ-00000001Tmu-3WBk;
	Mon, 07 Oct 2024 06:43:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhRK-00000001TQn-3q00
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 06:41:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB880227AA8; Mon,  7 Oct 2024 08:41:49 +0200 (CEST)
Date: Mon, 7 Oct 2024 08:41:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH 2/2] nvme: make keep-alive synchronous operation
Message-ID: <20241007064149.GB1141@lst.de>
References: <20241004114711.780809-1-nilay@linux.ibm.com> <20241004114711.780809-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004114711.780809-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241006_234155_419678_F3D2EF99 
X-CRM114-Status: GOOD (  15.79  )
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

On Fri, Oct 04, 2024 at 05:16:57PM +0530, Nilay Shroff wrote:
> The nvme keep-alive operation, which executes at a periodic interval,
> could potentially sneak in while shutting down a fabric controller.
> This may lead to a race between the fabric controller admin queue
> destroy code path (while shutting down controller) and the blk-mq
> hw/hctx queuing from the keep-alive thread.
> 
> This fix helps avoid race by implementing keep-alive as a synchronous
> operation so that admin queue-usage ref counter is decremented only
> after keep-alive command finish execution and returns its status.

With that you mean ->q_usage_counter?

Moving to synchronous submission and wasting a workqueue context for
that is a bit sad.  I think just removing the blk_mq_free_request call
from nvme_keep_alive_finish and returning RQ_END_IO_FREE instead
should have the same effect, or am I missing something?

> Also, while we are at it, instead of first acquiring ctrl lock and then
> accessing NVMe controller state, lets use the helper function
> nvme_ctrl_state() in nvme_keep_alive_end_io() and get rid of the
> lock.

Please split that into a separate patch.


