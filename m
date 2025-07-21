Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6041C87FC5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atZZ8q263cRsUQx6GeEWbjoNpjB6kpeHSAoFBApe/RA=; b=VJBSuCWZlydyFoLNIz9yS4slO8
	iaZ1WugW5NGppSkXhK63upTD1wJ4zBhw0+q4kscrDU3wCGmiLx+3vTwogBJXofWraWN6vBoVj048S
	van8Jl3eW0EU6aiZtQbgoQeqBpUWvoKUYJVYod57tgknpV67GIoXr+h/cArz5CzDYtLBv4B52vVuX
	9ynWQYG2G39452ewK0EHGqKf0fBE/s4KtrwmaaE2hU/qcuEGyYmKwUQxwvhxwLOHe3BzCV4U1jA72
	0pgSxmJFvX7ifSYcKoo+4EoWeu3LawNHuawOhjhQedrqiHJ6NobEBuQtBsuU+cf/g2r1ZsAH4Tc6l
	XpYRKtng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udlJK-0000000GYba-2Bgo;
	Mon, 21 Jul 2025 07:51:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udlIY-0000000GYYK-0axe
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 07:50:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 806DB68B05; Mon, 21 Jul 2025 09:50:53 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:50:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 7/7] nvme: convert metadata mapping to dma iter
Message-ID: <20250721075053.GH32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-8-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_005058_320772_A655076A 
X-CRM114-Status: GOOD (  14.55  )
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

> +	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev,
> +						&iod->meta_dma_state, &iter))

Do the normal two-tab indent here to make this a bit more readable?

>  	if (entries == 1) {
> -		nvme_pci_sgl_set_data_sg(sg_list, sgl);
> +		iod->meta_total_len = iter.len;
> +		nvme_pci_sgl_set_data(sg_list, &iter);
> +		iod->nr_meta_descriptors = 0;

This should probably just set up the linear metadata pointer instead
of a single-segment SGL.

> +	if (!iod->nr_meta_descriptors) {
> +		dma_unmap_page(dma_dev, le64_to_cpu(sg_list->addr),
> +				le32_to_cpu(sg_list->length), dir);
> +		return;
> +	}
> +
> +	for (i = 1; i <= iod->nr_meta_descriptors; i++)
> +		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
> +				le32_to_cpu(sg_list[i].length), dir);
> +}

The use of nr_meta_descriptors is still incorrect here.  nr_descriptors
counts the number of descriptors we got from the dma pools, which
currently is always 1 for metadata SGLs.  The length of the SGL
descriptor simplify comes from le32_to_cpu(sg_list[0].length) divided
by the sgl entry size.


