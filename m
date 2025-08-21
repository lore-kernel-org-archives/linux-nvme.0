Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259A4CA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 10:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NCTrY68Isy4+4DVcq5+bo/8IyvZ/XyrSwp+icM+UEAk=; b=QR3CUwuouwymelxEQlcswuUd+O
	OqnK+VizKxV3B89UT/LyfYvY6hwEYtUyLf+lrpYHsWom8C8StFa0SMGnA8WjCQCtyfqrtlJArZqZJ
	FfJhjMbFTvkh1j2YJATvH42+wmMkzJVzFPQfV110a0GEimxyYMCUQQqSGztfZjivm1pKZTsXFpbae
	U8zhUI3R1RBKgM2lGJRuVWHZ5bkdqMMmRgZLGeQ93BJhmTjP59DV9T1qnVju7NJHtqGO3pezaPF2+
	Yk65qfD9N8fcLEz5MHvNmqIxMY/J8GrdNJAII5/+5PJrl6e/t8fnqRwAbeghLZHuIXISeK3XTXbBD
	fLMLKXKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up2aF-0000000Gcd5-2y2Y;
	Thu, 21 Aug 2025 10:31:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up0oW-0000000GHKy-3dyB
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 08:38:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AC6F227A88; Thu, 21 Aug 2025 10:38:24 +0200 (CEST)
Date: Thu, 21 Aug 2025 10:38:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu, nilay@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org, mcgrof@infradead.org
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
Message-ID: <20250821083824.GC29224@lst.de>
References: <20250820150220.1923826-1-john.g.garry@oracle.com> <aKZDRrfUTxJoFA1m@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKZDRrfUTxJoFA1m@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_013829_043115_15E095FE 
X-CRM114-Status: GOOD (  20.25  )
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

On Wed, Aug 20, 2025 at 03:51:02PM -0600, Keith Busch wrote:
> On Wed, Aug 20, 2025 at 03:02:20PM +0000, John Garry wrote:
> > It would be preferred to stop honouring AWUPF altogether, but this may
> > needlessly disable atomic write support for many "good" devices which
> > only specify AWUPF. Currently all validation of controller-related
> > atomics limits is dropped.
> 
> These "good" devices that only report AWUPF, is there some set of
> characteristics that generally applies to all of them? I tried to list
> out conditions for when I think the value could be counted on here:
> 
>   https://lore.kernel.org/linux-nvme/aGvuRS8VmC0JXAR3@kbusch-mbp/
> 
> I just don't know if you know of any devices where that criteria doesn't
> git. If not, maybe we can work with that without introducing more user
> knobs.

Given how broken the field is I'd rather not make any general exception.
If you want to use a device claiming that you use the override and you
are responsible.  NAWUPF has been added in Linux 1.2, and the brokenness
of AWUPF should have been obvious to firmware engineers ever since they
had to deal with multiple LBA formats.  There's really no excuse for not
supporting the sane version that is a trivial firmware addition.

