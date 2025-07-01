Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E0BC7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1TWX8rTsCZMwR7J7QVpBk+kp2Qgls/iNpOzUF5Kdzek=; b=jfs5gCQD0aLxzQGaSKQX5zesZd
	mzCkPnJf1kc2jm6/oWxMxKNszi8mo/JcMfYh0yQVSTTmqZcEa3MKI027QPi9TZKEtoELUzzqVZGYb
	lwzJP8EdSPrGSgjY+HvuoC4ewIhNghd3kocUsG8LTsKBnM5En/fPDiW/7xgH5OMc7NU9H7jBjMaG4
	B34x2iTS3ueiab5cPa55Zegz2S1BPlbN+5fyYv9Sn37+/7MDNSNReSOW6nW6bjG8x3R1xmq+GGlHh
	gPIAq2MzGdDmUpPv59gQDeC7GeQSErpXtuSds7NVXdP7/erJNOclDn4Iz1uzBSBlBTvDoxenWA8K4
	MaOhEUlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWc4H-00000005iut-2hyt;
	Tue, 01 Jul 2025 14:34:41 +0000
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWafo-00000005RDi-3Fsf
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 13:05:22 +0000
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-2efbbf5a754so2246926fac.0
        for <linux-nvme@lists.infradead.org>; Tue, 01 Jul 2025 06:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751375119; x=1751979919; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1TWX8rTsCZMwR7J7QVpBk+kp2Qgls/iNpOzUF5Kdzek=;
        b=KQWJVkUyNmEMjY1Qw77ZLujcqQJl6JUqK/5Lheyt9PwywBfO77aDcBC2fMQMjT/PtP
         hpj3SLt7MAyix+J2cqm2hhJPigZyNzxKgE5idWGiPMS2T5Aczd0ji27FAk+phUMRYh4y
         QHjcXtrjELULYahwY723Ws+6iqfdDzL8k/LKHZDQ7AickpmKap0CDf1YSp06Knjjszni
         2JAS39IGpM39KANlDXv7C4VnrAR5iFxtnzXVt0PNhAebfc1vzRlzXmjKKEDFNqWpGZ+k
         5lONjgXp4+wwYQI/2OGtkMqYBMv7VpaaxOUHhv161l4eD6JKNWRf8kOwcSo8elJV0ofF
         +vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751375119; x=1751979919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TWX8rTsCZMwR7J7QVpBk+kp2Qgls/iNpOzUF5Kdzek=;
        b=hjsJFpwpZMFHlH4dyID2lOGTLOk/zYPNesP1nHGIojH+kCJ96jk0A0DCJYg6wo4b0S
         5/JBdgnhUzhQs7FvvtHka3lT0TlQuK28ZcAYOKKyZZkEf/Ljpx3QbS5cXusPUcHzGeSe
         xRS9Ra0kHNfG/AYoYtVgrPRT1sZv8ngi6YetaEKgPtka1zRh5umOBMgDtsdglxom4Yih
         9pzuLJfODH/TYi5MiNW6C39fGisqNMgZ6hfm/p+F4MPBraQ1qKjev4tcQytFqo5EkxCs
         i1XEOElYN/TXXGBSYRam/4yfW1QtLQIgPva+nrDMEOT92hHAWx7Ag2FvwKge4bWFRJ8X
         544A==
X-Forwarded-Encrypted: i=1; AJvYcCVNBcoDMe//vwkpwTcr3CjizlkhZnvFTp8FluuRoliQWJ5LjUPTgtOFI+OsHmNmqD2Yb1CQ96M+nV86@lists.infradead.org
X-Gm-Message-State: AOJu0YzWkBWlvOoFqJgLuJ2bR8Sj0EAAYlzKJFHrWf8CHqHKqjN89yF+
	f4IuV7SRp43sGgChH+jjqINKRsNfdDXVlFtUfIF/UiF0EQQLYeOWFkmXhRsLdgRhPvp+JyIzaV8
	3D6QYz1OlLU797ErAVSDkj2fR7F4PVGBaW3I1P8nw5V7fewE2BrpXUCXU
X-Gm-Gg: ASbGncu0qrgcTAjqDVyKOw/RbFpwHru6bGeyLc344P1HwyLbmQXlBcgCSGCydnx94mT
	qWiTg64cnVx661Afqnk23y+kHCWcb5Lm5SL2XcOOcqEdBDjn4xyy9GaEz96aoC7XsprplEBgNlo
	iW8wL8mz28FwllXDKwgCudYB7xA6nrxojHc11kGq61
X-Google-Smtp-Source: AGHT+IGFPwC9D7ECA270DEQ7V6Lz7pqeKr+PsMPIMsAOBbe6/HXkq3nYn8ORiGwcf/0z2ZOafHpxuFP09EI+CVKrlh8=
X-Received: by 2002:a05:6871:6c07:b0:2c2:174b:c829 with SMTP id
 586e51a60fabf-2efed4ff09cmr12077120fac.15.1751375117445; Tue, 01 Jul 2025
 06:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de> <aGLyswGYD6Zai_sI@kbusch-mbp>
In-Reply-To: <aGLyswGYD6Zai_sI@kbusch-mbp>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Tue, 1 Jul 2025 14:05:04 +0100
X-Gm-Features: Ac12FXxPwbXsIZXwCl1ZRik9WUZfYk8dZINVCxusvm1y0dN6VUD7U0a8B3GvEuQ
Message-ID: <CAL0q8a7acv-9N1XUmJ9LAojdhm947eiira6Kx0tew-VVVCY6kg@mail.gmail.com>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion after 06cae0e3f61c
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk, sagi@grimberg.me, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_060520_834438_3DC5F2F7 
X-CRM114-Status: GOOD (  23.62  )
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

On Mon, 30 Jun 2025 at 21:25, Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Jun 30, 2025 at 03:33:43PM +0200, Christoph Hellwig wrote:
> > Hi Ben,
> >
> > > [   32.857521] iommu_dma_unmap_page+0xc4/0xe8 (P)
> >
> > Can you resolve this to a source location for me. i.e.
> >
> > gdb vmlinux
> >
> > l *(iommu_dma_unmap_page+0xc4)
> >
> > Also what IOMMU driver is this device using?  It looks like it
> > might not support a 4k IOMMU page size.
>
> I think the PRP handling is broken. At the very least, handling the last
> element is wrong if it appears at the end of the list, so I think we
> need something like this:
>
> ---
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
> dma_map_page() on each PRP even if consecutive PRP's came from the same
> dma mapping segment. So even if it had been coalesced, but if the device
> doesn't support SGLs, then it would use the prp unmap path.

Even though SGLs are not supported, I gave you the patch a spin and
saw the same stack traces.

>
> Ben, can you check if your device supports sgl?
>
>   # nvme id-ctrl /dev/nvme0 | grep sgl

sgl is not supported by the drive.. Here was my output:

---
sgls      : 0




Ben

