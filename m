Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4D6C531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 05:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uNgK0Dw8bT4+ACHl9uiGmvZCvs2LRUQX0MM+PNrbWDE=; b=EEivj6i3IVL/Yf6+st82tvt0T9
	msEXkA0DkF8NEVVtA9B75n3LzevffZQ63STRULkFipIXeMFDuBoQ+wGrqK2d/e7e/+yAedIrQG0SH
	jnv23KbODfXLgYjqa+CG8btcpmiPTP0M40+gGEebsQipH0rpC5WJzUS4fNsMoeidg7eIY+mvewaZK
	JFA6M6gA6Qv5Kn1htIl+CWy+7S+manrKM4/GwVTZSuDRrK3nCGw+8GF5aaXM3sSPJz2x67Z2iSlgA
	eQDdsfC+KmPNDj10rIVwNlk1otYZgbH7xsqbzAXN/GFN6+jY9YrrxYPGUZ6gNl7g3jX6JU7NwXjE0
	M9TzreEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shN8S-0000000FMBL-1DhB;
	Fri, 23 Aug 2024 05:46:56 +0000
Received: from bee.tesarici.cz ([37.205.15.56])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shN8O-0000000FMAG-1TVZ
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 05:46:54 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 8F2631EF9C3;
	Fri, 23 Aug 2024 07:46:47 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724392007; bh=uNgK0Dw8bT4+ACHl9uiGmvZCvs2LRUQX0MM+PNrbWDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hArhfTxuJpmZy/QI44DOLL8nlhwSAV1Q8F1UtEyCSO5NL1kCOZK6ttzq/lQiWWDqe
	 kAiqXcUX5Po+oc4guRJNR8VCytBV0GoIM2NaVIfE9ooBlwUyBeVBRcCHgLCa1XUNpS
	 KehaezkcyCG6ZTGnxI8d5B4GMWWpoTVhQlHWNxUk1wxxYpQtFuY3zWJbyWloHjiXrb
	 luYwVGbGGPSdYtkVoJPjiA+jn+VuH+uHgwOZlATHnVlx+rftiKDO5m0Q0NdsrVZ2PL
	 5/FERS4zek5TReS9TUqMY7iJAHXNDkTNeDv5Xjyc1cljzjV9w2UCy2gEcke3KP2VBA
	 PmNuoJAC7O28Q==
Date: Fri, 23 Aug 2024 07:46:46 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Bart Van Assche <bvanassche@acm.org>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240823074646.555009d6@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB41577F000FD7A5EC70CF54D0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<f8bb65ed-cdf2-4d23-b794-765ce0b48a4b@acm.org>
	<SN6PR02MB41577F000FD7A5EC70CF54D0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_224652_565973_97FD6FD5 
X-CRM114-Status: GOOD (  19.24  )
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

On Fri, 23 Aug 2024 02:20:41 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Bart Van Assche <bvanassche@acm.org> Sent: Thursday, August 22, 2024 12:29 PM
> > 
> > On 8/22/24 11:37 AM, mhkelley58@gmail.com wrote:  
> > > Linux device drivers may make DMA map/unmap calls in contexts that
> > > cannot block, such as in an interrupt handler.  
> > 
> > Although I really appreciate your work, what alternatives have been
> > considered? How many drivers perform DMA mapping from atomic context?
> > Would it be feasible to modify these drivers such that DMA mapping
> > always happens in a context in which sleeping is allowed?
> >   
> 
> I had assumed that allowing DMA mapping from interrupt context is a
> long-time fundamental requirement that can't be changed.  It's been
> allowed at least for the past 20 years, as Linus added this statement to
> kernel documentation in 2005:
> 
>    The streaming DMA mapping routines can be called from interrupt context.
> 
> But I don't have any idea how many drivers actually do that. There are
> roughly 1700 call sites in kernel code/drivers that call one of the
> dma_map_*() variants, so looking through them all doesn't seem
> feasible.

Besides, calls from interrupt context are not the only calls which are
not allowed to schedule (e.g. lock nesting comes to mind). Even if we
agreed to make DMA mapping routines blocking, I believe the easiest way
would be to start adding DMA_ATTR_MAY_BLOCK until it would be used by
all drivers. ;-)

But most importantly, if streaming DMA could block, there would be no
need for a SWIOTLB, because you could simply allocate a bounce buffer
from the buddy allocator when it's needed.

Petr T

