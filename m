Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C77C67861
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKB/XK2+ZspoYCWJ5e9uu85ZD/ohSEghijO4GmecwRI=; b=zG/u4cHn+izKeAQt0BcOBem4hl
	waV8Nw1aGuSnMq4JmqHMwbg5KCAEIOoYeJkwKtDHhFhf+VmdQVy/N382hcGVLBOJkpYZHKzH11NwV
	S1H/2N/ldF5VV/ctZGfDQvZIV4ym3hhaHZv0nYiqYCWSBsjQL728u3UBEAXBXimVrjYwX5jMASPNp
	MvKO6RS7ObQlxloCZGyPluw8AizjHxojk5Zuf5dn7LkzbnPAAvzDAJp/sBd2vVp5MGnLffA9/sne/
	XAMpMQaUPTcSHCKDK6C3IAeAqFKSA48xZ36SGjMIqqoS4D1K4J/7Yr+vJxfqEF82Y53BwFhXQzpCL
	wldpFiJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsggj-00000006PNR-33bU;
	Fri, 05 Apr 2024 10:20:49 +0000
Received: from out-180.mta0.migadu.com ([2001:41d0:1004:224b::b4])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsggg-00000006PK3-0Da2
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 10:20:47 +0000
Date: Fri, 5 Apr 2024 06:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712312437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKB/XK2+ZspoYCWJ5e9uu85ZD/ohSEghijO4GmecwRI=;
	b=t3AqxFMdmrGtYQ9G8J216FgOVp7DHoc0Xl3/V6haSjRofA+J7YhhVeOOItBQf08WAumVMo
	nQF8ZnKnTLhSXGMG2LvUUMcNlI5s/Bj6jZIzc20XpDdSIHP81L8M5hslsOIXVeIolsY/ev
	xjIhfxlnC1KvRHF0mVQhDM3doE0Si7o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, 
	ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org, 
	io-uring@vger.kernel.org, nilay@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v6 00/10] block atomic writes
Message-ID: <62uvkga54im76lnz47nc2znoeayidp2tcwpffseqtl42xdwxlc@hep6ckbgpwqz>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <ZgOXb_oZjsUU12YL@casper.infradead.org>
 <ZgSCMXKtcYWhxR7e@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgSCMXKtcYWhxR7e@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_032046_292556_8C0E64DB 
X-CRM114-Status: GOOD (  33.94  )
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

On Thu, Mar 28, 2024 at 07:31:45AM +1100, Dave Chinner wrote:
> On Wed, Mar 27, 2024 at 03:50:07AM +0000, Matthew Wilcox wrote:
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
> > set the inode block size at inode creation time, and then all writes to
> > that inode were guaranteed to be untorn.  This would also be simpler to
> > implement for buffered writes.
> 
> You're conflating filesystem functionality that applications will use
> with hardware and block-layer enablement that filesystems and
> filesystem utilities need to configure the filesystem in ways that
> allow users to make use of atomic write capability of the hardware.
> 
> The block layer functionality needs to export everything that the
> hardware can do and filesystems will make use of. The actual
> application usage and setup of atomic writes at the filesystem/page
> cache layer is a separate problem.  i.e. The block layer interfaces
> need only support direct IO and expose limits for issuing atomic
> direct IO, and nothing more. All the more complex stuff to make it
> "easy to use" is filesystem level functionality and completely
> outside the scope of this patchset....

A CoW filesystem can implement atomic writes without any block device
support. It seems to me that might have been the easier place to start -
start by getting the APIs right, then do all the plumbing for efficient
untorn writes on non CoW filesystems...

