Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F2CC5B552
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mWgQdkHUzeB22oLIuUDGj5tpqr2yZfTQXcDfxuuCr4Y=; b=ogpNmq5/RRcwmyzjbJMLWjvLXJ
	rWmUgfpiTg2Ssxg4ZVkb9ADU5/vPLcSk9vrYceLJSuyYfZDTwtvvEE8lr5j1H97ao+YSH+7qfS1A8
	NDEjrcbewGRuzJBGCnYY7Cbu+07YYzHEiNsC613zNAzi62+p0qZGGwyd56rAPiNajml6PefOzE67G
	X6yEnbhQV6QfGeHZoVp8Zp4nJ+WUg1MQ4VdVpUgnrlzukNHsdJKuOjMFor/APkVGM/HFIznfTQpTg
	RBQHFezUvY5OOAKmb0N2+ccISoF1cPUlMQiWd2r5cL0eo/UoaDYgG2fDjwdIL4wL1aZNimyPjx35M
	K/T95iQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP12Z-00000007L3z-0YkT;
	Tue, 10 Jun 2025 15:37:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOynb-00000006uxA-0RKG
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 13:13:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 24551629F0;
	Tue, 10 Jun 2025 13:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F364C4CEED;
	Tue, 10 Jun 2025 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561232;
	bh=BEKmVOJhz3jVgKIjJ4SjRW6f210g6LHQHx7qt6c4/hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HO6LupjrFqtua7wTLd53oFX1/vAPlI16Umc89yLJWaTZA/+4vXgANoaX0KoMRFQBR
	 8VMU7UMhcODsxnI5u357rZWbJCI7n9fymzDT3DzEEug7d0ONTSs0ax6KgaKjWfV7Ss
	 A8mSkSWIKQxfIg+7WXqsdgrEzwaC2nXEJ+6GcY0zMR3lix9/80It1MigwEDx5A92BY
	 eb4eqpTetUgK62WZQrWc+5tUIjNsBvE9BU9QFjYI9/60x6PVB3WFhrFhDqFhxYu8nH
	 fSzwjw3DmrSI4cMbWTWHGvLBwI2AIaaqM3Ns0tYYKX9PglDsOYgYwV/ylxHg3A2jRN
	 yK2B5ALlyVNFA==
Date: Tue, 10 Jun 2025 16:13:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme-pci: merge the simple PRP and SGL setup into a
 common helper
Message-ID: <20250610131348.GG10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-6-hch@lst.de>
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

On Tue, Jun 10, 2025 at 07:06:43AM +0200, Christoph Hellwig wrote:
> nvme_setup_prp_simple and nvme_setup_sgl_simple share a lot of logic.
> Merge them into a single helper that makes use of the previously added
> use_sgl tristate.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 77 +++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0b85c11d3c96..50bb1ebe6810 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -814,42 +814,41 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
>  	return BLK_STS_OK;
>  }

<...>

> -static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
> -		struct request *req, struct nvme_rw_command *cmnd,
> -		struct bio_vec *bv)
> +static blk_status_t nvme_pci_setup_data_simple(struct request *req,
> +		enum nvme_use_sgl use_sgl)

<...>

> +	if (!use_sgl && !prp_possible)

use_sgl  is tristate, the better check will be use_sgl == SGL_UNSUPPORTED.

Thanks

