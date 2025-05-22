Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF2BC54E90
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNUKBRLHVtekLv2LGF89j426cIIKTS20uTaOfnvJeIw=; b=wQDu6iSmX8eU5jUNBt9lQZYoNJ
	W36HPU7pqhxVSmFaWcpUk7S+pT9qKWAmQFcoturpPXWn218Xz7B4AeSK04H2jGMvq1GPvCz+gKGwC
	8tIKAXkA/PPukOr1/iyzu+fd6yb8EE2vLPshZYVPdj2Wo+Fzj+YT4icPDE2j2x1xvc1kggr8bgCGo
	k6P5o2iMWgx4EhAmFjcqcfFVTx76uVzoxZ1/bvBFGSWrf0hfr5DDjBrZJxdKpgeeYYpw7IdA3hXYx
	9olor0RpGmb37GuJ7i4Hpv/01yX+yRuV1Y16kin8mB8/HfqyRbe39s/lIEUwG7LgrSxR/cIKC8NB9
	s9vLYLoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8w8-00000001c9k-208L;
	Thu, 22 May 2025 16:38:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8uQ-00000001bie-0k2A
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 16:36:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B6C096135E;
	Thu, 22 May 2025 16:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B34C4CEE4;
	Thu, 22 May 2025 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747931800;
	bh=japlrBVs3GNvjaE3jTX3f3XSzvTYr+WtDLNY0X32b8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMrqPPOlY7AujTvkCW9xVssk05jAKPryx//59+xbISnZtc+Td46xC8emJy3oCRkqj
	 iMZCeHuE8/vjo2aBGo0eSfE5QUtpKQHNKlT282kjEhbUvUQAKNysE2df/8k1yNu3cm
	 QC7eBPloWAZDjLJAwEshSuAWhFjwb3NtWwO6L5a/Fa0InqHM7gjLnMKO6m0T0tM8X7
	 xsfEMTBj/Uu1MNXLmJd9pAy1ttmGDwUWl+Hs1Bav8dnctrS6qwMxZSIrLljnYjLTv5
	 +rjz6hq3VtoJG7DnTaKzJ4w6olp6yL5ZSlKlH3/P50LOulsTz4hB/MJFe09Vmlj+Sq
	 gcM4BHJlL7nhA==
Date: Thu, 22 May 2025 10:36:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/5] block: add support for vectored copies
Message-ID: <aC9SlcN6gTIz0F2E@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-5-kbusch@meta.com>
 <4fdbe560-d646-496c-be51-49ea49d47449@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdbe560-d646-496c-be51-49ea49d47449@suse.de>
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

On Thu, May 22, 2025 at 03:58:18PM +0200, Hannes Reinecke wrote:
> On 5/22/25 00:31, Keith Busch wrote:
> > ---
> >   block/blk-lib.c         | 50 ++++++++++++++++++++++++----------
> >   block/ioctl.c           | 59 +++++++++++++++++++++++++++++++++++++++++
> >   include/linux/blkdev.h  |  2 ++
> >   include/uapi/linux/fs.h | 14 ++++++++++
> >   4 files changed, 111 insertions(+), 14 deletions(-)
> > 
> Any specific reason why this is a different patch, and not folded into
> patch 2? It really feels odd to continuously updating interfaces which
> have been added with the same patchset...

Sure, I can do that if that's preferred. I just started this as simple
as possible, and added new capabilities from there. I thought having the
patch set show the journey might make it easier to review. If the
evolving interfaces are not helping, though, I don't mind squashing them.
 
> >   	case BLKCPY:
> >   		return blk_ioctl_copy(bdev, mode, argp);
> > +	case BLKCPY_VEC:
> > +		return blk_ioctl_copy_vec(bdev, mode, argp);
> >   	case BLKZEROOUT:
> >   		return blk_ioctl_zeroout(bdev, mode, arg);
> >   	case BLKGETDISKSEQ:
> 
> And that makes it even worse; introducing two ioctls which basically do
> the same thing (or where one is actually a special case of the other)
> is probably not what we should be doing.

There are many interfaces that have a single vs vectored user input.
It's like read vs readv. The use cases I'm working with are in-kernel
though so I don't strongly need these user interfaces here, but it's
been great for testing. I developed some that would work well in
blktests, for example.

