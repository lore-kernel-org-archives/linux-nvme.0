Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92CDC3ABD8
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iuR9w9JNE+gkgJ8SjSzjmXhP1gZKXTtghyz68g/5250=; b=lKKjW3ci8lOwY/bHhtusJqX/Ly
	+bds/u0Mae6KG700ttbNUY31Rb0fKGjyrcp/qTge7h0KOE7+/ELhpEVmGyUHPGVQtTPDDBaT+dR/o
	a3RRV2WkRX4kXMeBBGQzGiTGMBTyhHqjAiW8t39qej5fQxdiETBqdiKPIcQNl5fn6UchU77I0fI/f
	dXE4Q27DoCsyavvNqYWmBGS4JZ62Pj+0l4RSLbNe/wlGj6VqlQyII8mAAdGTypFUR0vQKS6aL3QhV
	EcKenh/dK3u5bZbGsnspNHc3qky39pacEyT2t6bXj7MDCkTpLxhWX8BIYsmTPNDXzVdaQ2ANLs7GO
	Qy3h4/mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkFH-0000000BeBY-1Zwx;
	Tue, 13 May 2025 07:40:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkF2-0000000Be5K-2Jv0
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 07:39:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A58EA5C6626;
	Tue, 13 May 2025 07:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E16C4CEE4;
	Tue, 13 May 2025 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121995;
	bh=6pdKJKrYdu2YyhCUX2p2I8PVeh0MFH8F1Rz0854V520=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NX6dPPPWIPvXyHC4S13wXFZ3IRntFAfIB7r0Hrm14SDds82LHUmmayFaQ4+xWvjZW
	 +eDn2awbuINdylq8wABx3VylAAejoXqaOeYQ2sl3+LFRS6jthGDc2tcYHzRobmIBEc
	 aFctzHVjupKhLCme3q55occHJ8zcEC1b7uP2Mt5DwhMMREVK745x3LsVRz5f6aEfUD
	 u/5oOLWzgw8sKo9nIf/9/2Zy7ZhBPl5fIYOnUNrYvxDTLIKrwXmDWnM4K/JJXX6dq1
	 N1CW+RC+0AoFzBsfraYWyPfYCVIor0MJmdBYrmijGFEVYLKdFehaw4XsE0Om28b4gJ
	 32tGrc49jOlgA==
Date: Tue, 13 May 2025 10:39:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool
 allocations
Message-ID: <20250513073950.GJ22843@unreal>
References: <20250513070025.830930-1-hch@lst.de>
 <20250513070025.830930-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513070025.830930-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_003956_632191_0CCEE5F3 
X-CRM114-Status: GOOD (  14.95  )
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
> Add a separate flag to encode that the transfer is using the small
> page sized pool, and use a normal 0..n count for the number of
> descriptors.
> 
> Contains improvements and suggestions from Kanchan Joshi
> <joshi.k@samsung.com> and Leon Romanovsky <leonro@nvidia.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 82 ++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 43 deletions(-)

<...>

> -static void nvme_free_prps(struct nvme_queue *nvmeq, struct request *req)
> +static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
> +		struct nvme_iod *iod)
> +{

You probably want __always_inline and not inline here.


> +	if (iod->flags & IOD_SMALL_DESCRIPTOR)
> +		return nvmeq->descriptor_pools.small;
> +	return nvmeq->descriptor_pools.large;
> +}

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>

