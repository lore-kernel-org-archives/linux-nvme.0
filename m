Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF458C5DF85
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sZHsJhEgKu+WGFTQtC/QHCajGGiZjDZqMo9SluRfuRI=; b=hQLx6wm834YCtbf2joo1a8lL6u
	8K2+dXs/YxO3bVR8bs/vVRUscyjoCfwlS+uxr3xObXv+PQZhlTING4WYvS7+EKwEYpvDFq0ITubFx
	jynL15IHMkydSdOv1SoyTKHIAC2mhzd1hFOgrLcas35ANGPDib/JS7ykOcNGc+c9aWTTKufDVxsJQ
	vUSQsXd6tULkAE0KnGKa9zL5bVOkUiDlDShFvAfeHGzviogB+nLiw2u5MWSzwOCQCHo9DnXgXJhMB
	rIcCahc5aFmgtyUce8IanRxH/1Rwz2Glnj5roDNIIfRU60fSngbNVlAOiBIUY61rChdVQ4+ULVe8u
	cN+u5AqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwc1R-00000009LHG-37Zy;
	Wed, 19 Aug 2026 08:51:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwc1O-00000009LGa-3VK8
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 08:51:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 922DE68C7B; Wed, 19 Aug 2026 10:51:37 +0200 (CEST)
Date: Wed, 19 Aug 2026 10:51:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: dma_opt_mapping_size returns way too low sizes when using IOMMU
Message-ID: <20260819085137.GA8550@lst.de>
References: <20260817083654.GA23414@lst.de> <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com> <20260817091840.GA26843@lst.de> <8b7e86a7-6cb1-4007-bd99-1c4be8e6828e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7e86a7-6cb1-4007-bd99-1c4be8e6828e@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_015143_083740_6399C2A5 
X-CRM114-Status: GOOD (  16.00  )
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

On Mon, Aug 17, 2026 at 11:11:43AM +0100, John Garry wrote:
>> At least on the four different nvme devices I tested, the larger I/O
>> sizes made up for this.  But maybe the details depend on other
>> factors as well.
> Are you saying that you tried increasing IOVA_RANGE_CACHE_MAX_SIZE and got 
> better performance?

No, just disabling this hint.

> As I remember, I was told that the value of 6 for IOVA_RANGE_CACHE_MAX_SIZE 
> was originally chosen from the value then in max page order, i.e. the idea 
> was that we should not be getting streaming IOs larger than that value. But 
> in looking at lore, 8 was very originally proposed, but I can't see any 
> discussion on why that changed or any relation to page max order.

But that's a bit weird.  A bio already does up to 256 entries, and a
request can have many more.


