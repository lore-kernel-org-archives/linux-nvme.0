Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC62C02192
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RClxBeDxnInPkrWIfrxxWJhPe3rIyaC81xqYRby1cjQ=; b=KfW4K8fkoKLnzElkyfStj1qV3i
	jS38bzvbPcKuO9Um9EyJVbN2vsftKAntok8Mjf1lIX2WYQogZU9ZcSFGEu/yreyaJxtIQ7g8XowhO
	+XWLS5lnThj16d1foRkwAEgNuy9OJuEYlQVMdzZ5aME+xnBJHYnag7686LrrrI512GtuiESCX124T
	cPoKgy9yteiwaFvwm8UkRAVoRkWze2/Lfeh7LefT3WDhP8WkJBInPAbc08rf/f2obpOpS246XVkMA
	dG+rQZTZXj+5gexWNU22Oio81KdpyTv0/FmN58fa6hZGGyQQCRvL4SePnxKBbbaYNw5KChc7zIU/y
	0lDA3H3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfhZZ-00000003pEd-2NUD;
	Wed, 05 Feb 2025 15:44:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfhYj-00000003p45-15eN
	for linux-nvme@lists.infradead.org;
	Wed, 05 Feb 2025 15:43:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49C6E68BFE; Wed,  5 Feb 2025 16:43:21 +0100 (CET)
Date: Wed, 5 Feb 2025 16:43:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jianxiong Gao <jxgao@google.com>, Keith Busch <kbusch@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Robin Murphy <robin.murphy@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ryan Afranji <afranji@google.com>, linux-nvme@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Add an option for devices to skip SWIOTLB
 pre-copy on read.
Message-ID: <20250205154321.GB13814@lst.de>
References: <20250204233630.3407878-1-jxgao@google.com> <Z6MZLWRv1hC8uLo1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6MZLWRv1hC8uLo1@smile.fi.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250205_074325_444349_72A3888B 
X-CRM114-Status: GOOD (  17.85  )
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

On Wed, Feb 05, 2025 at 09:54:21AM +0200, Andy Shevchenko wrote:
> On Tue, Feb 04, 2025 at 11:36:27PM +0000, Jianxiong Gao wrote:
> > Removes an extra memory copy that occurs during IO read
> > operations through the SWIOTLB. During high throughput
> > read workloads, this extra copy is causing a lot of stress
> > on the SWIOTLB.
> > 
> > With high performance devices, for example NVMe devices,
> > the device will be overwriting the entire buffer.
> 
> Is this really guaranteed? I can imagine surprise power cut or
> hotplug event, for example, just in the middle of the transfer.

Many command can return less data than originally mapped.  Get Log Page
is an example that comes to mind that is heavily used that way.


