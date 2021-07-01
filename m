Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35055C11F64
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 13:41:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD4F613FD
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 13:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD4F613FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KzeGJlJ3Trrs1KufV3lo7/tYcolbhz8efkRpdbhO3kk=; b=rzjQrKD1AqWwJO
	dAykhLtXzhD+nGOqTqcYRZMoqbB9x/2IQ9fL6UPIoDlICW4VvaEiriSDxtutpd1rOrHnqhhqj5K6+
	XLS8dMmfDEqh9Z7jF1SYasYVRt8PKnY2SLrM2S5eLt2DYeiM2k4Bzd7Aa4Bkwb67jIFk5c4dxMy+K
	f8gDHTSX0Jl7GlRjpJDqon+dHht9yW30vn5qf3vL1Ae+NpwZrTm2L9ySvqtaLKt5CQRXCBrxnYClF
	a+wCUPx+AwLGVfg9SbrZP0PKeEOVPoxGk0kDxEiyuZFrClgLThGEiF05nNSi0/39ZGnxQSdBNNWbJ
	9bItHJO9+GmNY6GOZ2xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lywwX-00HWWj-EK; Thu, 01 Jul 2021 13:41:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lywwT-00HWUS-DO
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 13:41:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4483267357; Thu,  1 Jul 2021 15:41:18 +0200 (CEST)
Date: Thu, 1 Jul 2021 15:41:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, davem@davemloft.net,
 kuba@kernel.org, smalin@marvell.com, aelior@marvell.com,
 mkalderon@marvell.com, okulkarni@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com,
 Arie Gershberg <agershberg@marvell.com>
Subject: Re: [PATCH v4 09/20] qedn: Add qedn - Marvell's NVMeTCP HW offload
 device driver
Message-ID: <20210701134118.GE18548@lst.de>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-10-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210629124743.6898-10-pkushwaha@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_064121_644292_634139CE 
X-CRM114-Status: GOOD (  17.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 29, 2021 at 03:47:32PM +0300, Prabhakar Kushwaha wrote:
> From: Shai Malin <smalin@marvell.com>
> 
> This patch will present the skeleton of the qedn driver.
> The new driver will be added under "drivers/nvme/hw/qedn" and will be
> enabled by the Kconfig "Marvell NVM Express over Fabrics TCP offload".

I don't see why we need a separate hw/ directory.   nvme-pci.c already
is very much a hardware driver.

> +config NVME_QEDN
> +	tristate "Marvell NVM Express over Fabrics TCP offload"
> +	depends on NVME_TCP_OFFLOAD

I think it also depends on PCI.

This whole patch is a bit pointless.  In general splitting a driver
submission into multiple patches is not very helpful unless the later
patches add pretty much optional and clearly separatable bits.  Otherwise
it just becomes really hard to review.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
