Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DA4CD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gZM4EZBIz25FgIdBjHrmrU2mVdWII7hTPyIkOvvWKDE=; b=xFpaUmxDnR/u0oj3X8O9EgHxUG
	yeKezcVT1vdkB8GTJY/xsJf/4wNgCalA66PMKykhclB1YedCyRgCeFxxhoEjMSCUw2vkVjWCLlWub
	DoFTQidyO4wPlotoJKNOrkpbM748swfCfLpDnFUQgfvH6xANGAjnaQ8RC1zcWeJPtBJlT3sJOC33E
	h5xmJptB7XZaI8bASmGBQfx67W+HU8OSm3vMc2mBL0lPcq7jdw2ISIujj3vJG3EjpR2x1dzlcLxoQ
	idyX/+OOZeHIPnvNGCGJYMZ//u+WtJ6ZOOoNdAJFIzQB4FtRpwlMJc61QD9MdkVM9LamZztSx+Q/g
	Q0kaFScw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUO5c-0000000CxoX-2GWk;
	Tue, 02 Jun 2026 12:19:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUO5b-0000000Cxo3-00ga
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 12:19:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 35E264455F;
	Tue,  2 Jun 2026 12:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF72C1F00893;
	Tue,  2 Jun 2026 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402762;
	bh=gZM4EZBIz25FgIdBjHrmrU2mVdWII7hTPyIkOvvWKDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U1GMJVaexr4MMrCm+8WR+SRGsTscD2h1gGHeK+hutWrgDGvH1jZdIBCCU0VDY/Auo
	 Pd9I/GRV1kGXqcmJB83QsXwJ1a/J3Be5JV5Q3yf7BmbdS5aUVyAUX1N41fWjC3qwET
	 VXOXHqoaPhAsIWbtBibirqRgU9JJ+7w882toYLnsq8QDDNzqJhxNZUyIEf643vSAio
	 DI+EY4wKwGKAU0tJSXI/rmHM/XKevvOePVXM78L1/hdkFPGxYDpbcifm5mQHxFn1dq
	 tMQ03C20JbRoQy02DuvmiNaQ18hWo47aDeuaZch7poPoCbKb4HTPCNCr1bQbulTFjA
	 qIIrUOIk+qKkw==
Date: Tue, 2 Jun 2026 13:19:16 +0100
From: Keith Busch <kbusch@kernel.org>
To: liuxixin <gliuxen@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] nvme: validate FDP configuration descriptor sizes
Message-ID: <ah7KRIl3LNsbWLO4@kbusch-mbp>
References: <20260527133205.GA12042@lst.de>
 <cover.1779930057.git.gliuxen@gmail.com>
 <20260528083016.GB7073@lst.de>
 <20260528083043.GC7073@lst.de>
 <cover.1748418000.git.gliuxen@gmail.com>
 <b2f3e4d5c6b7a8901bcdef2345678901bcdef234.1748418000.git.gliuxen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f3e4d5c6b7a8901bcdef2345678901bcdef234.1748418000.git.gliuxen@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_051923_056912_AEF86B80 
X-CRM114-Status: GOOD (  12.65  )
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

On Thu, May 28, 2026 at 06:00:02PM +0800, liuxixin wrote:
> @@ -2275,7 +2275,15 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
>  	desc = log;
>  	end = log + size - sizeof(*h);
>  	for (i = 0; i < fdp_idx; i++) {
> -		log += le16_to_cpu(desc->dsze);
> +		u16 dsze = le16_to_cpu(desc->dsze);
> +
> +		if (!dsze || log + dsze > end) {
> +			dev_warn(ctrl->device,
> +				 "FDP invalid config descriptor at index %d\n", i);
> +			ret = 0;
> +			goto out;
> +		}
> +		log += dsze;
>  		desc = log;
>  		if (log >= end) {
>  			dev_warn(ctrl->device,

I think you can delete this "log >= end" check now that you added the
same check right above.

