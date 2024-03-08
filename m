Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66110C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sqW1RZlRn8VE5dU9gLvFISD/BVCOVSAorKQLlv0286g=; b=VHi9+AdHzbF3RyBl992gtAakqW
	t6lRpAQ2TlsbBCiZsnWkuXvnCMpFOIZyw0mNcot3RvvID7lJczyPTQMPC8syumsU30irRthMnDRSL
	67wXEBT5RIRC42hMe+3Q23uPGUV33qWLRmgn5hgk33sySoXhM9UfSjlRZA1H5JiWeifXLJxIfftmy
	5NolB5iyHn9WYciM3nSLvVupJPhin/p3MggzEu6zHKqHDScpNaLXkWsVjCFSHtC98nxjMH+KKvs3v
	csB9KSqpqctXuWTxEwsC3rnWnI2gArDTdZacTrvM4DGVLHMZGLHWbiY3Doat5OOlzf3zdUBp+dSEy
	iqK8DdRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ric3e-00000009peq-49j7;
	Fri, 08 Mar 2024 15:22:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ric3d-00000009pe3-2P33
	for linux-nvme@bombadil.infradead.org;
	Fri, 08 Mar 2024 15:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sqW1RZlRn8VE5dU9gLvFISD/BVCOVSAorKQLlv0286g=; b=qKhwXMv6+a0RSGsQ1LrPEoX8d6
	UTrUTiBozmnbkmAvbrTr60y+A0m27gYoYmfYsVJdZmi1SOlzxZgjvaFfAgSn+6R+B84g/2AikJ2hD
	3E77vlGCJWw23AUm9HfZCs2D4+LIavxEKjBIBTh6Uw+BaIIboIAbsyT5VG0D80VMTqih047ADHLZH
	/vuJbvibSJh9k2mrDHy6qew924x4K2x233saMpONYmWXFbIStnaO37q9YGZwfttgsINCI8AGjh0Ui
	mG7RM+y/BoLwAK0bIqgeVOH00caw89Jf0gMO4W2lCgmYz4GHEgZYeVfaO6XiUkglObdTkY61G/Sc7
	+3Bo/QEw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ric3a-00000007KDb-2fdj
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 15:22:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A990268BEB; Fri,  8 Mar 2024 16:22:44 +0100 (CET)
Date: Fri, 8 Mar 2024 16:22:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/10] block: move discard checks into the ioctl handler
Message-ID: <20240308152244.GC11963@lst.de>
References: <20240307151157.466013-1-hch@lst.de> <20240307151157.466013-3-hch@lst.de> <ZeoylEeVMt2fXT2R@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeoylEeVMt2fXT2R@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_152246_902956_966C9DC3 
X-CRM114-Status: GOOD (  16.70  )
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

On Fri, Mar 08, 2024 at 08:33:08AM +1100, Dave Chinner wrote:
> >  static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
> >  		unsigned long arg)
> >  {
> > +	sector_t bs_mask = (bdev_logical_block_size(bdev) >> SECTOR_SHIFT) - 1;
> > +	sector_t sector, nr_sects;
> 
> This changes the alignment checks from a hard coded 512 byte sector
> to the logical block size of the device. I don't see a problem with
> this (it fixes a bug) but it should at least be mentioned in the
> commit message.

Before the exact block size alignment check as done down in
__blkdev_issue_discard, it just moves up here now.  I guess I need to
make that more clear in the commit message.

