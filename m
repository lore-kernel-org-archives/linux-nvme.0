Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB4EC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 17:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M77UyFZc/CQOenG5boLjqoc0qTJMwAANdJbVnxb68KE=; b=PLWTJl76dE9NGEvyc4g9lCRj/f
	m7NZQ5+uT5Y/ziBPMZLq7njexDA5ozKT4ReB6/OmyRCK65wI8TjP3D/80KKPN/qQhFfBu1sPkOk2M
	RlfAFRKu4aivNsuolaSiZOkpni8RWoq6wvURjXDSSqLYJc86BTcSP9XPcSaGxauSd1wa9pVBm6LJI
	1a562Hw8CP9uRY0w1gI56vzGCGiv2jKTCHjI+4QUuYd+niVGfyiUlXto4Gv0S2+5NW+5rShWY3VTb
	BtMYg/D+dwSvpqZqGSmo8RAYbO52TVTvs64JLJQvHe5R4NzuQttgvu2f6E6nBVKJRKyGyISW+yMm4
	JF8YZ9Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk7xO-0082eE-Uy; Thu, 28 Apr 2022 17:29:34 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nk7xL-0082dM-NY; Thu, 28 Apr 2022 17:29:31 +0000
Date: Thu, 28 Apr 2022 10:29:31 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de,
 naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
 johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
 chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 josef@toxicpanda.com, jonathan.derrick@linux.dev, agk@redhat.com,
 kbusch@kernel.org, kch@nvidia.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 04/16] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Message-ID: <YmrO+2sexVkJEaIr@bombadil.infradead.org>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a@eucas1p1.samsung.com>
 <20220427160255.300418-5-p.raghav@samsung.com>
 <eeb86052-399c-a79b-32ab-1ed1b2d05e07@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb86052-399c-a79b-32ab-1ed1b2d05e07@opensource.wdc.com>
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

On Thu, Apr 28, 2022 at 08:37:27AM +0900, Damien Le Moal wrote:
> Also, the entire premise of this patch series is that it is hard for
> people to support the unusable sectors between zone capacity and zone end
> for drives with a zone capacity smaller than the zone size.
> 
> Yet, here you do not check that zone capacity == zone size for drives that
> do not have a zone size equal to a power of 2 number of sectors. This
> means that we can still have drives with ZC < ZS AND ZS not equal to a
> power of 2. So from the point of view of your arguments, no gains at all.
> Any thoughts on this ?

You are right, a check should be added on bringup so that if npo2 is
used, zone cap == zone size. That should be added on the next iteration
of this patch.

  Luis

