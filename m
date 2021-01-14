Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D54BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 17:33:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA01D23B31
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 17:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA01D23B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DLuxW0a9jv1XXVwLETSzVdQNieCLg2cORCQ01Ik8x1w=; b=EtBWTHOIIIxKVC5QU92WtxlRs
	fYlnQF68pHoHdpQqVPcChvd25dKEpY+cj42/iwrXcNnNeHRB+1Y+ATXE0K6Xm4FnH5UCgc7/vlo4b
	A95RVeUVQ9q+cnsDQ5Q3zUx7vtdaC6QyXHY5SSVTZRp97brxjmySjxB7gqFNROzvfp5vfqrRoD/m5
	ilxesvhhqME0iro6a37x5fKQTaak0W05zaTpRRJE9zSUIR6k6P/RI11L0xhx10UYyyZmK3sHJQZnx
	WaGmwL0h8OYBJFeA+3CXkyTHJS6mEicZqv3j1w68+YQivtx+kJIrC+LlluATeUOWaCfKHru1HMRMI
	NCs8x6Qbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l06Uu-0003A2-3Y; Thu, 14 Jan 2021 17:33:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l06Ur-00038o-Gt
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 17:33:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ABB1068B02; Thu, 14 Jan 2021 18:33:13 +0100 (CET)
Date: Thu, 14 Jan 2021 18:33:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH] nvme: allow use of cmb on v1.4 controllers
Message-ID: <20210114173313.GA31028@lst.de>
References: <20210114132441.193782-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210114132441.193782-1-its@irrelevant.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_123321_682210_BD873F7E 
X-CRM114-Status: GOOD (  17.32  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Klaus Jensen <k.jensen@samsung.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 14, 2021 at 02:24:41PM +0100, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Since NVMe v1.4 the Controller Memory Buffer must be explicitly enabled
> by the host.

Thanks, this has been on my TODO list for a while.

> +	vs = readl(dev->bar + NVME_REG_VS);
> +
> +	if (vs >= NVME_VS(1, 4, 0)) {
> +		if (!NVME_CAP_CMBS(dev->ctrl.cap))
> +			return;

We should not check the version here, but the presence of the new
register so that controllers claiming an older version complicance
that implement the new scheme are supported as well.

Given that the old scheme is highly dangerous in virtualized enviroments
we should also warn about it and eventually required an explicit opt-in
to use it.

> +	if (vs >= NVME_VS(1, 4, 0)) {
> +		cmbmsc = pci_resource_start(pdev, bar);
> +		cmbmsc |= (NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE);
> +
> +		/*
> +		 * Writing the low bits may cause the controller to check the
> +		 * validity of the 52 bit controller base address in the CMBMSC
> +		 * register, so write the high bits first.
> +		 */
> +		writel(cmbmsc >> 32, dev->bar + NVME_REG_CMBMSC + 4);
> +		writel(cmbmsc, dev->bar + NVME_REG_CMBMSC);

I think we should just use writeq here, with the hilo wrapper for 32-bit
platforms here.  The reason why NVMe has so avoided the 64-bit access
is for buggy Apple controllers, but they are unlikely to implement CMB.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
