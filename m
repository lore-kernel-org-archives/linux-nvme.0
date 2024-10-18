Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE0FD3C549
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jva+lr6xbJiZaFyPS6j+BbOWuj39vYH5o3n4jwZCKK0=; b=FESVT5CwhCxTYbpo9B1MJxIDw/
	Xo+tzkBVzdibCvm8ubI42zczMsCFksxsiOvcyuI+TfZyW5KmXqFuWnuqY65Zcw/sp+xiRptX8u7FQ
	6Y3oxEcl8KkpfWgwTuzekk0ttf8D8si4Q/bfsmIwV+D4IQBnzpZn+N1Cp1PtdvirZimDBO2h+m/fs
	HQWBISllo5Ap++CI5bTLmK2DMSIuzv7QIw6D1AVFhle0ELd5LbOOxlxF/TM7R19QegQ4KrnafHdJb
	BEQTN6kX7rf4b2+S7U4IC1bCCNZmoG5mkMVe8+cy04dPMe6SwquLyh7TvKxfYi+EEM9G1z1JVbMPB
	JdFt7lrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fFo-0000000Gvfv-3zZL;
	Fri, 18 Oct 2024 05:10:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fFm-0000000GvfR-0Tkk
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 05:10:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE3DF227A8E; Fri, 18 Oct 2024 07:10:14 +0200 (CEST)
Date: Fri, 18 Oct 2024 07:10:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, Keith Busch <kbusch@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme-loop: set blocking flag
Message-ID: <20241018051014.GB19831@lst.de>
References: <20241017172052.2603389-1-kbusch@meta.com> <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_221022_324033_8AC4CF6A 
X-CRM114-Status: GOOD (  15.25  )
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

On Thu, Oct 17, 2024 at 11:39:24AM -0600, Jens Axboe wrote:
> On 10/17/24 11:20 AM, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Commit 505363957fad ("nvmet: fix nvme status code when namespace is
> > disabled") introduced a mutex lock in the io path for target. The loop
> > target connects this to the blk-mq submission side, so it requires the
> > blocking flag set so that queue_rq doesn't happen inside an rcu context.
> 
> Looks fine to me, but might be worth looking at doing that a bit
> differently so that the target loop driver can remain non-blocking
> as it should be considerably more efficient.

Yes.  When designing the nvmet code back in the day (gosh do I feel old)
we tried to avoid blocking in the main handling thread in general.

So if we can get rid of the mutex that would be great.


