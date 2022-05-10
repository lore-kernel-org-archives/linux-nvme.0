Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F7CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 07:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3nF8Vv5UiEVhFaFwLplL0T+3RDDK+uyS8iI4cMHdqOw=; b=ApnmReTD5DesBqPCU5VgMOqlj7
	Ib2c+0OrlOsgrZ1mcvlsoBxjhBB61Uas4Yw2wv06GZPKaq3cAvKmqKMFi3AFnMkdsLg2pmr19DuKP
	2LXGyNaCjN2g/WBHBksLC0/oCo5VUEIEuTRlqIxhFP59kYY1ecl/Msd2YjrUjUW3wvt9O3msvobpz
	tYLqXp9zJ1JDR0ehiXb7yqglwezmuOBVf25i3RLYhhhSREPCdmXzHzxg5JgyI6EEiXjKrKLCHkO76
	Vq/+kUPlN7JdC/T2OSWjHELlo7hh20o6ZpEkqa/SvVd4rMrfVF/CnwPfW4CmDFVSO9lN4TwJDwY6A
	1SwzBVlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noJuf-000GgV-Qh; Tue, 10 May 2022 07:04:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noJud-000Gfj-Ic
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 07:04:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B31E468AFE; Tue, 10 May 2022 09:03:56 +0200 (CEST)
Date: Tue, 10 May 2022 09:03:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <20220510070356.GA11660@lst.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
 <20220428143603.GA20460@lst.de>
 <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
 <20220428150644.GA22685@lst.de>
 <676c02ef-4bbc-43f3-b3e6-27a7d353f974@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <676c02ef-4bbc-43f3-b3e6-27a7d353f974@t-8ch.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_000403_810240_FE0B842C 
X-CRM114-Status: GOOD (  25.78  )
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

On Thu, Apr 28, 2022 at 06:09:11PM +0200, Thomas Weißschuh wrote:
> > > On my hardware we start with a chunk_size of 4MiB and just allocate
> > > 8 (hmmaxd) * 4 = 32 MiB which is worse than 1 * 200MiB.
> > 
> > And that is because the hardware only has a limited set of descriptors.
> 
> Wouldn't it make more sense then to allocate as much memory as possible for
> each descriptor that is available?
> 
> The comment in nvme_alloc_host_mem() tries to "start big".
> But it actually starts with at most 4MiB.

Compared to what other operating systems offer, that is quite large.

> And on devices that have hmminds > 4MiB the loop condition will never succeed
> at all and HMB will not be used.
> My fairly boring hardware already is at a hmminds of 3.3MiB.
> 
> > Is there any real problem you are fixing with this?  Do you actually
> > see a performance difference on a relevant workload?
> 
> I don't have a concrete problem or performance issue.
> During some debugging I stumbled in my kernel logs upon
> "nvme nvme0: allocated 32 MiB host memory buffer"
> and investigated why it was so low.

Until recently we could not even support these large sizes at all on
typical x86 configs.  With my fairly recent change to allow vmap
remapped iommu allocations on x86 we can do that now.  But if we
unconditionally enabled it I'd be a little worried about using too
much memory very easily.

We could look into removing the min with
PAGE_SIZE * MAX_ORDER_NR_PAGES to try to do larger segments for
"segment challenged" controllers now that it could work on a lot
of iommu enabled setups.  But I'd rather have a very good reason for
that.

