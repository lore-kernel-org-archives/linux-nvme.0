Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116CECF6ABF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jan 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pdn4XVVfc7tr1FkKGsU24Lq1L6n19W850kHj7O11v7A=; b=QOL6iNCgNGXcJFtcFTyryNW4Xd
	Hx0SQ+ROsm7+LLzetLlIDqHSB1mWPA2it9dfMHuE/P1afi0pw+NvDy9CVqDkw487eI0qHEXYjwgAy
	bxj76baG66/MJqORSpfm7pLCbSRNbACWCYXAiBXWRkA6OBErjrqhzWSqN4NducNO3oTQV8mYG5M2Y
	YMw3Fvpn2OmdTrMZtqRcCbG2aF75uMwa0BSdBw9zJppOiWMvlz5WbAD4bCoTOKSEZmu4Jzu57SwAm
	NlagfGrhczx6lFrrSg9DVChy6sqHf/4l9DsVxHMLQ9piU5NqoS4iFM6sXh+pY3pICs0RuelAVd3zz
	9uXmWzYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdn5T-0000000Gam8-0ZNu;
	Thu, 08 Jan 2026 10:17:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdn5P-0000000GalN-236E
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jan 2026 10:17:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D7E68227AAA; Thu,  8 Jan 2026 11:17:42 +0100 (CET)
Date: Thu, 8 Jan 2026 11:17:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>,
	Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
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
	Sagi Grimberg <sagi@grimberg.me>, houtao1@huawei.com
Subject: Re: [PATCH 02/13] PCI/P2PDMA: Fix the warning condition in
 p2pmem_alloc_mmap()
Message-ID: <20260108101742.GB24709@lst.de>
References: <20260107171724.GA432074@bhelgaas> <20260107203439.GA446340@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107203439.GA446340@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_021749_022869_B4DE13D5 
X-CRM114-Status: GOOD (  13.27  )
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

On Wed, Jan 07, 2026 at 02:34:39PM -0600, Bjorn Helgaas wrote:
> > 
> > Given that, I would ordinarily target the v6.20 merge window, but the
> > "ASAP" suggests more urgency.  Do you want one or both for v6.19?
> 
> I put the patches above on pci/p2pdma for v6.20 until I hear
> otherwise.

Sounds good, thanks!


