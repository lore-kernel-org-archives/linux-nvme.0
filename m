Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B39E7718A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 05:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JW9Z1LQZZv2HKsYvHWBO20XpbT6MX8ZHrEmjx+oz+YU=; b=fhZLEVc5OUM3q0SjjGD3rhfFkd
	KWkVJBvNwtmPIKuJ2aH1eJLt5EDv+gZHMtE+0blEPJzfEwN/9qZGgbasWQT6evVu/I5Qqc1p8akNj
	iYStYJVHQ8ScRcVc1X9Ldn0XGsTKYLz/qyhEf03+dFWdbL/ilGh0uZNS52Hbg/amw0nGfCcVVauSx
	czIWg1KfGUR7pWYuztYFkas6IN7qeXBpW4MY2Z9R7GdRZo7wNofkQVMWxktrvTS578UMnZP6KIw9z
	kKQrhn7yxgmCz5cAO9pI0KtmCepU+Riv5afRdAySs8RPwySl7k4s2LuH9zhUESLVjAa8c4Kvcx8ql
	lMgADNLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tO9M7-00000000tli-3c6E;
	Thu, 19 Dec 2024 05:45:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tO9M5-00000000tjh-28rq
	for linux-nvme@lists.infradead.org;
	Thu, 19 Dec 2024 05:45:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5826668AFE; Thu, 19 Dec 2024 06:45:43 +0100 (CET)
Date: Thu, 19 Dec 2024 06:45:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241219054542.GB18853@lst.de>
References: <20241212113440.352958-1-dlemoal@kernel.org> <20241212113440.352958-18-dlemoal@kernel.org> <20241217085355.y6bqqisqbr5kbxkl@thinkpad> <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_214549_689702_5F459521 
X-CRM114-Status: GOOD (  17.84  )
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

On Tue, Dec 17, 2024 at 06:35:33AM -0800, Damien Le Moal wrote:
> >> +static inline u32 nvmet_pciep_bar_read32(struct nvmet_pciep_ctrl *ctrl, u32 off)
> >> +{
> >> +	__le32 *bar_reg = ctrl->bar + off;
> >> +
> >> +	return le32_to_cpu(READ_ONCE(*bar_reg));
> > 
> > Looks like you can use readl/writel variants here. Any reason to not use them?
> 
> A bar memory comes from dma_alloc_coherent(), which is a "void *" pointer and
> *not* iomem. So using readl/writel for accessing that memory seems awefully
> wrong to me.

Using readl/writel not only sounds wrong, but fundamentally is wrong.
readl/writel should only be used on pointers returned from ioremap and
friends.  On some architectures it might use entirely different
instructions from normal loads and stores, and on others it needs to
be a lot more careful.

> NVMe BAR cannot be fixed size as its size depends on the number of queue pairs
> the controller can support. Will check if the 4K alignment is mandated by the
> specs. But it sure does not hurt...

Keeping it 4k alignment will make everyones life simpler.


