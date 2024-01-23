Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFA1C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 08:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+jpT77/Y7heo+XD38l9ZdbKR2TgCkqm1NIS2ypX7yMI=; b=RPEGnIW7cNZ823s8R6yEO8fvua
	oroPvQYgM+KcVdcBsyfBNvx7ap6tyy2hEx8T+q+GRFQmwolAcdvvEuCZ464ilijEX40iiZF4NcRHV
	5Z/bWgiDyAbRimc8wRA69JzKAwj8+jUmQcLc9JEwNw76rYWJwN0TeJXB5s9U56tbBN9obryBkTR57
	vKfV127Ml2FbP7nrgqgzV7smQmwST5ZOj3EK1zd83C+DeUbJaWShesNNoYMM78p9z81vB4pGKJilF
	xFU+t7qR8jFRIPWRNFmRPXh+sSX0rIctyowmHpGRwvN44qBds0gk6XqeOd9/fjaTY543fAQw3NbeG
	AjyWc8NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCOu-00FcGA-0a;
	Tue, 23 Jan 2024 08:44:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCOr-00FcFG-2h
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 08:44:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D8F268BEB; Tue, 23 Jan 2024 09:44:49 +0100 (CET)
Date: Tue, 23 Jan 2024 09:44:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 03/15] block: add an API to atomically update queue
 limits
Message-ID: <20240123084449.GB29041@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-4-hch@lst.de> <01765807-d010-422b-97a6-3171265f36be@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01765807-d010-422b-97a6-3171265f36be@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_004454_016665_C162ED15 
X-CRM114-Status: GOOD (  25.09  )
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

On Tue, Jan 23, 2024 at 01:50:32PM +0900, Damien Le Moal wrote:
> > +			return -EINVAL;
> > +		return 0;
> > +	}
> > +
> > +	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED)))
> > +		return -EINVAL;
> > +
> > +	if (lim->zone_write_granularity < lim->logical_block_size)
> > +		lim->zone_write_granularity = lim->logical_block_size;
> 
> This check and change needs to be against the physical block size. Otherwise,
> SMR drives will choke on it.

It probably should, but this mirrors what is done in
blk_queue_zone_write_granularity.  And I want to match that behavior
at least for now, we can then improve and document it once this is
the only interface to validate the limits.

> > +
> > +	if (lim->max_zone_append_sectors) {
> > +		if (WARN_ON_ONCE(!lim->chunk_sectors))
> > +			return -EINVAL;
> 
> chunk_sectors is the zone size. So we should probably check that it is set after
> the IS_ENABLED() check earlier in the function, no ?

Possibly.  In fact I'm wondering where the check comes from, as we
don't seem to have it in the existing helpers.

> > +	if (!lim->logical_block_size)
> > +		lim->logical_block_size = SECTOR_SIZE;
> > +
> > +	if (!lim->physical_block_size)
> > +		lim->physical_block_size = SECTOR_SIZE;
> > +	if (lim->physical_block_size < lim->logical_block_size)
> > +		lim->physical_block_size = lim->physical_block_size;
> > +
> > +	if (!lim->io_min)
> > +		lim->io_min = SECTOR_SIZE;
> 
> This should be lim->logical_block_size, no ?

This comes from the default in blk_set_default_limits.

> 
> > +	if (lim->io_min < lim->physical_block_size)
> > +		lim->io_min = lim->physical_block_size;
> 
> But then given that log <= phys, you could set io_min to physical_block_size if
> it is not set.

Which is what we do here, so the above is actually redundant and
can be removed.

> > +	if (!lim->max_hw_sectors)
> > +		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
> > +	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SIZE / SECTOR_SIZE))
> 
> You can use PAGE_SECTORS here.

Yes.

