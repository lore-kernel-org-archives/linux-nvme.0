Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC57F4BB75
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 18:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4OK1YTNnOji2O6kxqfLZqMmB3WRpKUhq6dOvXsVhnK0=; b=1qbZ9BSCswlJlag8QYedwVT1m1
	6T+0EmBdpsy77WhL/R1s55cAWLdAR/+2xXYO1MomtT3oSykiRbY1WdfNI3Fgrt9Klkx8NYpHc3Xrg
	1SYPCYkdBisETl2D7XQSXqbVRxE6d7U9HcMQavbJ5fuQQPidGCbVm7CBSxBw9pzMh8F8eZy2whtUk
	C75FMsBejtyAdrJetfwul3vy4kqzsIR/P55yWdwTWOWcpiSpUpTmhZsdau26TxxGJGfVupcSirXxN
	s5eiPAaH323ZXoHSNs0FHH0X7A/ymXu4AkmDTtp8fCWYrpnp6KfVuOneuDNkB4CoUoo17/u422JCm
	m3uYu9Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxVe-00000002euo-3KSQ;
	Tue, 24 Feb 2026 18:51:50 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxVe-00000002euf-1Nfk
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 18:51:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6453260053;
	Tue, 24 Feb 2026 18:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41F9C116D0;
	Tue, 24 Feb 2026 18:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771959109;
	bh=AZGNYVpeU1M4JPLowWiAt2wuOLx9+EsKFXkaDQuytuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRSec2uXSQPQhrd4l6GAFmBmDMrOVjXj8LleMltp8auJ/N94AsUcagjBsMWkLuS54
	 Ojuvc8bjXMCbtyfl1MWVwBxcGiifsWSJwMEPnpKwNM07NIu4eG3cakNGY2d3ybk2aQ
	 uPj6YZoGIFuVgoC0SnhjJndNLOOAZq2myLPBuie69Kq+o9KPONMxRNWy+k/Ajq3/+/
	 OVJfdggSBrorPTC7rvoqn3APUAgNI9HrM/um7wLN2Vbpz6bk4NSMnTWUzWyJYGQ0Il
	 lGIJPA3p899aGWeTfQ/TvtxEXbVCLgytFlS11tWPWm8ro5Dp9/ZM008XHm/DpuqZNL
	 Mx598MihhQ4CA==
Date: Tue, 24 Feb 2026 11:51:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] nvme: always issue I/O Command Set specific
 Identify Namespace
Message-ID: <aZ3zQkApqZN3tkf6@kbusch-mbp>
References: <20260224171437.3175993-1-csander@purestorage.com>
 <20260224171437.3175993-5-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224171437.3175993-5-csander@purestorage.com>
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

On Tue, Feb 24, 2026 at 10:14:33AM -0700, Caleb Sander Mateos wrote:
>  
> -	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
> +	if (ns->ctrl->vs >= NVME_VS(2, 0, 0)) {
>  		ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);

NVMe allows older spec compliant devices to implement features that came
later, so I think you need to keep the old condition as an option in
case there's a 1.4 controller with extended LBA formats.

