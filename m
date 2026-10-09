Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64061CA6019
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kLgpLQENCeXHMZ4r/LduUsI/Qb8wWOkpqbiHZFcOMxE=; b=Dn3WHHw4Kr4MQtAJupBQo/C93Y
	2Mb2hNbYK4qG8yh452i8ahnCtg6Fx2IcyfHuUAW2TMimWtvMir/987dGTeF+9vzK/xr4XKLSW4J6T
	wqZ8U0E2HEJ1HzYNJ6as4mqSw0AJd8FC615dZQid8Stg/lfRyvN9djiQJupSDeE1Nm5T4OElMZ0/R
	JDcRvv/hjXMcGwmgCGFyPjWFN3S0UiwtJYTkKSsWFkPQbRMEDriAEkSTXRnMQtTIHCm6EpJyOh9Vw
	Q0OB2GFyJ7eCoLfC0slNADoEs1jyQfN2c6Nv6IzZ/huqFb/Q13J641zRAoQnLCDSz6b98zaltQmiS
	cg7mif/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFCew-00000006XzI-45Gz;
	Fri, 09 Oct 2026 15:37:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFCev-00000006Xyu-16tA
	for linux-nvme@lists.infradead.org;
	Fri, 09 Oct 2026 15:37:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9AFB760098;
	Fri,  9 Oct 2026 15:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7E61F000FF;
	Fri,  9 Oct 2026 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560240;
	bh=kLgpLQENCeXHMZ4r/LduUsI/Qb8wWOkpqbiHZFcOMxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VJ8jwhPtr5b0JPDRMAC0FHI1wuMC/MGaiRyKN1N8/ndV1HO6Q6ox8I3kOCbjBTBML
	 keOQ9pfgaIKn6fIOxv66OSyD7YK/CnmLrEKHz39U6MX2ZI757rKIgjRPXDXr1Qygrx
	 o2vbODyY9paPenMBASgTCI6bO1AwvxZv9uP6i32D+EUHhzhYqqeHGEgOKOxc9nP3cM
	 fe8ZKif+f9EolQEU6W+0NBiLB9mRXaIox9U73wnowSa9h3ddYsPWtA+9WJgJ/58Lju
	 6MIRyv9kMa4yqBcCx6dJKhBDPCUdvzcEOoL01wNtKmqxsDxjOTeP8WcUG4lI7ixv/z
	 xrx+WQr9VJcsw==
Date: Fri, 9 Oct 2026 09:37:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Adrian Huang12 <ahuang12@lenovo.com>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Jiwei JW10 Sun <sunjw10@lenovo.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
Message-ID: <askKLgBhLzjaOyfF@kbusch-mbp>
References: <20261006120248.147654-1-hch@lst.de>
 <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
 <20261008123724.GA22096@lst.de>
 <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
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

On Fri, Oct 09, 2026 at 09:11:56AM +0000, Adrian Huang12 wrote:
> 
> BTW, with this reverted patch, I'm setting up the test environment to
> check whether the issue does not appear with a newer kernel that
> includes the updated IOMMU subsystem. I'll share the results by the
> end of next week.

It does sound like an IOMMU implementation issue if the revert regresses
your testing. Let's say the application wants to write 1MB of data:
we're DMA mapping the same total amount either way, so I don't think it
should have been more efficient for the driver to send eight 128k
mapping requests vs a single 1MB.

