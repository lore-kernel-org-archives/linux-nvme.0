Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300BECEACEF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XQ4VgzwgIlcEjz65gTjHXOXuWbLhqSCJf7wNX59uzBE=; b=UHdO8dXEhoPoehKSrqe36NPW1L
	LjC5DJdJJiEHYHyOR8HeNZ7sny9xbMgXQbWXFnAnpkVkE/QWTRV/c6LnZbecMF4ZGlf769rp/OUMC
	z6lbDHclHEPbGwlajHmBisTKS60aHNB6lWP0Rme+fETOkgdDPpoWq4QmSNc3CDTUhkzUmD4LxcsQ9
	N6wtkQF/t7AWHWesouz5+Yr3eZ8vDAHTTm2KWyDKnVpBwULrC4lkwUVSSDYb+9NikyQLONpDSuxCh
	NNJWEwg0fw44HkDBdnzYcUcCwuXzmdG9PJfYiTL6D1pBOYeEZR9tgPD144K7CGqimeDErC1+7+1/Z
	6wVezjeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL50s-0000000GlbG-2Boh;
	Mon, 17 Nov 2025 19:35:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL50q-0000000Glah-3Bwv
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 19:35:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 58CA64020F;
	Mon, 17 Nov 2025 19:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7C1C2BC9E;
	Mon, 17 Nov 2025 19:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763408143;
	bh=aYstDzOU6itMkIGh7zOf1T4EpGAvHxMXBR+DR3zss+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxXuRDPH0D9B/KbZiIuHuQ90VpbgFEGi+j7EmYkBgrLdjQ0tdi4xnvc7+/fiE/xnZ
	 2448UK7VlgSbw/az7lrSnq53ofNmRRismckpxSt/N3DUsNWQF1yi0P4ezfcAnnHeIb
	 PEHLrbJ7h3YTopCfSpv2i44PySDZMfrE73DqngCweLzgcahOGdFQo6sVJPraa7kK3K
	 Zt9B5/oKP1abb2ch2Q9Gjy0vgQHN0FTaWGiiYwelsltU37ZKkmKDyViFV/gtI9HhEE
	 CmH6BWHIFB1SRrBQpZxtMmWB2lZtmZTqqF2F+Hyk1cTOqDguWPC006IUZ8agTS5PrW
	 ioFNAADxoIkYQ==
Date: Mon, 17 Nov 2025 12:35:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <aRt5DPnMwzDw8_dF@kbusch-mbp>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_113544_815472_62352C5D 
X-CRM114-Status: GOOD (  12.24  )
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

On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e5ca8301bb8b..b61ec62b0ec6 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -290,14 +290,14 @@ struct nvme_iod {
>  	u8 flags;
>  	u8 nr_descriptors;
>  
> -	unsigned int total_len;
> +	size_t total_len;

Changing the generic phys_vec sounds fine, but the nvme driver has a 8MB
limitation on how large an IO can be, so I don't think the driver's
length needs to match the phys_vec type.

