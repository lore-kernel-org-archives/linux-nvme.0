Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B040D2E9D3
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kntke6Ets8uVx9P8zvvUdhuKHEkFY0xl7Gkq55FR/HI=; b=QLcrZEkTfZdbgwwIeuoEo0vDpU
	ESEdtRtvJo5FsQcRpT2oeltVdEllB54nG2toneew/njsiOCWl8AdoN6ziKJfZHdhVX6KAfQOqjvBo
	7Qt7Oo1ail6VLipTM3O0FvZGYuQ5w/MjyA+KtqGFe8aeZLcZ6aikkZuhhQ8z1iOVjLT1ZvDny85Y9
	5IbpUdaPdrUdUOzzDnA9wVETqLzVH+bpJVyaBYjV6co7CCRzHmkgpFnukkMltsTFJu7Mmm8Oq0xAn
	VHBMJn4iPhbQM0iQKcE0avSXKpYyJYZLa839/HLPZHOJpWIvGjDuJhd9emZdqlr1y5IlwQtl18s2F
	WqNjW/Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARfe-0000000HH5Q-1Rc1;
	Mon, 11 Nov 2024 10:29:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARfb-0000000HH3k-3RI0
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:29:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C96168D09; Mon, 11 Nov 2024 11:29:15 +0100 (CET)
Date: Mon, 11 Nov 2024 11:29:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	javier.gonz@samsung.com, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv11 0/9] write hints with nvme fdp and scsi streams
Message-ID: <20241111102914.GA27870@lst.de>
References: <20241108193629.3817619-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108193629.3817619-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_022920_024483_BDCAB0E5 
X-CRM114-Status: GOOD (  20.36  )
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

On Fri, Nov 08, 2024 at 11:36:20AM -0800, Keith Busch wrote:
>   Default partition split so partition one gets all the write hints
>   exclusively

I still don't think this actually works as expected, as the user
interface says the write streams are contigous, and with the bitmap
they aren't.

As I seem to have a really hard time to get my point across, I instead
spent this morning doing a POC of what I mean, and pushed it here:

http://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/block-write-streams

The big differences are:

 - there is a separate write_stream value now instead of overloading
   the write hint.  For now it is an 8-bit field for the internal
   data structures so that we don't have to grow the bio, but all the
   user interfaces are kept at 16 bits (or in case of statx reduced to
   it).  If this becomes now enough because we need to support devices
   with multiple reclaim groups we'll have to find some space by using
   unions or growing structures
 - block/fops.c is the place to map the existing write hints into
   the write streams instead of the driver
 - the stream granularity is added, because adding it to statx at a
   later time would be nasty.  Getting it in nvme is actually amazingly
   cumbersome so I gave up on that and just fed a dummy value for
   testing, though
 - the partitions remapping is now done using an offset into the global
   write stream space so that the there is a contiguous number space.
   The interface for this is rather hacky, so only treat it as a start
   for interface and use case discussions.
 - the generic stack limits code stopped stacking the max write
   streams.  While it does the right thing for simple things like
   multipath and mirroring/striping is is wrong for anything non-trivial
   like parity raid.  I've left this as a separate fold patch for the
   discussion.

