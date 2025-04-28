Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91277C369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 20:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ilt5DUdHv+NQA0RqZ6cci7+KV9DKo6RxchNb+wWLKDo=; b=xujVccnBjJjId+pP1u/VAMZsvF
	WhuwQugcRHM1sDqB2Q/8pQhs+gyHlxeftKAcMSCZNy9HL56cViURl01GkxElKRaKPO0o8tKbq7vrl
	Qop45XQQb0+VP2UP0cWmRHNefQe2kpocFV8NkW7G25kIajT6MOsoyvqIQQiMGAkCIoietLM9eQI3i
	z30hFiNzEaT0LW35DlfW1ENfPo6CE+Iw7O3zUUay86nbkml0Z6sY4YGY5Rw1gnrXGXY+TCEZTzKIB
	K6ao8IDNBCpFammH363jVxh4aimQYS9UIkfWv0gTMzYc1BF9F9QYtkTH33qth1Dnvk336ZJXdxT9g
	iTb8J+TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9UqH-00000007QUs-49q2;
	Mon, 28 Apr 2025 20:12:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Rce-00000006yYn-2Qhm
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 16:46:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0FEC04AA85;
	Mon, 28 Apr 2025 16:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90AEC4CEEC;
	Mon, 28 Apr 2025 16:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745858784;
	bh=Z8PCmnJ0yV8qERDqeQfISVPvJ3tqJw2Q7aIBdlyPo/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tlk2eBunYES27PROXmHIGQe3zmMP6HvdTE2sKVLCxFcGCmH8DHxdGjHqd3wobjohg
	 VwJfw0ItrR32xKrcgdCW8TRpmdlk+DeJY1swcEr9VbaiBCu3yyJuag7MxpY9rcCj1j
	 8nTXrf6GECR+mLe+QAKunFydd77qXJZBtfWsqaoubYbzZfTupDTo+1dZCG4DPhnIKw
	 GE9ORFXi++TgAbviRRmsybWuVr08WLZvPsjcAv5o6bRpncDLzkKDP2jiGKorIc8UjF
	 OQmxqQxbREQlcM8XfaIRqR6lFGfo4bo5dy+E+StVFWQQTe6kZ8U9u+SSstYkVmXSTR
	 4chXnE6KS/Cag==
Date: Mon, 28 Apr 2025 10:46:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v10 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <aA-w20gOKus5hyAV@kbusch-mbp.dhcp.thefacebook.com>
References: <cover.1745831017.git.leon@kernel.org>
 <007e00134d49160d5edab94a72c35b7b91429b09.1745831017.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007e00134d49160d5edab94a72c35b7b91429b09.1745831017.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_094624_639637_80DEA0ED 
X-CRM114-Status: GOOD (  13.37  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 13:12:39 -0700
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

On Mon, Apr 28, 2025 at 12:22:29PM +0300, Leon Romanovsky wrote:
> +	do {
> +		if (WARN_ON_ONCE(mapped == entries)) {
> +			iter.status = BLK_STS_IOERR;
> +			break;
> +		}
> +		nvme_pci_sgl_set_data(&sg_list[mapped++], &iter);

I think this should say "++mapped" so that the data blocks start at
index 1 (continued below...)

> +		iod->total_len += iter.len;
> +	} while (blk_rq_dma_map_iter_next(req, dev->dev, &iod->dma_meta_state,
> +				 &iter));
>  
> -out_unmap_sg:
> -	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
> -out_free_sg:
> -	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
> -	return BLK_STS_RESOURCE;
> +	nvme_pci_sgl_set_seg(sg_list, sgl_dma, mapped);

because this here is setting sg_list index 0 to be the segment
descriptor.

And you also need to increment sgl_dma to point to the element after
sg_list, otherwise it's pointing right back to itself, creating a looped
list.

> +	if (unlikely(iter.status))
> +		nvme_unmap_metadata(dev, req);
> +	return iter.status;
>  }

