Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942B5C369AB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yygSjtnOOHwCyqra8nQxYyv4DP3YJSkIpmF7nD0bVOw=; b=gFp/7OkScYSsOwuJ0X5lP0cfKb
	ok8IgwFoj88XuCs1QjBw1LCbQbUQlZzjPC8OuOWloDh4EoQNbQFZKwQoCowRWI/Z61xT99Sbg/8bY
	7iKLpfSddOpX8lEifllmnqhOashnt43PZOayHgKg1bQhEY5fUcVpFiYxyNcB9DfOpIKDtQXMWs08y
	xR7rdAa+CgB/jb+ZtvWQDY+woUhYiaT689nGUsMQn7YHKgzRRELLuOb4nJvu6P9WOM9sEVi7zmeIp
	XlgIUDDtkvuZCzz001+sIxrnU6bnRu0KlmxmUsRTGWXA0nPxvqoRqB3va3lzLDSP+e20U0BmayhA7
	nRnkQb7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6s7W-00000004SIB-0nKb;
	Mon, 21 Apr 2025 14:27:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6s7U-00000004SGw-0stj
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 14:27:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D274049DC4;
	Mon, 21 Apr 2025 14:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E351C4CEE4;
	Mon, 21 Apr 2025 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745245654;
	bh=cvWak/FtVDINlP3w9NFQgGGjoUQOizrqtoV6iLldsy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHuisIuLLblwEP7kaCgO4UtMmpqnbCSbl44+vPqLCDpXp0V4TbRjSrKR3whS2/UHf
	 lZXpuHyFEHn+6Ec/OlyzgV9SnKK9zZRU023yobcA8SvS1duXCWsFaAnEFEt5iwBVLo
	 wAWD/KQJhGpBVBDXTvyiG19QKbIG2K/TSmZ29iaHuF7rPao6L4phM++MI8rVlDrbmd
	 ZEHiHYGScbdNEnKNFvY/OZvatrNcDhcwwiB8FoDsV3I/NoNFvDttrJfHEAJ7XImFq9
	 pbuI9afbck6IgGjefBZh+Gk3HuMFyw7OxQfWJ6ThkZD2iTTElfnT+CuWBSQNpO4Nju
	 OKfNnhC4gBCkA==
Date: Mon, 21 Apr 2025 08:27:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme/pci: make PRP list DMA pools per-NUMA-node
Message-ID: <aAZV04hiWIz2UT2E@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20250420164653epcas5p10dba2c638655fd4b16c6553d5125a3a0@epcas5p1.samsung.com>
 <20250420164450.1144416-1-csander@purestorage.com>
 <be873f40-d3c4-4f0e-8b36-dc6e4f5bcf48@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be873f40-d3c4-4f0e-8b36-dc6e4f5bcf48@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_072736_274155_9A1A97F7 
X-CRM114-Status: GOOD (  11.08  )
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

On Mon, Apr 21, 2025 at 12:43:24PM +0530, Kanchan Joshi wrote:
> On 4/20/2025 10:14 PM, Caleb Sander Mateos wrote:
> > struct nvme_dev {
> >   	struct nvme_queue *queues;
> >   	struct blk_mq_tag_set tagset;
> >   	struct blk_mq_tag_set admin_tagset;
> >   	u32 __iomem *dbs;
> >   	struct device *dev;
> > -	struct dma_pool *prp_page_pool;
> > -	struct dma_pool *prp_small_pool;
> > +	struct nvme_prp_dma_pools prp_pools[MAX_NUMNODES];
> 
> I wonder if it is worth to make this dynamic using nr_node_ids?

Yeah, I think so. MAX_NUMNODES is derived from a config value that may
be much larger than what the platform actually has.

