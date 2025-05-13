Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DC9C3ABC9
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zu1Bd4F/oo4L5xC/OUQ4NIMJhaczXT/wb7dV0dj7z8E=; b=CW0ZPO4BrrZV+matkUnCS5JygZ
	97WzGEt3LwuVscK1IqvoX6r5HUixXbh4Fq8RFlQthj/PoMj7FvxIKNU9piM5VMApGtmWrMfc0IlUU
	MnGIAFuE9p4LBWTt9IZyeAF19CfPo1F690V0oSSNretqai52/cEXKenRZ3H57S7B8MVcuZwD4gaxZ
	J9Uui1rSoK1OcrvLEYXllXhVORPM0HeDF5fGnG9j1p7gSfLw9DOkHLcye2ByoH4KfgwgQoKr2zprS
	lxZ3GNe07hIhXbxbtaTVOCZxO3Sx44Gif9G1dmKbF25CuCBY1cPb51fsJa69aSmF8XjVMi6RO5i91
	GdPl6DDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkQu-0000000Bh1u-1v76;
	Tue, 13 May 2025 07:52:12 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkOO-0000000BgUh-3nJS
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 07:49:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 21C05A4CAD5;
	Tue, 13 May 2025 07:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AB1C4CEE4;
	Tue, 13 May 2025 07:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747122571;
	bh=xu2XicHlHzyShUDfzKeZnNjK8PkUWcBuC9zaFAPI3vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=at5S7jGKpHZhdMn0zbBsDT5YjSpxYu/ZkUM1CDNDuWbDh/ZHdWdSBhJ36hkdh031d
	 +p6gWqUpyhyNZghEWrEXa9xND/Oa2FzFWUh2ucrDJkJHXdn/cRW8EmFwl16Ochc5V/
	 VLY3mqm6FrtSH1YXADDj+4AvouDTrLyiKvvj+Kx1qvX727g21XLM3T69pYFuoNU9GU
	 7R3TNgIkUEwfAwve9kKeUraRFhDMCwBPvfF1bKm7Ja6nDxUlJePx0NMG2EuwYSPIM4
	 2c7CjsJlk7gxmvnzDv+YA+cgnZuJdlVms4alEPFzTERqIfv1j76yVMmAKZ0MGXWdpm
	 NAXWjJck6h2FA==
Date: Tue, 13 May 2025 10:49:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool
 allocations
Message-ID: <20250513074926.GL22843@unreal>
References: <20250513070025.830930-1-hch@lst.de>
 <20250513070025.830930-6-hch@lst.de>
 <20250513073950.GJ22843@unreal>
 <20250513074041.GC2521@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513074041.GC2521@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_004937_030081_A8F93397 
X-CRM114-Status: GOOD (  12.26  )
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

On Tue, May 13, 2025 at 09:40:41AM +0200, Christoph Hellwig wrote:
> On Tue, May 13, 2025 at 10:39:50AM +0300, Leon Romanovsky wrote:
> > > +static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
> > > +		struct nvme_iod *iod)
> > > +{
> > 
> > You probably want __always_inline and not inline here.
> 
> I avoid that if I can.  People trying to use non-optimizing compiler
> flag deserve what they asked for :)

Right, but you are trying to sit on two seats here.

For users who uses normal compiler, this two line function will be
inlined anyway without need in extra "inline" keyword.
For users with "non-optimizing compiler", this "inline" keyword will do
nothing.

Thanks 

