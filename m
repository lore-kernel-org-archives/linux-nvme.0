Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A08EC4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Apr 2024 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fsqo+TcihzvYrlHKzsufMdVp0+RBP5LCcQAVZASLf7k=; b=XuxFLmbFp6bLSozO80KM2bOuGn
	KUKxVPJg/LctXFvUDbM/pE1xMU375EjguVTDY78Dnx/DuIKJBz+4ug6X5UbFu38mGXjVIPY82ZrEL
	vbzrHctidxH9NVaDK37N8+VdPZ8RheU7Spt91BtVbNofSnQHWhH7KL/gJyn2gZk+G1MBBRgCBS/Z/
	ZBIgEoL55nyMo/Un6OF4xlJoy1r1rmKGEDeWNyfwu2n6zfYSM5cKkxZ38ZDtr41ryq0jE/mHOTUxJ
	KTxQCNBp4MOTeFySER7U/4qGam+85gWP7GMyMIqyr0HsJThjD9QALbLHMUwqdwmKLBKRyy//G/r6q
	FI2h+HTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rw6nv-00000006NVE-0XV4;
	Sun, 14 Apr 2024 20:50:23 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rw6no-00000006NUn-3vr6;
	Sun, 14 Apr 2024 20:50:17 +0000
Date: Sun, 14 Apr 2024 13:50:16 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: John Garry <john.g.garry@oracle.com>,
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
Message-ID: <ZhxBiLSHuW35aoLB@bombadil.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <ZgOXb_oZjsUU12YL@casper.infradead.org>
 <c4c0dad5-41a4-44b4-8f40-2a250571180b@oracle.com>
 <Zg7Z4aJtn3SxY5w1@casper.infradead.org>
 <f3c1d321-0dfc-466f-9f6a-fe2f0513d944@oracle.com>
 <ZhQud1NbO4aMt0MH@bombadil.infradead.org>
 <ZhYQANQATz82ytl1@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhYQANQATz82ytl1@casper.infradead.org>
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

On Wed, Apr 10, 2024 at 05:05:20AM +0100, Matthew Wilcox wrote:
> On Mon, Apr 08, 2024 at 10:50:47AM -0700, Luis Chamberlain wrote:
> > On Fri, Apr 05, 2024 at 11:06:00AM +0100, John Garry wrote:
> > > On 04/04/2024 17:48, Matthew Wilcox wrote:
> > > > > > The thing is that there's no requirement for an interface as complex as
> > > > > > the one you're proposing here.  I've talked to a few database people
> > > > > > and all they want is to increase the untorn write boundary from "one
> > > > > > disc block" to one database block, typically 8kB or 16kB.
> > > > > > 
> > > > > > So they would be quite happy with a much simpler interface where they
> > > > > > set the inode block size at inode creation time,
> > > > > We want to support untorn writes for bdev file operations - how can we set
> > > > > the inode block size there? Currently it is based on logical block size.
> > > > ioctl(BLKBSZSET), I guess?  That currently limits to PAGE_SIZE, but I
> > > > think we can remove that limitation with the bs>PS patches.
> > 
> > I can say a bit more on this, as I explored that. Essentially Matthew,
> > yes, I got that to work but it requires a set of different patches. We have
> > what we tried and then based on feedback from Chinner we have a
> > direction on what to try next. The last effort on that front was having the
> > iomap aops for bdev be used and lifting the PAGE_SIZE limit up to the
> > page cache limits. The crux on that front was that we end requiring
> > disabling BUFFER_HEAD and that is pretty limitting, so my old
> > implementation had dynamic aops so to let us use the buffer-head aops
> > only when using filesystems which require it and use iomap aops
> > otherwise. But as Chinner noted we learned through the DAX experience
> > that's not a route we want to again try, so the real solution is to
> > extend iomap bdev aops code with buffer-head compatibility.
> 
> Have you tried just using the buffer_head code?  I think you heard bad
> advice at last LSFMM.  Since then I've landed a bunch of patches which
> remove PAGE_SIZE assumptions throughout the buffer_head code, and while
> I haven't tried it, it might work.  And it might be easier to make work
> than adding more BH hacks to the iomap code.

I have considered it but the issue is that *may work* isn't good enough and
without a test plan for buffer-heads on a real filesystem this may never
suffice. Addressing a buffere-head iomap compat for the block device cache
is less error prone here for now.

  Luis

