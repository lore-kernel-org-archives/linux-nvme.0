Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4936CCF9E0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 08:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6SDtj8d0z7002Ah1OXhlNOegxUd4GYkNwyBcs2A4pA=; b=xiFu70S8DmG+FU7mS/3QZdUhCP
	UxM3rmfeAlWWVhcGVS9OvwkblcGEF3q9Ky9a2Xsdzm9JeV9hTJtZZOX3n252AwagvoqU0hqCFbuHI
	aAGIgRSAVQbocQTeGslCUpVjbGmLBH/+cyiKGQLVIqj7yu+71m2UQ148esE56ZIV3tiZHjlSDtx8M
	a84FwuKaou3LjzmRZ37KmGNKhgxFhxkaP7JjMMALKev4zbNIs2sX0aMinsYlH/XgVhjoXC7axJg2d
	p3XZplvwAK6Ku9IZZpiX7klDbCQuF3Iq8yyE2J49MNVjATM/2F9GATY7SlvbqkSWMm34Td4wJNoSa
	qYSXk6Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIPa-0000000DKrB-2WMK;
	Mon, 27 Oct 2025 08:17:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIPX-0000000DKqn-3XAg
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 08:17:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 76B4A227A87; Mon, 27 Oct 2025 09:16:58 +0100 (CET)
Date: Mon, 27 Oct 2025 09:16:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251027081658.GA15229@lst.de>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com> <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com> <20251027074922.GA14543@lst.de> <20251027075738.GF12554@unreal> <20251027081142.GG12554@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027081142.GG12554@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_011704_021127_94648770 
X-CRM114-Status: GOOD (  13.26  )
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

On Mon, Oct 27, 2025 at 10:11:42AM +0200, Leon Romanovsky wrote:
> BTW, one can reorganize pci_p2pdma_map_type to make sure that
> PCI_P2PDMA_MAP_BUS_ADDR will be 2 and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
> will be 3, so it will be possible to take 2 bits per-type instead of 3.

Maybe.  I'd be happy to leave this as-is and then see if we can optimize
things once we grow more users.


