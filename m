Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E2EC71136
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 04:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F/WUzN7oYKlWXJy/nMX0caFVtBYbRq3N97AxQ+2fwjw=; b=qtNk7Jol2sLbNofcXVPNAqHfsi
	0pyDZ5lBn+Y0/Zg5rQZm9YbwVLJXd64cLngW4ueemfHgnAvMRA4joYBYMI4pBwCkIlYXov+5A40uX
	8dAmfrcZ2uIUMA1WbhGlchMEBVIdKHGvlhjjYb8tOwMaKDKWu6jrazKyFe5FxNBLvLU74CVpnfbMr
	H4Jf5P1KohtMx94Bis0FQ4gUIjOcte6M3RO+vAMtjHSGeCkiczUBRs4koGMNcQbW2MiNeFbjswsah
	mJetHKP0lMWTPa6xDTNWD/bS7o21MgSown6sxPUU7nySKEgr/O2X7Jab7LrrcjfOyLT1q94tKi+Jb
	vk5pgYVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa1z-0000000CBFD-2S9o;
	Thu, 12 Jun 2025 04:59:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa0c-0000000CBBs-0eWY
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 04:57:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE55A68D09; Thu, 12 Jun 2025 06:57:43 +0200 (CEST)
Date: Thu, 12 Jun 2025 06:57:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20250612045743.GB12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-2-hch@lst.de> <aEhROl2D89kFX8C7@kbusch-mbp> <20250611034316.GA2869@lst.de> <aEmuG1dUDGuci7VW@kbusch-mbp> <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com> <aEmxn0K6m34HsZeN@kbusch-mbp> <88fe6154-6086-409d-a180-665d62d72d47@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fe6154-6086-409d-a180-665d62d72d47@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_215750_335887_08561CB1 
X-CRM114-Status: GOOD (  16.19  )
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

On Wed, Jun 11, 2025 at 01:41:54PM -0600, Logan Gunthorpe wrote:
> > Is there some other mechansim that ensures a host memory mapped IOVA
> > doesn't collide with a PCI bus address then?
> 
> Yes, in the absence of a switch with ACS protection this can be a problem.
>
> I haven't looked at this in a long time, but the iommu drivers reserve
> regions where the PCI addresses are valid so no iova will be allocated
> with a similar bus address. After a quick search, I believe today, this
> is handled by iova_reserve_pci_windows().

Exactly.

Fun side story:  the CMB decoding for commands in the NVMe spec relies on
this to not corrupt data as it tries to match an IOVA against a PCI bus
addresses.  A certain very big hypervisor vendor did not reserve the
space like this and it caused data corruption due to this broken nvme
feature.


