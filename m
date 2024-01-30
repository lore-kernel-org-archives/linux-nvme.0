Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E79AC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BOoNApHOOtJ0mrkGTQBT3hJx0UgKVMb3d2cU6ueqIDI=; b=2OPgA3HuNoLvAl3UZMeG2Q1ttq
	ARKjBf6KKGVo/Ib3g6s/Ivlq6YkWTMXLwc4dbJsNJ8eXgz5zkWni4UJez0Y9fLpWAITfoa5o8ivbZ
	4C9/0c8a8EZQ+K78Cl+yEziUtJgnUrzXd5evk/c7KPvEIjoy0AIFT8OIW441Xx1pn0vW0g/I136+H
	WlC8eb6HUgOvij93Sr8fcva+WfylazzKPmuIUaFdJ0fjWAu2k3/5J9xhR9yw+OaidHwYkZwL/NIHF
	qZLlVtXsrIsGUQYKvjITidQtF8mNCXkxxk1lrAhTT6RoCUG/C3u6NjZQUuURa2qW6nGb/9FBcKOxC
	cobO4j6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUpJB-0000000H0XP-0p5E;
	Tue, 30 Jan 2024 14:41:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUpJ7-0000000H0Vu-3bBC
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 14:41:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE095227A87; Tue, 30 Jan 2024 15:41:44 +0100 (CET)
Date: Tue, 30 Jan 2024 15:41:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 03/14] block: add an API to atomically update queue
 limits
Message-ID: <20240130144144.GA32125@lst.de>
References: <20240128165813.3213508-1-hch@lst.de> <20240128165813.3213508-4-hch@lst.de> <c489e14c-aea7-4d76-88cd-f60026477c68@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c489e14c-aea7-4d76-88cd-f60026477c68@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_064150_087395_8914132E 
X-CRM114-Status: GOOD (  25.25  )
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

On Tue, Jan 30, 2024 at 11:46:24AM +0000, John Garry wrote:
>> +{
>> +	if (!lim->zoned) {
>> +		if (WARN_ON_ONCE(lim->max_open_zones) ||
>> +		    WARN_ON_ONCE(lim->max_active_zones) ||
>> +		    WARN_ON_ONCE(lim->zone_write_granularity) ||
>> +		    WARN_ON_ONCE(lim->max_zone_append_sectors))
>
> nit: some - like me - prefer {} for multi-line if statements, but that's 
> personal taste
>
>> +			return -EINVAL;

That would be really weird and contrary to the normal Linux style.

>> +	if (!lim->logical_block_size)
>> +		lim->logical_block_size = SECTOR_SIZE;
>> +	if (lim->physical_block_size < lim->logical_block_size)
>> +		lim->physical_block_size = lim->physical_block_size;
>
> I guess that should really be:
> lim->physical_block_size = lim->logical_block_size;

Thanks, that does need fixing.

>> +	lim->max_hw_sectors = round_down(lim->max_hw_sectors,
>> +			lim->logical_block_size >> SECTOR_SHIFT);
>> +
>> +	/*
>> +	 * The actual max_sectors value is a complex beast and also takes the
>> +	 * max_dev_sectors value (set by SCSI ULPs) and a user configurable
>> +	 * value into account.  The ->max_sectors value is always calculated
>> +	 * from these, so directly setting it won't have any effect.
>> +	 */
>> +	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
>> +				lim->max_dev_sectors);
>
> nit: maybe we should use a different variable for this for sake of clarity

What variable name would work better for you?

>> +	/*
>> +	 * We require drivers to at least do logical block aligned I/O, but
>> +	 * historically could not check for that due to the separate calls
>> +	 * to set the limits.  Once the transition is finished the check
>> +	 * below should be narrowed down to check the logical block size.
>> +	 */
>> +	if (!lim->dma_alignment)
>> +		lim->dma_alignment = SECTOR_SIZE - 1;
>
> It would be also nice to update blk_set_default_limits to use this (and not 
> '511') or also any other instances of hard-coding SECTOR_SIZE for 512

That would be nice, but defintively not in scope for this patch.


