Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371CBE77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QWb4Fxp88OeLZfkFeT5VDf7jg5zphaE/upbXqFP1mN0=; b=EqUx731YR2uBoozJ6fwyXP5nRy
	U0e2Q1pRapuGwynMRBT8I7jds7iFBZqkdFKPN+FuSzm0lorSthYYwJunQwzPKavVgMfWBrRSr24zO
	r+w/m+LmXTev/dgWW/8QhCpJOAJAbQsEfYnhdwLK4jemAsRaus15sTv85e7BunBVbKuCLntw+c1Vq
	gNDcep3NWyEko7ImURSHMzQh27CvuAD1YnDpz2m53sPXwB3iQ4cgqSSPV1EL3zhfUOsrWJfuna/5d
	RfYh04gPoX8jF4N0JA0TX4Z3ytd+fvdD1VFOMFuPYwXvAd0b6tgQ1HKmgnqT+HsaFdGtxsI0VhqkR
	6bmtsOnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiSP-00000000VRy-3Rl9;
	Mon, 06 Jan 2025 08:27:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiSN-00000000VRX-0wui
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 08:27:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AE0968BFE; Mon,  6 Jan 2025 09:27:22 +0100 (CET)
Date: Mon, 6 Jan 2025 09:27:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <20250106082721.GB18408@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-2-dlemoal@kernel.org> <977ab809-ba06-4537-b568-cc25f56b5b7a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977ab809-ba06-4537-b568-cc25f56b5b7a@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_002727_426053_5C1DF619 
X-CRM114-Status: GOOD (  18.74  )
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

On Sat, Jan 04, 2025 at 09:56:14PM +0530, Nilay Shroff wrote:

[can you please quote your mails properly, having to scroll pages of
fullquotes isn't very readable]

> > +	if (entry->store) {
> > +		blk_mq_freeze_queue(q);
> > +		mutex_lock(&q->sysfs_lock);
> > +		res = entry->store(disk, page, length);
> > +		mutex_unlock(&q->sysfs_lock);
> > +		blk_mq_unfreeze_queue(q);
> > +		return res;
> > +	}
> > +
> Can we move ->sysfs_lock before freezing queue? We follow the locking order 
> of acquiring ->sysfs_lock before freeze lock. For instance, we've these 
> call sites (elevator_disable(), elevator_switch()) where we first acquire 
> ->sysfs_lock and then freezes the queue. It's OK if you think this patchset
> fixes locking order between limits lock and queue freeze and so we may address 
> it in another patch. 

sysfs_lock as-is doesn't make much sense.  The sysfs (actually kernfs)
core already serializes ->store and ->show calls vs themselves and
attribute removal, and the limits lock protects the actual limits.

The problem is that the block code also abuses the lock for various
other things, so this is non-trivial.

What I've done in my version of the series is to drop it just for the
limits method for now.


