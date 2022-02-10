Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D87DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7VPSUCwf1glTvWgXMy0dSvUDX8AhY1pgybwCv3J1G5Q=; b=RNzV+OLcUlZg3QXmTOZNFuHBGq
	F1hhXa1Q+dxQLaX/hPZVWGbUwVoI+UPnrcCdYkYGFhOrF7Z5XBmwYM574XLWm5X0XVGWRb+Pfn2gt
	JXiexeEXJItDPYFiWa+aknV+di/EgD9fMeDPLWhFWRTSRyrbJg6iZl4Ka0TSyYcyW2nRDiJ/FArCQ
	N8ukjG8SESeXhBtzXWJv+L7/1f4QZ0j/0Gcbwe4oSG4Ogu5RCn2t2CiTk+iAd4ShbRxvBz6NdnGmg
	43a4iCXWUYuNT3mzrLEiZ7ATibSB9ivHzPYfFYwTvSNya441XNClUOmcauHxJjfIb6RKV9NHlDDPP
	ycKCZ0Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIE5E-004bVU-9w; Thu, 10 Feb 2022 18:22:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIE5A-004bVB-FK
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 18:22:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3742468AFE; Thu, 10 Feb 2022 19:22:12 +0100 (CET)
Date: Thu, 10 Feb 2022 19:22:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] nvme-pci: simple suspend quirk for vmd devices
Message-ID: <20220210182212.GA16171@lst.de>
References: <20220210152233.1657933-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210152233.1657933-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_102216_679302_C35749DF 
X-CRM114-Status: GOOD (  11.24  )
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

On Thu, Feb 10, 2022 at 07:22:33AM -0800, Keith Busch wrote:
> +	} else if (pci_domain_nr(pdev->bus) > 0xffff) {
> +		/*
> +		 * ACPI device properties are not reliable within VMD domains,
> +		 * so assume the worst.
> +		 */
> +		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;

We'll need to communicate that from th vmd layer instead of hacking
a check like this into NVMe..

