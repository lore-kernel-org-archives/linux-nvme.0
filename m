Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F215C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:35:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67F82074D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jL5oOc9G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OSKCiZVY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OSKCiZVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67F82074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MpqRxYycOmiAcbVysOzpNZwoh1/5AZ3YW1F20+RuQSs=; b=jL5oOc9GKYNR/NECmCScFb4/Y
	6oip3DPJy5+jpvBONqk81G7NCZClSllAPde8gHjVlZF68NtzAbmKyCkHnk8+pjCeanO1acEcX/3Fn
	1J4SD87o0mMjXVQjn3JJeiceALsvOfa0Q41rAFy0hiQXkRqxzwbjbMJP0bZaE6mgE7J6Fyz3PGN1w
	VsPlCJ3BF7QnvBng3dg7KQlpIiUmsaTn8VE+aMuBjykPbzztSr6aY6AFCT9pFWmXWcTL8Cxp6QmRe
	ocpEtmfgGL+xxqbX/niwOgmeRH8TRUbYFBC49Ho1l7DQJgoWAdJJbjnf3t1LOrPoAiOpgVi8sxPVN
	slFXeg1kA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEDjv-0004xo-JC; Fri, 04 Sep 2020 15:34:59 +0000
Received: from bedivere.hansenpartnership.com ([66.63.167.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEDji-0004pA-Mq
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 15:34:50 +0000
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id E23378EE112;
 Fri,  4 Sep 2020 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
 s=20151216; t=1599233681;
 bh=aqBYVVDxSPcR+4WRGd2XXdbYUrXI1R2tpGt8e2CxOqk=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=OSKCiZVY/HICluT+E+gBea2klKfGTnSyh+e5emDR2r1NB8op0pvrrhFcgY6WpLXfi
 BgwwbeRb5VG2jPAx3sUPZQpMPsfm8M1dAfUAh8brrNXhqqe8gVtdtzwSB3orIrDD7l
 YoD02xMi9/Vnz3qACuvRNiD5YpaTVrPCKQCyS0ro=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id 0lY_VcvizQiN; Fri,  4 Sep 2020 08:34:41 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net
 [73.35.198.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 432438EE064;
 Fri,  4 Sep 2020 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
 s=20151216; t=1599233681;
 bh=aqBYVVDxSPcR+4WRGd2XXdbYUrXI1R2tpGt8e2CxOqk=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=OSKCiZVY/HICluT+E+gBea2klKfGTnSyh+e5emDR2r1NB8op0pvrrhFcgY6WpLXfi
 BgwwbeRb5VG2jPAx3sUPZQpMPsfm8M1dAfUAh8brrNXhqqe8gVtdtzwSB3orIrDD7l
 YoD02xMi9/Vnz3qACuvRNiD5YpaTVrPCKQCyS0ro=
Message-ID: <1599233679.5231.4.camel@HansenPartnership.com>
Subject: Re: [PATCH] dma-direct: zero out DMA_ATTR_NO_KERNEL_MAPPING buf
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Hillf Danton <hdanton@sina.com>, Christoph Hellwig <hch@lst.de>
Date: Fri, 04 Sep 2020 08:34:39 -0700
In-Reply-To: <20200904152550.17964-1-hdanton@sina.com>
References: <20200904152550.17964-1-hdanton@sina.com>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200904_113446_926679_DDD29206 
X-CRM114-Status: GOOD (  20.26  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2020-09-04 at 23:25 +0800, Hillf Danton wrote:
> The DMA buffer allocated is always cleared in DMA core and this is
> making DMA_ATTR_NO_KERNEL_MAPPING non-special.
> 
> Fixes: d98849aff879 ("dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING
> in common code")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -178,9 +178,17 @@ void *dma_direct_alloc_pages(struct devi
>  
>  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>  	    !force_dma_unencrypted(dev)) {
> +		int i;
> +
>  		/* remove any dirty cache lines on the kernel alias
> */
>  		if (!PageHighMem(page))
>  			arch_dma_prep_coherent(page, size);
> +
> +		for (i = 0; i < size/PAGE_SIZE; i++) {
> +			ret = kmap_atomic(page + i);
> +			memset(ret, 0, PAGE_SIZE);
> +			kunmap_atomic(ret);

This is massively expensive on PARISC and likely other VIPT/VIVT
architectures.  What's the reason for clearing it?  This could also be
really inefficient even on PIPT architectures if the memory is device
remote.

If we really have to do this, it should likely be done in the arch or
driver hooks because there are potentially more efficient ways we can
do this knowing how the architecture behaves.

James


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
