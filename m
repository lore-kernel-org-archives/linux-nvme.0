Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB11CD6E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VL4VWJzeB4HS/d5/cXGyc8snM32gvnfTLIvoAz8tltQ=; b=dNv+zrDb5EfcIqd/yBUTY8QfYY
	UJ43H22u6QWMxf8ktdqf0oGhp2UU72GQtkaS2OZ9ucTrxpDR7eluguUzE3gQ6m6t3keM1CF/H0SIY
	+pIGQKD8AuOVjzm6C5z1ZmEJu2ynBrfWK//c8sRIxA83QAMzAT2OEwtCGntQy23zdQVsW5v+jhBHy
	R0vb+mDlGqRBUiBEgv3x5nF9yUPLeF/Zr/rIlAjYHlKTWRu+x7S5NWL9fVGJwARbzBmS8JgyKXj3h
	N3pGm1QqLnRLrJIxQh/6hQouTAVlp0WpL4KCLkfhRi+wAUdRLHEYPFVnN56jn2+92AIBqFVWQ5id4
	yxj6I77g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV4R4-0000000GVRY-3pQt;
	Thu, 04 Jun 2026 09:32:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV4R4-0000000GVRL-1XFc
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 09:32:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BBB3A601D6;
	Thu,  4 Jun 2026 09:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351901F00893;
	Thu,  4 Jun 2026 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780565541;
	bh=VL4VWJzeB4HS/d5/cXGyc8snM32gvnfTLIvoAz8tltQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YyBmZV6Gj1cw9+fUsn3OpPTIY9Tyirfyxsm83lLN3kFPcSdTGF0yVSUxogeAb2e1P
	 J78K+BfC4V5oCLrld/ZQN9YCB6IWjWnEy/rugxGH1SIg8f7f2cq58kd1kPalTrfzI4
	 C1h4rNNbbqj72uVVO24Whsil5lDipwmnr/SLilAHvzg8v+JEVqUoXYYLh8h5wSdfm7
	 ugC8+ZXKrFXGqM9G5fSMqyj0Oy6WY2patYjjbOYqvtI4DDG0JCGfcrHr5kEA9m8voE
	 ABxzBaK9bErXK1fNgIyifJciezd74niTT6ODNyaBjV2djZqDyoJZA9Cx9tRQtn7bZN
	 GYPSYu1bo0YdQ==
Date: Thu, 4 Jun 2026 10:32:15 +0100
From: Keith Busch <kbusch@kernel.org>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvmet-rdma: reject inline data with a nonzero offset
Message-ID: <aiFGHxci7FnDRUL1@kbusch-mbp>
References: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me>
 <ahm6Ksr3rfGdnOsN@kbusch-mbp>
 <20260604084624.120032-1-hexlabsecurity@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604084624.120032-1-hexlabsecurity@proton.me>
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

On Thu, Jun 04, 2026 at 08:46:33AM +0000, Bryam Vargas wrote:
> A nonzero inline offset is never legitimate here.  nvmet advertises
> icdoff = 0, nvme_rdma_setup_ctrl() refuses to use a controller that
> reports a nonzero icdoff ("icdoff is not supported!"), and
> nvme_rdma_map_sg_inline() sets the inline descriptor addr to icdoff, so
> a compliant initiator always sends offset 0.  nvmet_rdma_use_inline_sg()
> likewise assumes the inline data begins at the start of the first inline
> page (the RNIC DMAs it to page offset 0); any nonzero offset also
> mis-describes the scatterlist even when it is in bounds.

Wait, is this accurate? I'm pretty sure icdoff == 0 just means the host
can start the inline data immediately after the SQE, not that it
necessarily must do that. My understanding is offsets are still allowed
as long as the total length fits.

