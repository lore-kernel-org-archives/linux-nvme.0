Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87066CD4F24
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjXjWiW59YoU2C8Z2Rj/abbHQnEv6coBQ+ldcljw8OU=; b=xQhBsl1Eitqk7HgJigLvJCBYnC
	89An0L3ke/jPZDHye22UwvIlngzQildcEJ5W0zZTgNhyrolACd6pnI02x3f7JaTshOE7muvs/UCpF
	MxG1FrCoD7RMhYGXr2gR7VyiMWYMkzw2IHMLC1rl3j5b6DHD8md4K6zPLvyjktKRoRWYb8L8w4svQ
	h1e1HDEckYC6ChhTJJtIxD5DBIRWDBr5iiGQ2cJJV5s5qEgWK4y0Eg5AL/txAJzZAe9zj04VjGDUj
	U+nF+AdsywWvPebbHGCgps3Km13oTxOn3n7QF4ax7R94A/YlNJiC2NN1db/RNqKqtMeboNOCBBEqP
	9ouE2B1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slva2-00000005mof-2pxY;
	Wed, 04 Sep 2024 19:22:14 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slva0-00000005moE-0kFs
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 19:22:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A5BD0A4476B;
	Wed,  4 Sep 2024 19:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2A0C4CEC2;
	Wed,  4 Sep 2024 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725477730;
	bh=sceAbsf4cBBZOZbAKpGzZTUf52h60JowjehCwnIqG1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fI1eBRvGhF9hAsmAtAAmMteJfMpZyaJ4kr49SYXRT1vx272Q1ZmZxikJ9iJP/Egyx
	 6iML8HAzU/mqdnWrLX9om6IqMypv8RpicprrsHww4RPKwsc670WyXn5iiaeCltH/fT
	 c+le29MnZFCGlQPyvAP/t/ImIXGy60x8Lc2I6jbfnFkAewbNakK7Yow7pYSfRyoG8k
	 Oz1nI/7XEFUJrfluutTIoyiZBU/Up+TGAUoTpBrJGWNDrGg708j+3SJB/uvdWCEPz1
	 FuoQThlA9uBOIeJh1b2IpPBCsHy1aLktQLBhraP/DHchrK70+ialI7zzV2UT1Vw0Uf
	 cBNivju062EuQ==
Date: Wed, 4 Sep 2024 13:22:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH-part-2 8/9] nvme-pci: add support for sgl metadata
Message-ID: <ZtizXx9-7tJe9PuW@kbusch-mbp>
References: <20240904183818.713941-1-kbusch@meta.com>
 <20240904183818.713941-9-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904183818.713941-9-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_122212_298867_936B1155 
X-CRM114-Status: GOOD (  14.06  )
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

On Wed, Sep 04, 2024 at 11:38:16AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Supporting this mode allows merging requests with metadata that wouldn't
> be possible otherwise.

A couple minor issues from splitting/merging in-progress patches.

> @@ -1988,7 +1988,9 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
>  	lim->max_hw_sectors = ctrl->max_hw_sectors;
>  	lim->max_segments = min_t(u32, USHRT_MAX,
>  		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments));
> -	lim->max_integrity_segments = ctrl->max_integrity_segments;

This line was not supposed to be deleted. It should remain there as
before.

> +	if (lim->max_integrity_segments > 1 &&
> +	    !nvme_ctrl_meta_sgl_supported(ctrl))
> +		lim->max_integrity_segments = 1;

[snip]

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 7b2ae2e435447..87ea1673c60b8 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -388,6 +388,7 @@ enum {
>  	NVME_CTRL_CTRATT_PREDICTABLE_LAT	= 1 << 5,
>  	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	= 1 << 7,
>  	NVME_CTRL_CTRATT_UUID_LIST		= 1 << 9,
> +	NVME_CTRL_SGLS_MPTR                     = 1 << 18,

This shift should be 19, not 18.

