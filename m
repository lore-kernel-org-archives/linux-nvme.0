Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC67CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 16:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IAcMzbwzMSdGjUZJwsigBkmbiIdxzP3w50+Ad4sa5UQ=; b=neRc6AXmMoF0UcxlM69zZmzdj9
	ZJgpHFXAbsGkZYnQiH8q6uM+DZ5ht6/P3QUZqQsYTZRTIQmYD0dz360PUkVOYnvBCZ8Znxo2LbVQu
	SWkGRbGckpRWoFD1r9cXkWaq9xs9douOqVlzKtN01ZlhXVVrcrHSuQg5yF6UQqb0OfwBMkw46N/yJ
	NML3AChjZRX/xchUVTBqDD3xxtkWg8QSr3qlyyGxFTtJK9nR3tpbx/Cx1FmIoU4TJ52o83geEYBU6
	//nTXApqx1csuf5uy92KHzEwyC2a405xsNTjeHGfQi2xFCLLbW/IC37CiX4XoTPLXEJ6BC7UNzWuu
	nqplODqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsQGV-00000003XGB-1cNM;
	Thu, 04 Apr 2024 16:48:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsQGT-00000003XFl-2vB5
	for linux-nvme@bombadil.infradead.org;
	Thu, 04 Apr 2024 16:48:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IAcMzbwzMSdGjUZJwsigBkmbiIdxzP3w50+Ad4sa5UQ=; b=mZVvZ5QtSrlprrhnUVhWEWIU7E
	sphdhQo7g/IJfa+/FvwlZsRFYmJ5wkNkd4AWif4Utjy+vMZEnwOad5hHf+SRbN7FGKw+i0FGqJBM4
	yF2PaxBkNGMpqYBfoujAS+qFScyAlz3vNlovdCRtdSYfHINucazB4MwtfIsMPo5qEa0NQKwlFZIUA
	VfRN+/hUWdkFBdAGtszp5axo9ZNsq2cyjqNAFaNh3mFRGcmLETrtGXGf3qXwEZGqMoZx63OmbHyON
	JugVn8XGevOpUa3bOez65lUMoibZGmnJJ93pBOBTs99hw8DRim6xKVB8Vqfk/oU+BU912iDFwt/nX
	hMyfZDfA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsQGP-00000008SrU-2u2m;
	Thu, 04 Apr 2024 16:48:33 +0000
Date: Thu, 4 Apr 2024 17:48:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v6 00/10] block atomic writes
Message-ID: <Zg7Z4aJtn3SxY5w1@casper.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <ZgOXb_oZjsUU12YL@casper.infradead.org>
 <c4c0dad5-41a4-44b4-8f40-2a250571180b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c0dad5-41a4-44b4-8f40-2a250571180b@oracle.com>
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

On Wed, Mar 27, 2024 at 01:37:41PM +0000, John Garry wrote:
> On 27/03/2024 03:50, Matthew Wilcox wrote:
> > On Tue, Mar 26, 2024 at 01:38:03PM +0000, John Garry wrote:
> > > The goal here is to provide an interface that allows applications use
> > > application-specific block sizes larger than logical block size
> > > reported by the storage device or larger than filesystem block size as
> > > reported by stat().
> > > 
> > > With this new interface, application blocks will never be torn or
> > > fractured when written. For a power fail, for each individual application
> > > block, all or none of the data to be written. A racing atomic write and
> > > read will mean that the read sees all the old data or all the new data,
> > > but never a mix of old and new.
> > > 
> > > Three new fields are added to struct statx - atomic_write_unit_min,
> > > atomic_write_unit_max, and atomic_write_segments_max. For each atomic
> > > individual write, the total length of a write must be a between
> > > atomic_write_unit_min and atomic_write_unit_max, inclusive, and a
> > > power-of-2. The write must also be at a natural offset in the file
> > > wrt the write length. For pwritev2, iovcnt is limited by
> > > atomic_write_segments_max.
> > > 
> > > There has been some discussion on supporting buffered IO and whether the
> > > API is suitable, like:
> > > https://lore.kernel.org/linux-nvme/ZeembVG-ygFal6Eb@casper.infradead.org/
> > > 
> > > Specifically the concern is that supporting a range of sizes of atomic IO
> > > in the pagecache is complex to support. For this, my idea is that FSes can
> > > fix atomic_write_unit_min and atomic_write_unit_max at the same size, the
> > > extent alignment size, which should be easier to support. We may need to
> > > implement O_ATOMIC to avoid mixing atomic and non-atomic IOs for this. I
> > > have no proposed solution for atomic write buffered IO for bdev file
> > > operations, but I know of no requirement for this.
> > 
> > The thing is that there's no requirement for an interface as complex as
> > the one you're proposing here.  I've talked to a few database people
> > and all they want is to increase the untorn write boundary from "one
> > disc block" to one database block, typically 8kB or 16kB.
> > 
> > So they would be quite happy with a much simpler interface where they
> > set the inode block size at inode creation time,
> 
> We want to support untorn writes for bdev file operations - how can we set
> the inode block size there? Currently it is based on logical block size.

ioctl(BLKBSZSET), I guess?  That currently limits to PAGE_SIZE, but I
think we can remove that limitation with the bs>PS patches.

> > and then all writes to
> > that inode were guaranteed to be untorn.  This would also be simpler to
> > implement for buffered writes.
> 
> We did consider that. Won't that lead to the possibility of breaking
> existing applications which want to do regular unaligned writes to these
> files? We do know that mysql/innodb does have some "compressed" mode of
> operation, which involves regular writes to the same file which wants untorn
> writes.

If you're talking about "regular unaligned buffered writes", then that
won't break.  If you cross a folio boundary, the result may be torn,
but if you're crossing a block boundary you expect that.

> Furthermore, untorn writes in HW are expensive - for SCSI anyway. Do we
> always want these for such a file?

Do untorn writes actually exist in SCSI?  I was under the impression
nobody had actually implemented them in SCSI hardware.

> We saw untorn writes as not being a property of the file or even the inode
> itself, but rather an attribute of the specific IO being issued from the
> userspace application.

The problem is that keeping track of that is expensive for buffered
writes.  It's a model that only works for direct IO.  Arguably we
could make it work for O_SYNC buffered IO, but that'll require some
surgery.

> > Who's asking for this more complex interface?
> 
> It's not a case of someone specifically asking for this interface. This is
> just a proposal to satisfy userspace requirement to do untorn writes in a
> generic way.
> 
> From a user point-of-view, untorn writes for a regular file can be enabled
> for up to a specific size* with FS_IOC_SETFLAGS API. Then they need to
> follow alignment and size rules for issuing untorn writes, but they would
> always need to do this. In addition, the user may still issue regular
> (tearable) writes to the file.
> 
> * I think that we could change this to only allow writes for that specific
> size, which was my proposal for buffered IO.
> 
> Thanks,
> John
> 

