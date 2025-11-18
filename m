Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EC3CED240
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 05:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+P+9vQvwGZ+z6ZJErE4dzU3GQPRyWhy7RzQcjvC7as=; b=cwIkBg+4YiSkifBZ/59i4/yNzQ
	4/hCcCWQdfJYmAlC+pP4G9RFULsUeUPmRfqi4ucBG/PNgUChXq7Gtt4FqyR/8WwH0zKmSaPUPiMDw
	EeBeIt3pbvFnfBy0qO1ueQWnJvLq9xzBmwzje27iu2UVnfH0b4ICLsyUF3qKTRGYZDG3/c6e7snlb
	yjtguGhiN3ccO7CxDWs5IPENMALZgsijoysQx/ou4/6O4zo2V/WGf41G4WP4fRNvYU7BGC3apS4eN
	WFzr307Pvd2nsTu1F2+DTZ9KJzFA6PK2F4AQ/ZEM4QFQkFG0JwDcDw7BFoTceQFK4Fi3o1g9mcM97
	K7iFlWGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE6q-0000000HPtL-45Sz;
	Tue, 18 Nov 2025 05:18:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE6o-0000000HPsr-0dRZ
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 05:18:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40E486732A; Tue, 18 Nov 2025 06:18:24 +0100 (CET)
Date: Tue, 18 Nov 2025 06:18:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to
 handle larger sizes
Message-ID: <20251118051823.GA21858@lst.de>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com> <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com> <aRt5DPnMwzDw8_dF@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRt5DPnMwzDw8_dF@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_211830_354169_06443FA8 
X-CRM114-Status: GOOD (  14.31  )
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

On Mon, Nov 17, 2025 at 12:35:40PM -0700, Keith Busch wrote:
> > +	size_t total_len;
> 
> Changing the generic phys_vec sounds fine, but the nvme driver has a 8MB
> limitation on how large an IO can be, so I don't think the driver's
> length needs to match the phys_vec type.

With the new dma mapping interface we could lift that limits for
SGL-based controllers as we basically only have a nr_segments limit now.
Not that I'm trying to argue for multi-GB I/O..

