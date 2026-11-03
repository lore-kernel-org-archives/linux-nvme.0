Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD1606A329
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RD6UYclb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YevSWmFUcJ2wzo7vC146AR0Kx9hT5U+yf6eoXtDYLM4=; b=RD6UYclbRxQdw/CQ6xB6Ii61KY
	dn1utQxpLrO867xqOXwzUVbti7qpYJCwTFR1UlEG0WS4SAI6gUwwttPKWVohmKZRA8zqCPCV5t2bM
	Ht8Dh5zcKvUw0zXHi2lNxFK6Zyj786aZiwbf7aoRDcR9tnZG34xF7JyYsq40JpVOGEmzWT9vLN72X
	Yp3bhsilIYlnFY1nipZT0lNVLlEeHRewN0JZAXChnSlZRHoA8WKSTPwZzjon2KZOTGVS17cRh4lRB
	PA8iynJC5jKob+OiPiIoVYLH02FxAKJHzkrx5uGf+YW2lCxMzpyz8ymLppbkswwHKwIpzUFJKrHdM
	P8mZfi1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9NZ-00000001Sc1-10Jc;
	Tue, 03 Nov 2026 07:56:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9NV-00000001Sba-3kFX
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 07:56:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5573068AFE; Tue,  3 Nov 2026 08:56:17 +0100 (CET)
Date: Tue, 3 Nov 2026 08:56:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hugo Deco <hugodeco@sufficit.com.br>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, Andres Freund <andres@anarazel.de>
Subject: Re: [PATCH] nvme: add NO_FUA quirk for ADATA XPG GAMMIX S70 BLADE
Message-ID: <20261103075617.GA3882@lst.de>
References: <CAGFVba_mDRomduXFV5HugBvb9sKhNzdhgDvkCvUvcdOhy4ri4Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGFVba_mDRomduXFV5HugBvb9sKhNzdhgDvkCvUvcdOhy4ri4Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_235622_231762_9BAEF618 
X-CRM114-Status: GOOD (  27.90  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 08:21:25AM -0700, Hugo Deco wrote:
> On the ADATA XPG GAMMIX S70 BLADE (PCI 1cc1:5370, firmware 03020P5E)
> every Write with the FUA bit set takes 200, 400 or 600 ms to complete,
> always a multiple of ~200 ms, while a plain Write completes in
> 0.0-0.4 ms and a Flush in ~1.3 ms. Tracing nvme_setup_cmd and
> nvme_complete_rq shows the whole delay is between submission and
> completion, i.e. inside the device (e.g. FUA write, control 0x4000:
> 598.3 ms).
> 
> Because ext4/jbd2 issue FUA for every journal commit, fsync() on this
> drive stalls for 250-890 ms and desktop applications freeze.
> 
> Add NVME_QUIRK_NO_FUA, which stops advertising BLK_FEAT_FUA while
> keeping the volatile write cache enabled, so the block layer emulates
> FUA with a Write followed by a Flush. Durability semantics are
> unchanged.
> 
> With the quirk applied, 4 KiB O_DIRECT|O_DSYNC writes and
> create+write+fsync drop from 250-890 ms to a 0.82-0.85 ms median
> (30 samples, two partitions on the same drive).

No a huge fan of adding these quirks, but the results are pretty massiv.
Andres also saw FUA slowdowns on various Samsung devices, which got
lost.  Maybe we should add those as well?

> 
> Signed-off-by: Hugo Deco <hugodeco@sufficit.com.br>
> ---
>  drivers/nvme/host/core.c | 11 +++++++++++
>  drivers/nvme/host/nvme.h |  8 ++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7eb0f9f..5c0d74d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2477,6 +2477,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  		lim.features |= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
>  	else
>  		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
> +	if (ns->ctrl->quirks & NVME_QUIRK_NO_FUA)
> +		lim.features &= ~BLK_FEAT_FUA;
> 
>  	if (info->is_rotational)
>  		lim.features |= BLK_FEAT_ROTATIONAL;
> @@ -3090,6 +3092,15 @@ struct nvme_core_quirk_entry {
>  };
> 
>  static const struct nvme_core_quirk_entry core_quirks[] = {
> +	{
> +		/*
> +		 * ADATA XPG GAMMIX S70 BLADE (fw 03020P5E) takes 200-600 ms
> +		 * to complete FUA writes while Flush takes ~1.3 ms.
> +		 */
> +		.vid = 0x1cc1,
> +		.mn = "XPG GAMMIX S70 BLADE",
> +		.quirks = NVME_QUIRK_NO_FUA,
> +	},
>  	{
>  		/*
>  		 * This Toshiba device seems to die using any APST states.  See:
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a643c47..2128b40 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -183,6 +183,12 @@ enum nvme_quirks {
>  	 * Admin queue DMA buffers must be page aligned
>  	 */
>  	NVME_QUIRK_ADMIN_PAGE_ALIGN		= (1 << 23),
> +
> +	/*
> +	 * The device is extremely slow on FUA writes but fast on Flush;
> +	 * do not advertise FUA so the block layer emulates it.
> +	 */
> +	NVME_QUIRK_NO_FUA			= (1 << 24),
>  };
> 
>  static inline char *nvme_quirk_name(enum nvme_quirks q)
> @@ -236,6 +242,8 @@ static inline char *nvme_quirk_name(enum nvme_quirks q)
>  		return "dmapool_align_512";
>  	case NVME_QUIRK_ADMIN_PAGE_ALIGN:
>  		return "admin_page_align";
> +	case NVME_QUIRK_NO_FUA:
> +		return "no_fua";
>  	}
> 
>  	return "unknown";
> -- 
> 2.53.0
---end quoted text---

