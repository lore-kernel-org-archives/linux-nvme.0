Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1DAC433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 22:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4jsR3D1QJLtbgafUWHrGK7iVKVZ8bVVggvM2gjmUtQo=; b=U+BYcz8qKLGA91YGL8UWi0iUHU
	gX4aLfM8BlZGRG8ga40X8td8UGOEydztX4ElpYdNz9r72J5WeFdSwz2rh3WxSfc8fUfowSOQ9zAkY
	Jm9MWhUXrzCZ9Q+VevECbTNW0WdCN1G6OxJP6uUrAOuwtl/S8TIehNSQb2A4L9LZXKQD/bvbbP0DN
	7XF/avwRkO4IH/eF63dtt6Ghk/whvyv3s+1HsMym1+YoAsgGaGKq+sptXzfic6hAnqSAEBYxztpq/
	8F8fI+hcNR+s6LdzeEfCuMlehpJTHpRHXknZ/i+JXSMp9OOVRiwO+RjGQsv67MezGZ0ZX6ALJJ4gX
	s9qusksA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQGAd-00CBeR-JE; Fri, 04 Mar 2022 22:13:07 +0000
Received: from mail104.syd.optusnet.com.au ([211.29.132.246])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQGAa-00CBcr-6r
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 22:13:05 +0000
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au
 [49.186.17.0])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A7D2D52FBC4;
 Sat,  5 Mar 2022 09:12:56 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1nQGAR-001Zvp-Ep; Sat, 05 Mar 2022 09:12:55 +1100
Date: Sat, 5 Mar 2022 09:12:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
 linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Message-ID: <20220304221255.GL3927073@dread.disaster.area>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304175556.407719-2-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62228eea
 a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
 a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
 a=pB72X_AyP2OfXCB9ywQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_141304_433420_340059FA 
X-CRM114-Status: GOOD (  15.11  )
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

On Fri, Mar 04, 2022 at 06:55:56PM +0100, Christoph Hellwig wrote:
> With the NVMe support for this gone, there are no consumers of these hints
> left, so remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c                 |  2 --
>  block/blk-crypto-fallback.c |  1 -
>  block/blk-merge.c           | 14 --------------
>  block/blk-mq-debugfs.c      | 24 ------------------------
>  block/blk-mq.c              |  1 -
>  block/bounce.c              |  1 -
>  block/fops.c                |  3 ---
>  drivers/md/raid1.c          |  2 --
>  drivers/md/raid5-ppl.c      | 28 +++-------------------------
>  drivers/md/raid5.c          |  6 ------
>  fs/btrfs/extent_io.c        |  1 -
>  fs/buffer.c                 | 13 +++++--------
>  fs/direct-io.c              |  3 ---
>  fs/ext4/page-io.c           |  5 +----
>  fs/f2fs/data.c              |  2 --
>  fs/gfs2/lops.c              |  1 -
>  fs/iomap/buffered-io.c      |  2 --
>  fs/iomap/direct-io.c        |  1 -
>  fs/mpage.c                  |  1 -
>  fs/zonefs/super.c           |  1 -
>  include/linux/blk_types.h   |  1 -
>  include/linux/blkdev.h      |  3 ---
>  22 files changed, 9 insertions(+), 107 deletions(-)

AFAICT, all the filesystem/IO path passthrough plumbing for hints is
now gone, and no hardware will ever receive hints.  Doesn't this
mean that file_write_hint(), file->f_write_hint and iocb->ki_hint
are now completely unused, too?  That also means the fcntl()s for
F_{G,S}ET_FILE_RW_HINT now have zero effect on IO, so should they be
neutered, too?

AFAICT, this patch leaves just the f2fs allocator usage of
inode->i_rw_hint to select a segment to allocate from as the
remaining consumer of this entire plumbing and user API. Is that
used by applications anywhere, or can that be removed and so the
rest of the infrastructure get removed and the fcntl()s no-op'd or
-EOPNOTSUPP?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

