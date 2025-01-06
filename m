Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCC0E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 08:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lNjq4iKoZ4o+i2xaOEQZdyoNczcfdieJhaoAyZ/hMSE=; b=BxFxoXvI90v+ypYJI8YV6a1pmf
	cpW8XLstTThCJQoSdOtb1ykYuTcK27IofQRVY1X2lOMn51nyrNOzdXU45tAWCDp6wWl4siIFYHaX6
	Y6Tktej72HkcPR7EaaYP70fBMhfjSIynch6AG7K9agv44NEC8pAtL9/fo+AKVTfsw/Qwzg+SdnmGt
	S+tU4mauETWlIKzF8aCv4TeK+Fzqwga7gFhuUkeCpnup9Qkc3QHkHyiAbobz2lPiWKkiVYXnAQlus
	t2E5TFdB/X981m5bopF1Rfz5fijf+0AO0m3bSPNpCXFNv7tAboT068Kj4BZHrdfq6TjgFydmzIRj2
	x2iNDADA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiWQ-00000000W8m-3BX5;
	Mon, 06 Jan 2025 08:31:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiV9-00000000Vtq-0jZr
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 08:30:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9E3E68C7B; Mon,  6 Jan 2025 09:30:15 +0100 (CET)
Date: Mon, 6 Jan 2025 09:30:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 2/3] block: Fix __blk_mq_update_nr_hw_queues() queue
 freeze and limits lock order
Message-ID: <20250106083014.GD18408@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-3-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104132522.247376-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_003019_364425_A42CD8CA 
X-CRM114-Status: GOOD (  16.45  )
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

On Sat, Jan 04, 2025 at 10:25:21PM +0900, Damien Le Moal wrote:
> __blk_mq_update_nr_hw_queues() freezes a device queues during operation,
> which also includes updating the BLK_FEAT_POLL feature flag for the
> device queues using queue_limits_start_update() and
> queue_limits_commit_update(). This call order thus creates an invalid
> ordering of a queue freeze and queue limit locking which can lead to a
> deadlock when the device driver must issue commands to probe the device
> when revalidating its limits.
> 
> Avoid this issue by moving the update of the BLK_FEAT_POLL feature flag
> out of the main queue remapping loop to the end of
> __blk_mq_update_nr_hw_queues(), after the device queues have been
> unfrozen.

What happens if I/O is queued after the unfreeze, but before clearing
the poll flag?


