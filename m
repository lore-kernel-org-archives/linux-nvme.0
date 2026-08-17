Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41501C5DF7A
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 09:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2A5faBtUgHzzPD6wrMbjH32cegAZqV9Xrz9AleEZsrU=; b=A1ofZsE1kLFeufXqHQXx2CWnOc
	BldDzReRYcpBRcGL/YdxmXB9sJzd2YgMmLixQhC8H16J+fXjI/HPUxA04sQt4BdpC8o2U843C8PKK
	S5UEB3kZ8QuQmrssRCdfCL+s3Rc8Na7TFyAZEA/lg6v51EuKg7DNCg3lawIELRETHe7IlbmrAx677
	9T2GhpuSYqse9HJiR8iXBBQ+bgX39GCeeMJdEfRs09i1DhyYuoqOB9W4BAsmx75emzHT+HXY7Bks0
	GldzjyA7L5vFv4iUhkkc0IFkh8oTz82sIRxKjMFRsSrVPSAHMW+mTg5+Ce+qEtfA1/F12BY9+EpfQ
	aS2ELvjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvtUW-00000005nLt-3yLg;
	Mon, 17 Aug 2026 09:18:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvtUU-00000005nLJ-1EwO
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 09:18:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7928868D09; Mon, 17 Aug 2026 11:18:41 +0200 (CEST)
Date: Mon, 17 Aug 2026 11:18:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: dma_opt_mapping_size returns way too low sizes when using IOMMU
Message-ID: <20260817091840.GA26843@lst.de>
References: <20260817083654.GA23414@lst.de> <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_021846_500108_77CAB1C3 
X-CRM114-Status: GOOD (  23.75  )
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

On Mon, Aug 17, 2026 at 10:12:25AM +0100, John Garry wrote:
> On 17/08/2026 09:36, Christoph Hellwig wrote:
>> Hi all,
>>
>> I got reports that NVMe devices were arbitrarily limited to 128kiB
>> transfers in recent kernel. 
>
> How recent a kernel? This NVMe and DMA mapping code has not changed in 
> years as far as I know.

This was hardware QA moving from an old distro kernel to a "recent" (aka
still old) one.   But I've actually reproduced it locally on an
upstream kernel.  I guess most kernel developers or power users simply
do not run with IOMMU enabled.

>> Both the NVMe performance numbers and common sense suggest that this
>> is NOT the optimal DMA mapping granularity.  Can we pick a saner value
>> for iommu_dma_opt_mapping_size that does not restrict common I/O sizes?
>
> Note that SCSI does not use iommu_dma_opt_mapping_size() for clamping max 
> HW sectors, but instead sets opt size / max sectors from this value (so it 
> is not a hard limit there). Could we consider similar for NVMe?

We could consider that, but it would still reduce performane..

> The reason for which we have iommu_dma_opt_mapping_size() is that 
> performance can go through the floor we can't use the rcache for getting 
> the IOVA, i.e. we need to always alloc and dealloc an IOVA from the RB tree 
> for each mapping, and this can greatly reduce performance when the IOVA 
> space fills.
>
> If we increase IOVA_RANGE_CACHE_MAX_SIZE, then we just get caching of 
> larger IOVAs and I am not sure that is a great idea.

At least on the four different nvme devices I tested, the larger I/O
sizes made up for this.  But maybe the details depend on other
factors as well.

