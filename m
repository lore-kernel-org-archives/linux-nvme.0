Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C413D2E010
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 05:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3gPqoV5Dvb1Z2tcotWQMt8v+gnnzAwMIpCQYKpfSu8Q=; b=F03H+SYp5byNW9vh6C6QaiXPRC
	+GAwZALJrdz78HEcu939kmEWsgb5eb3t0bq3+Ghf4kPQ9z0aO8z0m40Yi68BXIZmSZwCF7Z5+oa31
	Ov51KsaywBYckGwQbv7J7lCD7X8PwlQX/b5NJs9KAiY5AEDtLsJCMxkKQbhIxMCssEjCQMFgovIev
	pFy/aqBXoisoEnb9QksHAQr+KVYr4nn1hHUsvTnn8WLKGZF0I/HoBcUqwrp976IiOsSXZklEqAfoe
	lx3y89aA7pMVnm9FxP4xDjSfrvTZ4OawDVMPhjHst5Unvyrdoe8pScbeaapCTT5jEH2kP2nqNbIEm
	aD8pcCRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Tqs-0000000D2RV-1nnP;
	Wed, 23 Oct 2024 05:24:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Tqp-0000000D2R2-3Ht7
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 05:24:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFAC8227A87; Wed, 23 Oct 2024 07:24:03 +0200 (CEST)
Date: Wed, 23 Oct 2024 07:24:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Prashant Malani <pmalani@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without
 requiring namespaces
Message-ID: <20241023052403.GC1341@lst.de>
References: <20241016213108.549000-1-abhishekbapat@google.com> <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com> <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com> <Zxe8e2zS5dA61Jou@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxe8e2zS5dA61Jou@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_222407_986098_442BDE31 
X-CRM114-Status: GOOD (  18.86  )
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

On Tue, Oct 22, 2024 at 08:53:47AM -0600, Keith Busch wrote:
> You'd may want to know max_sectors_kb, dma_alignment, nr_requests,
> virt_boundary_mask. Maybe some others.
> 
> The request_queue is owned by the block layer, so that seems like an
> okay place to export it, but attached to some other device's sysfs
> directory instead of a gendisk.
> 
> I'm just suggesting this because it doesn't sound like this is an nvme
> specific problem.

Well, it's a problem specific to passthrough without a gendisk, which is
the NVMe admin queue and the /dev/sg device.  So it's common-ish :)


Note that for the programs using passthrough sysfs isn't actually a very
good interface, as finding the right directory is pain, as is opening,
reading and parsing one ASCIII file per limit.

One thing I've been wanting to do also for mkfs tools and similar is a
generic extensible ioctl to dump all the queue limits.  That's a lot
easier and faster for the tools and would work very well here.

Note that we could still be adding new limits at any point of time
(although I have a hard time thinking what limit we don't have yet),
so we still can't guarantee that non-trivial I/O will always work.

