Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84ADC83F1D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 07:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G+ZmrCDN4RHlM/a5Gxz2MV/Uxj50Tf1bXkeRmGBg4wc=; b=Zo5s0BXNXPSgRM8hHU28IjJrfo
	bl+d9dKQor1ATSjMxiTPemdNSgEgcDZmm3wtfRarq9CkBRE64VgEly9S01yfoHZGuOsWNZKphJn7w
	khTFhWadkT135RAdDUoJ8BpF76Birrk6MQ1eE+GfyHhwGL8Fj9NdFMFwD+lMwuR2oN5yImTpJAC/c
	vGd2os39YkmWp5uzmPT/OlYuYUfb+dWfE958GVpBP2f9puN7BBjNDAzLT3S+W/WTtFKt+hyNI8dKa
	yylSsNxkyRxPOlDD78X/IJWV6VZvk4QitfM2/tJg6mm8UuNrPxSYKRGqq3WiejNoja0GwEJz8hsQt
	3Ll/S3zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubaMg-00000004OKX-1Ub0;
	Tue, 15 Jul 2025 07:46:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubaMd-00000004OJY-26RA
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 07:46:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E52667373; Tue, 15 Jul 2025 09:45:59 +0200 (CEST)
Date: Tue, 15 Jul 2025 09:45:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: try function level reset on init failure
Message-ID: <20250715074558.GA20362@lst.de>
References: <20250714171328.681885-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714171328.681885-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_004611_713605_B02E4B73 
X-CRM114-Status: GOOD (  17.51  )
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

On Mon, Jul 14, 2025 at 10:13:28AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> I've encountered various nvme devices that for whatever reason are stuck
> in a reset state. Historically these have required a power cycle to make
> them usable again. Vendors don't report any problem with the device when
> we ship these for analysis.

Who is the "we" here?

> In many cases, a PCIe FLR is sufficient to restart operation without a
> power cycle. Try it if controller reset fails the first time.

Why is that only done in the probe path and not the runtime reset path?

> +	if (result < 0) {
> +		struct pci_dev *pdev = to_pci_dev(dev->dev);
> +
> +		result = pcie_flr(pdev);
> +		if (result < 0)
> +			return result;
> +		pci_restore_state(pdev);
> +
> +		result = nvme_disable_ctrl(&dev->ctrl, false);
> +		if (result < 0)
> +			return result;
> +	}

Either way this warrants a big comment explaining what we are doing
here.


