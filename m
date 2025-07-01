Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FF3C8302F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 00:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJI2AcliJAm4zKYjQQt7lU1bNOIAqP31nP5uByM5M+Y=; b=vCMHW+23bxZG1XcnYZG2ajYz+s
	sefxRFdAVPtN5LGZm285otacu5pzwOQH+WwxQhWi3Tf/3eZHytAxNRamK1MQgHo9Ii+zPJwC3rTqN
	S2ZmOzykQaaMVNqhqiF9XOSxaYZEYNCQ0y4GEqa48l8wBEfgcJZZB3LpLxOR29vwAoxC9g293nNms
	Z9QMPB6GDPGNkBkiP09PzcZNQMW3e6K5NVTY8m5c2whnRHoihEQXrw5yB9aQYmo5sL8LFscosIk7J
	KwofMVEUblsheymIi9sRGLDmDP3wsJ6w0RsSwYX3Ywt7Ar3foYqjzMCAIK333aG7+/40bDSSE2y8y
	3MWr+VGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWPGV-00000003lTZ-17Gz;
	Tue, 01 Jul 2025 00:54:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWPGS-00000003lSR-0vTf
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 00:54:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EE15A46068;
	Tue,  1 Jul 2025 00:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7683EC4CEF1;
	Tue,  1 Jul 2025 00:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751331263;
	bh=ToOw6uJVC9iS7TA1n50KV+hOesklTI3h/nf9C9Afkk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyK4qdqe7n2SY35w+0A2VIvZMp5I/DS91mgGqJg0VUJl9P+KTZz8W8cM6NauRPs0d
	 8Z4KahMYQfwakLpjFJGiBdtTnTTcsK2k3VLG0dsTY4g0X06c5R4UUaWbWKDxl5vlv5
	 QKlX/ooQaHil84zfPAo5lowvdjELNQnek6Lqsuipnltx14giYoclu/w16F9r88UuhR
	 MGKCx3M1BrRxxqIA2JZegKWGf7raug3DEawkejgjW6hmJ8unAsq08LDGwXHh6SeJJ8
	 lWGlDH3/Qi9Ehh4+R6CBJMvIPnbhgBAfR88RZCIviqrJI9L51AMHzweUJD/rTjBAsN
	 7P36XETuKdU8g==
Date: Mon, 30 Jun 2025 18:54:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ben Copeland <ben.copeland@linaro.org>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGMxu6Yn514Xy55w@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
 <aGLyswGYD6Zai_sI@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLyswGYD6Zai_sI@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_175424_285389_9D8C2FA3 
X-CRM114-Status: GOOD (  12.32  )
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

On Mon, Jun 30, 2025 at 02:25:23PM -0600, Keith Busch wrote:
> On Mon, Jun 30, 2025 at 03:33:43PM +0200, Christoph Hellwig wrote:
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -701,7 +701,7 @@ static void nvme_free_prps(struct request *req)
>         prp_list = iod->descriptors[desc];
>         do {
>                 dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
> -               if (i == NVME_CTRL_PAGE_SIZE >> 3) {
> +               if (i == NVME_CTRL_PAGE_SIZE >> 3 && length > NVME_CTRL_PAGE_SIZE) {
>                         prp_list = iod->descriptors[++desc];
>                         i = 0;
>                 }
> --
> 
> But even that, the PRP setup doesn't match the teardown. We're calling
> dma_map_page() on each PRP even if consecutive PRP's [...]

Err, I meant to say "dma_unmap_page()".

