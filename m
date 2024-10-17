Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B04CD374A4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 15:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1EQgfYVRTUQXNr9PqmGiofT1Tw+sqL7NE/zWcAwSmtc=; b=mWx0UYoqnGke7pCAAsDzB2jfA8
	PU+Zl1iYh4cYwmumV/yB67hGB1ee8dLSlq2RooWo8cP6E5l1KXjvjPMjsEdiYlAfUdFYi18XvZI5B
	O+5yRmZnWKKscRkYxWyjTb1b3GYarGPtmgRxNNfye/MYjxxXOSn2Y9tG+vrizOnwd8R+NJfGXxq7z
	P2SkrnLT/9YREWHvHu54gbfeWPDRssE13xKzDlsWYtHztpnKmGWzzUQVRb+k3crJn9izIki2Hu+ww
	9957WvE6mIsBkG8T1LwUWFUuxYq6WlhVf7HHlNdKgjUD9X5Tcyoa7FEipjKxafz5C0/iZLpTDWz0k
	L9ISgagw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SLp-0000000FGfE-1Moh;
	Thu, 17 Oct 2024 15:23:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SLl-0000000FGe6-3vJ5
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 15:23:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 32601227A8E; Thu, 17 Oct 2024 17:23:37 +0200 (CEST)
Date: Thu, 17 Oct 2024 17:23:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	hare@suse.de, sagi@grimberg.me, martin.petersen@oracle.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241017152336.GA25327@lst.de>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com> <20241015055006.GA18759@lst.de> <8be869a7-c858-459a-a34b-063bc81ce358@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8be869a7-c858-459a-a34b-063bc81ce358@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_082342_288507_C7E212B4 
X-CRM114-Status: GOOD (  28.41  )
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

On Thu, Oct 17, 2024 at 08:05:38PM +0530, Kanchan Joshi wrote:
> Seems per-I/O hints are not getting the love they deserve.
> Apart from the block device, the usecase is when all I/Os of VM (or 
> container) are to be grouped together or placed differently.

But that assumes the file system could actually support it.  Which
is hard when you don't assume the file system isn't simply a passthrough
entity, which will not give you great results.

> > 2) A per-I/O interface to set these temperature hint conflicts badly
> > with how placement works in file systems.  If we have an urgent need
> > for it on the block device it needs to be opt-in by the file operations
> > so it can be enabled on block device, but not on file systems by
> > default.  This way you can implement it for block device, but not
> > provide it on file systems by default.  If a given file system finds
> > a way to implement it it can still opt into implementing it of course.
> 
> Why do you see this as something that is so different across filesystems 
> that they would need to "find a way to implement"?

If you want to do useful stream separation you need to write data
sequentially into the stream.  Now with streams or FDP that does not
actually imply sequentially in LBA space, but if you want the file
system to not actually deal with fragmentation from hell, and be
easily track what is grouped together you really want it sequentially
in the LBA space as well.  In other words, any kind of write placement
needs to be intimately tied to the file system block allocator.

> Both per-file and per-io hints are supplied by userspace. Inode and 
> kiocb only happen to be the mean to receive the hint information.
> FS is free to use this information (iff it wants) or simply forward this 
> down.

As mentioned above just passing it down is not actually very useful.
It might give you nice benchmark numbers when you basically reimplement
space management in userspace on a fully preallocated file, but for that
you're better of just using the block device.  If you actually want
to treat the files as files you need full file system involvement.

> Per-file hint just gets stored (within inode) without individual FS 
> involvement. Per-io hint follows the same model (i.e., it is set by 
> upper layer like io_uring/aio) and uses kiocb to store the hint. It does 
> not alter the stored inode hint value!

Yes, and now you'll get complaints that the file system ignores it
when it can't properly support it.  This is why we need a per-fop
opt in.

> The generic code (like fs/direct-io.c, fs/iomap/direct-io.c etc.,) 
> already forwards the incoming hints, without any intelligence.

Yes, and that is a problem.  We stopped doing that, but Samsung sneaked
some of this back in recently as I noticed.

> Overall, I do not see the conflict. It's all user-driven. No?

I have the gut feeling that you've just run benchmarks on image files
emulating block devices and not actually tried real file system workloads
based on this unfortunately.


