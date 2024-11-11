Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A65D12D79
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 06:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TU7rc5F4sDv2Bt40kpja+49yRj8snEqKKh/cKXayOBs=; b=RYvIxXvb3gHWOJs8dajIK9Kjsp
	06sXqnZNv1+ROA3f7dlU9x72oK4a+pRjJT3Wmc0MPaQgj1YdgdXM80eGj8mqQ+HpcvTf0Jc5ijSTR
	8REOKq0kaRYga41AoE5vh11o4f+dwu3f0B4nzxJDkcBGig//jRRXb2EWV8M6ylyNWYs7MpmouCFQ/
	lUM/FfIcoOBIA+Uaxu0lxX+3BUYtIJkhJQQ35IgLa9dFHB8o83uj+cHKGCa7bYo3B8ofK+wTMHRFP
	YxWVZvKqAYtd2VfmCQ+xV22EjfwoUlL6f9mbe/30RCsonqPeklOgjN46e+1uhaKKxwgXd8SLLhMOv
	sB24ye9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAOEF-0000000GWhc-3whn;
	Mon, 11 Nov 2024 06:48:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAOEC-0000000GWhD-2J5a
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 06:48:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F32468C7B; Mon, 11 Nov 2024 07:48:41 +0100 (CET)
Date: Mon, 11 Nov 2024 07:48:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241111064841.GA24107@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp> <20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy4zgwYKB1f6McTH@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_224848_754713_85911681 
X-CRM114-Status: GOOD (  20.94  )
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

On Fri, Nov 08, 2024 at 08:51:31AM -0700, Keith Busch wrote:
> You're getting fragmentation anyway, which is why you had to implement
> gc.

A general purpose file system always has fragmentation of some kind,
even it manages to avoid those for certain workloads with cooperative
applications.

If there was magic pixies dust to ensure freespace never fragments file
system development would be solved problem :)

> You're just shifting who gets to deal with it from the controller to
> the host. The host is further from the media, so you're starting from a
> disadvantage.

And the controller is further from the application and misses a lot of
information like say the file structure, so it inherently is at a
disadvantage.

> The host gc implementation would have to be quite a bit
> better to justify the link and memory usage necessary for the copies

That assumes you still have to device GC.  If you do align to the
zone/erase (super)block/reclaim unit boundaries you don't.

> This xfs implementation also has logic to recover from a power fail. The
> device already does that if you use the LBA abstraction instead of
> tracking sequential write pointers and free blocks.

Every file system has logic to recover from a power fail.  I'm not sure
what kind of discussion you're trying to kick off here.

> I think you are underestimating the duplication of efforts going on
> here.

I'm still not sure what discussion you're trying to to start here.
There is very little work in here, and it is work required to support
SMR drives.  It turns out for a fair amount of workloads it actually
works really well on SSDs as well beating everything else we've tried.

