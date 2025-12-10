Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F09D3C526
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 04:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GCZAAt6EkUUdnOT2sO3HQHmBs52vyjIfpb5nx6ZnXVc=; b=Hsbx8T8ADS3TMmj7laTM3XUawa
	30m2hVh3YJTrFzh/Pc5EFdGvJ93dmvaC0fVZ2ahO+1ACk9nh8uKv5ntgiRfKklO8aFNlbsZonAo2C
	GwTP03Jnl6W/nvd/Uyt8BSabPI1EZ62LzTF7o0RYfL3eZu6vgKefPSZeQ1Px48O4LKcEmnvRkVx3M
	ZptRAYVUpEylIf+A4j6aA7Ykg40BnVKd2ge9JryvAVamsf7t5o1/dAUjecqQ/Ti5dtAV+0+Dagv3+
	u7WKn1ONErKTkEhowy81EMLaXaQMsN9LRuZaMcF8owCpnZ6MzlIdkMPPCkkaupPAzyljHNJuVO6RF
	+IZprazA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTBSV-0000000F5D8-3aE6;
	Wed, 10 Dec 2025 04:05:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTBST-0000000F5CY-3SGZ
	for linux-nvme@lists.infradead.org;
	Wed, 10 Dec 2025 04:05:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 34E4D4448E;
	Wed, 10 Dec 2025 04:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D2CC116B1;
	Wed, 10 Dec 2025 04:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765339545;
	bh=DDXeGI3PrVCWYn4HgWXYJxRFC7N8vlabUufE9+1W1hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3gYJbMVRCC87PmUQ02vWB+jUJdMU6wSQL3EWDlwZ4hdXkL6y1EW8vSd8b3I22MwD
	 gb/M6kjjt6Z9jA/SkjKVeTwpYzLNdGiAE9BPpVMBReng9K00FrH3PjJIyb2NM/3Lah
	 pmCklcpqHMPc76RFgxZjYIk6WdFDg6qMOUc0bZih+0piHrJIw5UQ7ItfiGMiROwq+m
	 tsHBinhfxt3Fz1ONr9RZTxbhlBb5TYB1s9avApO0Cm8OhTGt1VNzZBthCyKd6Rnslu
	 Oj0Gd8RQBNPjiaZwH+Zu3Eiy59RKsabggSdbwLMy2w9vXNsHe552FCZ64BDnuX98kd
	 NF+OXmPBOsyIQ==
Date: Wed, 10 Dec 2025 13:05:41 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sebastian Ott <sebott@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Will Deacon <will@kernel.org>, Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
Message-ID: <aTjxleV96jE3PIBh@kbusch-mbp>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com>
 <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com>
 <99e12a04-d23f-f9e7-b02e-770e0012a794@redhat.com>
 <30ae8fc4-94ff-4467-835e-28b4a4dfcd8f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ae8fc4-94ff-4467-835e-28b4a4dfcd8f@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_200545_881253_8CBD51EF 
X-CRM114-Status: GOOD (  16.08  )
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

On Wed, Dec 10, 2025 at 02:30:50AM +0000, Chaitanya Kulkarni wrote:
> @@ -126,17 +126,26 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
>   		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
>   				vec->len, dir, attrs);
>   		if (error)
> -			break;
> +			goto out_unlink;
>   		mapped += vec->len;
>   	} while (blk_map_iter_next(req, &iter->iter, vec));
>   
>   	error = dma_iova_sync(dma_dev, state, 0, mapped);
> -	if (error) {
> -		iter->status = errno_to_blk_status(error);
> -		return false;
> -	}
> +	if (error)
> +		goto out_unlink;
>   
>   	return true;
> +
> +out_unlink:
> +	/*
> +	 * Unlink any partial mapping to avoid unmap mismatch later.
> +	 * If we mapped some bytes but not all, we must clean up now
> +	 * to prevent attempting to unmap more than was actually mapped.
> +	 */
> +	if (mapped)
> +		dma_iova_unlink(dma_dev, state, 0, mapped, dir, attrs);
> +	iter->status = errno_to_blk_status(error);
> +	return false;
>   }

It does look like a bug to continue on when dma_iova_link() fails as the
caller thinks the entire mapping was successful, but I think you also
need to call dma_iova_free() to undo the earlier dma_iova_try_alloc(),
otherwise iova space is leaked.

I'm a bit doubtful this error condition was hit though: this sequence
is largely the same as it was in v6.18 before the regression. The only
difference since then should just be for handling P2P DMA across a host
bridge, which I don't think applies to the reported bug since that's a
pretty unusual thing to do.

