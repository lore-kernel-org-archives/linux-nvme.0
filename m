Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750D0C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwCWoUbL5NOMxoKe+miA4KKfb152pmD8DvI8jeZt5Ek=; b=G3nb2AGWMW3N+yGKrKt4fSXN5I
	/gdOoJXx0s78F5D8a9YnU6yNGgK1LgEMsm+al9v8CCZPoaxoT5RrKK639E42Il7XdcF59SwIX0s3X
	zQi+3DBEn12J28XN6heNUbvUIsUHD28G3fFYp1J1wi0FNlmCJXn57Y1TNjE+a7twCGYYqWu54rGbt
	/F8z2KMRpAZUXly4nXYieb+fsfv5LnkI+/21FbCUYH/hrWEp1pJ06dV5dTYV4v2METbbbE+DtU5zo
	2Uu9Jo8dEMWbGh81LPmXz53N38HPJawrU63Cm0cMTDnPok6BwOsYSIVBdTv72f3EEV65T7tqQeHbM
	fLAk9Plg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uErR0-0000000ClBL-051i;
	Tue, 13 May 2025 15:20:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uErDN-0000000CidD-2h6A
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 15:06:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3683543DC1;
	Tue, 13 May 2025 15:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1584C4CEE4;
	Tue, 13 May 2025 15:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747148801;
	bh=IEWcvGGDC3zFzhe0SXtlzqVdF3zefMDx9XgmylY0chs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRR+dm57R08V/1DhucUReGmapPRBaMe/lPNW2WeHW76PH22ZVWKZUbldpaI2+KGN+
	 5Q70+1lSp8VHd1JgZ/uJfy5QX9/D+YMC7nceluyUzG/VaD8nfyeL0xVaSogucQAVk0
	 oOa/YzVoi135GKNgnC7vcAaH2RxxB9f0Wu0EhvHS54TvCK51DpqUj8kOYNuPlpsLec
	 qjIGHFmENmPNH+ENL63yRtpBTHpLu70+fsV+NpwXNpbu2KFEyuW9suPo0daeDLBUXt
	 E5Ph0NKlXFH3sBmK/X6whmLl1kkFptQkY44weD//dCCOI7CvYUEUwWaJpxoaD2zYKM
	 YvkJEvnEFnTpw==
Date: Tue, 13 May 2025 09:06:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool
 allocations
Message-ID: <aCNf_rHaLdS-WTEO@kbusch-mbp>
References: <20250513070025.830930-1-hch@lst.de>
 <20250513070025.830930-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513070025.830930-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_080641_720409_1CF9610C 
X-CRM114-Status: GOOD (  12.63  )
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

On Tue, May 13, 2025 at 09:00:21AM +0200, Christoph Hellwig wrote:
> +static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
> +		struct nvme_iod *iod)
> +{
> +	if (iod->flags & IOD_SMALL_DESCRIPTOR)
> +		return nvmeq->descriptor_pools.small;
> +	return nvmeq->descriptor_pools.large;
> +}

...

>  		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
>  			__le64 *old_prp_list = prp_list;
> -			prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
> +
> +			prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod),
> +					GFP_ATOMIC, &prp_dma);

You could assume nvmeq->descriptor_pools.large here. We'd never use the
small pool if we've enough elements to chain lists, and it would skip
the extra condition branch on each loop.

The same optimization is done in the free side already, too.

