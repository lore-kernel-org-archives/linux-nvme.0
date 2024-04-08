Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1D0CD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FDDqbeNGhoXcnFk6nkXqY1HUDUdyMKYatROs/wiu+Jo=; b=QCMHhu7vsYAVPJeEdk+a4/etv6
	KehrI2TaqvyB0IJPLynv+/cNUqnAzHjvz1EsQdGIxnSZxqrYWAZO4RI5aYHP0YAwXQazkbF+zDb/T
	35Wpmbzop6wZz6akoqhEIDqMS27I2GPA165+OY2GsRPU8TB7pk6rl+yB4KT5/NmLoJf8gkJP/J3KR
	g5ZEwiLxnzymXw/MEH+t12BoURopGzf9JBw8aTBku1KXoBZWNFskuaxjIz8ILV+3o8wvlt2RNYwMW
	/ukRZhjci/9NFRF9FBuppCNT1lmr+x5+o6BjqCW3QFBQt1Tn3f5NJa/59qjPwFPzEWL+Q1+aKDLLI
	hQNQZeGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtt8s-0000000GOcl-3Nc3;
	Mon, 08 Apr 2024 17:50:50 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtt8p-0000000GObq-3IQ1;
	Mon, 08 Apr 2024 17:50:47 +0000
Date: Mon, 8 Apr 2024 10:50:47 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
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
Message-ID: <ZhQud1NbO4aMt0MH@bombadil.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <ZgOXb_oZjsUU12YL@casper.infradead.org>
 <c4c0dad5-41a4-44b4-8f40-2a250571180b@oracle.com>
 <Zg7Z4aJtn3SxY5w1@casper.infradead.org>
 <f3c1d321-0dfc-466f-9f6a-fe2f0513d944@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c1d321-0dfc-466f-9f6a-fe2f0513d944@oracle.com>
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

On Fri, Apr 05, 2024 at 11:06:00AM +0100, John Garry wrote:
> On 04/04/2024 17:48, Matthew Wilcox wrote:
> > > > The thing is that there's no requirement for an interface as complex as
> > > > the one you're proposing here.  I've talked to a few database people
> > > > and all they want is to increase the untorn write boundary from "one
> > > > disc block" to one database block, typically 8kB or 16kB.
> > > > 
> > > > So they would be quite happy with a much simpler interface where they
> > > > set the inode block size at inode creation time,
> > > We want to support untorn writes for bdev file operations - how can we set
> > > the inode block size there? Currently it is based on logical block size.
> > ioctl(BLKBSZSET), I guess?  That currently limits to PAGE_SIZE, but I
> > think we can remove that limitation with the bs>PS patches.

I can say a bit more on this, as I explored that. Essentially Matthew,
yes, I got that to work but it requires a set of different patches. We have
what we tried and then based on feedback from Chinner we have a
direction on what to try next. The last effort on that front was having the
iomap aops for bdev be used and lifting the PAGE_SIZE limit up to the
page cache limits. The crux on that front was that we end requiring
disabling BUFFER_HEAD and that is pretty limitting, so my old
implementation had dynamic aops so to let us use the buffer-head aops
only when using filesystems which require it and use iomap aops
otherwise. But as Chinner noted we learned through the DAX experience
that's not a route we want to again try, so the real solution is to
extend iomap bdev aops code with buffer-head compatibility.

> We want a consistent interface for bdev and regular files, so that would
> need to work for FSes also. FSes(XFS) work based on a homogeneous inode
> blocksize, which is the SB blocksize.

There are two aspects to this and it is important to differentiate them.

1) LBA formats used
2) When a large atomic is supported and you want to use smaller LBA formats

When the LBA format, and so logical block size is say 16k, the LBS
patches with the above mentioned patches enable IOs to the block device
to be atomic to say 16k.

But to remain flexible we want to support a world where 512 byte and 4k
LBA formats are still used, and you *optionally* want to leverage say
16k atomics. Today's block device topology enables this only with a knob
to userspace to allow userspace to override the sector size for the
filesystem. In practice today if you want to use 4k IOs you just format
the drive to use 4k LBA format. However, an alternative at laest for
NVMe today is to support say 16k atomic with an 4k or 512 LBA format.
This essentially *lifts* the physical block size to 16k while keeping
the logical block size at the LBA format, so 4k or 512 bytes. What you
*could* do with this, from the userspace side of things is at mkfs you
can *opt* in to use a larger sector size up to the physical block size.
When you do this the block device still has a logical block size of the
LBA format, but all IOs the filesystem would use use the larger sector
size you opted in for.

I suspect this is a use case where perhaps the max folio order could be
set for the bdev in the future, the logical block size the min order,
and max order the large atomic.

> Furthermore, we would seem to be mixing different concepts here. Currently
> in Linux we say that a logical block size write is atomic. In the block
> layer, we split BIOs on LBS boundaries. iomap creates BIOs based on LBS
> boundaries. But writing a FS block is not always guaranteed to be atomic, as
> far as I'm concerned.

True. To be clear above paragraph refers to LBS as logical block size.

However when a filesystem sets the min order, and it should be respected.
I agree that when you don't set the sector size to 16k you are not forcing the
filesystem to use 16k IOs, the metadata can still be 4k. But when you
use a 16k sector size, the 16k IOs should be respected by the
filesystem.

Do we break BIOs to below a min order if the sector size is also set to
16k?  I haven't seen that and its unclear when or how that could happen.

At least for NVMe we don't need to yell to a device to inform it we want
a 16k IO issued to it to be atomic, if we read that it has the
capability for it, it just does it. The IO verificaiton can be done with
blkalgn [0].

Does SCSI *require* an 16k atomic prep work, or can it be done implicitly?
Does it need WRITE_ATOMIC_16?

[0] https://github.com/dagmcr/bcc/tree/blkalgn

> So just increasing the inode block size / FS block size does not
> really change anything, in itself.

If we're breaking up IOs when a min order is set for an inode, that
would need to be looked into, but we're not seeing that.

> > Do untorn writes actually exist in SCSI?  I was under the impression
> > nobody had actually implemented them in SCSI hardware.
> 
> I know that some SCSI targets actually atomically write data in chunks >
> LBS. Obviously atomic vs non-atomic performance is a moot point there, as
> data is implicitly always atomically written.
> 
> We actually have an mysql/innodb port of this API working on such a SCSI
> target.

I suspect IO verification with the above tool should prove to show the
same if you use a filesystem with a larger sector size set too, and you
just would not have to do any changes to userspace other than the
filesystem creation with say mkfs.xfs params of -b size=16k -s size=16k

> However I am not sure about atomic write support for other SCSI targets.

Good to know!

> > > We saw untorn writes as not being a property of the file or even the inode
> > > itself, but rather an attribute of the specific IO being issued from the
> > > userspace application.
> > The problem is that keeping track of that is expensive for buffered
> > writes.  It's a model that only works for direct IO.  Arguably we
> > could make it work for O_SYNC buffered IO, but that'll require some
> > surgery.
> 
> To me, O_ATOMIC would be required for buffered atomic writes IO, as we want
> a fixed-sized IO, so that would mean no mixing of atomic and non-atomic IO.

Would using the same min and max order for the inode work instead?

  Luis

