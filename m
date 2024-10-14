Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477BDD16261
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pskFySbmN+qWegSafMykyZ0h8m12eCmqEI5KkcQFUuc=; b=HBC4vnC/q6OxkOJd989yMvc3Hw
	joD5+K0uwQOodHV9Uhznw1SyeAiy/P1TSVu60RZx8UgABiamBIFHZ/NI8ppyGff2+Qs0oCBWtVV+S
	pbvS6Ns2XHitPfjVADTZbQHgjz+z2guVC2MCglnIfqeg0uFidVqBawwvBCJkGX/e7uYAdMG04axv7
	+oXu6ERDi38tiARDG4BzSPDYJ+6Wzcqax26HEaLnbfvirCOGdFe6PFraF867dIciiCI73hUI/pRLk
	1j+cv1B9qD0UzJG8WIRe6elBk1h+/Nm1b2maSdcmcZCPQ+grpMXYjACEhCKu88Gjhnnslu6XwgxKr
	HI2CoKkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0L54-00000005GMW-1FUd;
	Mon, 14 Oct 2024 13:25:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0JOw-00000004xWP-31WX
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 11:38:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C13CD227AA8; Mon, 14 Oct 2024 13:38:09 +0200 (CEST)
Date: Mon, 14 Oct 2024 13:38:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 4/5] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <20241014113809.GA31551@lst.de>
References: <20241011121951.90019-1-dlemoal@kernel.org> <20241011121951.90019-5-dlemoal@kernel.org> <20241014084424.GC23780@lst.de> <79e57ebb-eef7-48b1-b337-845d2ef6ff49@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e57ebb-eef7-48b1-b337-845d2ef6ff49@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_043814_929430_6A7A6CA8 
X-CRM114-Status: GOOD (  13.83  )
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

On Mon, Oct 14, 2024 at 07:41:18PM +0900, Damien Le Moal wrote:
>         |    | PCIe NVMe endpoint driver |     |
> 	|    | (Handles BAR registers,   |     |
> 	|    | doorbells, IRQs, SQs, CQs |     |
> 	|    | and DMA transfers)        |     |
>         |    +---------------------------+     |
>         |                  |                   |
>         |    +---------------------------+     |
>         |    |     NVMe fabrics host     |     |
>         |    +---------------------------+     |

That whole fabrics host here is broken.  The PCI frontend needs to
talk directly to the target code instead of doing a completely
pointless roundtrip through the block layer.

> Unless I am mistaken, if I use a PCI transport as the base for the endpoint
> driver, I would be able to connect only to a PCIe nvme device as the backend, no
> ?

No.  Any fabrisc transport (or frontend) can you any of the the
backends (file / bdev and passthrough).


