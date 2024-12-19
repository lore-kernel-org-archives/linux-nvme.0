Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B33E77184
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 05:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yfIkvlMknPO6sKbENsm0KDdAeN3ZXoUkQGbksLDlNzo=; b=d6WF7fkwvzV8v8iAIjkjacZUbv
	rBRwc9NM5/Qzlc71zyASffOREqdWo/fmNxpktTzCTi9BOkv+MQ8sidRuHqF5szRpaeA4x1U4MwfRm
	ce72PpXG6XJWRyzDHI+8JSwM2m9qsSmZFgGON7GdKXn5NA2WfMEjLNfpIqr42TgbkK3+wvMt4M4q5
	zAQFQWUuEZBXUWXfTAbZLrGLogn+LqbxHKaf34/xf+cOqo7/nILE5XMGwTNgVAKrn94SlQv7/jOU5
	0IUUmj6lv/KFL3OYYv+XtDZvC757uOPZInySChkffb21tzPOJbEW1F7jYBLunKBx7a43I4OHuNquz
	p1KDZGYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tO9NL-00000000u57-2tri;
	Thu, 19 Dec 2024 05:47:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tO9NJ-00000000u4W-1TOM
	for linux-nvme@lists.infradead.org;
	Thu, 19 Dec 2024 05:47:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B5CEB68AFE; Thu, 19 Dec 2024 06:47:01 +0100 (CET)
Date: Thu, 19 Dec 2024 06:47:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241219054701.GC18853@lst.de>
References: <20241212113440.352958-1-dlemoal@kernel.org> <20241212113440.352958-18-dlemoal@kernel.org> <20241217085355.y6bqqisqbr5kbxkl@thinkpad> <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org> <20241217164149.vuqwtthlykn7bobj@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217164149.vuqwtthlykn7bobj@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_214705_530655_DFAD34DB 
X-CRM114-Status: GOOD (  16.23  )
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

On Tue, Dec 17, 2024 at 10:11:49PM +0530, Manivannan Sadhasivam wrote:
> 'iomem' is just a token that is used by sparse tool to verify correctness of
> MMIO address handling.

That is true, but we don't have the token just for fun, but because iomem
needs to be treated differently.

> I know that the memory here is returned by
> dma_alloc_coherent() and is not exactly a MMIO. But since you are using
> READ_ONCE() and le32_to_cpu() on these addresses, I thought about suggesting
> readl/writel that does exactly the same internally. If you do not need ordering,
> then you can use relaxed variants as well.

No, using readl/writel on dma_alloc_coherent buffers is simply wrong.


