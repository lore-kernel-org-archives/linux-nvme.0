Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D9ACFD642
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QiA8bab2gSTtnOYPURRgtFfq07DQSxeH741s/Vj0WnU=; b=FmALY+Y2jZcTNyb0ITVGHPHx3G
	UNuGrTqazlRONkS2ZCah0DAkOF5UA4XmK2DU+CLjheq8u4ATFVzcgIbIx/noSSwoZNQbvSeRkGz0c
	ygL9b0y6WrtfGXKqeeVdKk7CSF3q2QgiQ64mHeUjtV6v7NRzOq9bm9YSoUQHLJh7E5o+8pc+DeHtM
	yzdNfW4zGeDhWmi8xMszHStuGc+S6i0TH0gs74Kv2Pyc0CVkcom5iHg85rXJJ8glMgnZGcUjo9YN4
	2orDFQo5P4smWmv0fb42jfpxZzwJTeiBvAxjlvWrC55T1bS574f18g0d3VzKEoJQkXFO0TFmuoA7E
	yrV5sM3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUhR-0000000F6or-0lMU;
	Wed, 07 Jan 2026 14:39:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUhO-0000000F6oH-0YZ6
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 14:39:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 36C0A227A87; Wed,  7 Jan 2026 15:39:42 +0100 (CET)
Date: Wed, 7 Jan 2026 15:39:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: Re: [PATCH 02/13] PCI/P2PDMA: Fix the warning condition in
 p2pmem_alloc_mmap()
Message-ID: <20260107143942.GB14904@lst.de>
References: <20251220040446.274991-1-houtao@huaweicloud.com> <20251220040446.274991-3-houtao@huaweicloud.com> <4a91cfe7-75f5-49a4-89a4-fd6717e7e9d2@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a91cfe7-75f5-49a4-89a4-fd6717e7e9d2@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_063946_309094_3AC1902B 
X-CRM114-Status: GOOD (  13.67  )
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

On Mon, Dec 22, 2025 at 09:50:18AM -0700, Logan Gunthorpe wrote:
> > Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> 
> Thanks for the fix
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Can we get these fixes queued up ASAP while discussing the new
feature?


