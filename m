Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA14D3C549
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 05:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFCQw15HwRfB5rDZLwtZCBcm/VaxiR3E6QgaPMFTiN8=; b=F50QyoUyTeW/ZaisjzJmopYMDW
	m2L/XhRN7DyGabwbZ9uSih+dR/YceptYVJH7pyLLM3/TTtT9iuOfzLS3EDTAss2Y5LszRJDgHkXV4
	+9YUL7emlnhPtYHaFkyiu6gsxI3i8RUiXA8xsgQBnTX2h2RpiIFs6j+9j9sSmUI30PfpSuNvrs/j5
	5liiKlVIVHUPXOOg2tm/Ab0floBj6jJzhKRlxvTN8JXn1/zi1rrD3l+gMHjidkCxtbb1kS6lG2XKN
	3CKC+kxd833M0x4pK2vGLeUdRfyF+b4avX4QiuaoaIGr0tIE3hqMI8p9U6vOoZe2/SqVZotCMGLsC
	U621sqZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fGR-0000000Gvlx-1rF4;
	Fri, 18 Oct 2024 05:11:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fGO-0000000GvlT-2eja
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 05:11:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CDD9227A8E; Fri, 18 Oct 2024 07:10:57 +0200 (CEST)
Date: Fri, 18 Oct 2024 07:10:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme-loop: set blocking flag
Message-ID: <20241018051056.GC19831@lst.de>
References: <20241017172052.2603389-1-kbusch@meta.com> <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk> <ZxFRpdU-GI76uetA@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxFRpdU-GI76uetA@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_221100_836456_F66918C9 
X-CRM114-Status: GOOD (  15.48  )
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

On Thu, Oct 17, 2024 at 12:04:21PM -0600, Keith Busch wrote:
> > Looks fine to me, but might be worth looking at doing that a bit
> > differently so that the target loop driver can remain non-blocking
> > as it should be considerably more efficient.
> 
> That's what I first looked at, but it's too hard. Maybe if we can make a
> lookup that doesn't rely on searching the configfs group, but it's
> definitely not this nice one-liner patch. :)

Searching configfs in the I/O path sounds like a train wreck no matter
what.  I feel a bit bad for not noticing that earlier.

Let me see what I can do.

