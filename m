Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7F3C04FF6
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 21:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FRN0S0UrdEiWG4B5xuc/QvC+4jIMUlM9ivvZ43mxxCA=; b=coXtgArTbbMMZGZ0b2JakQ2W/R
	C1edhyftSrajA8RfJez3DazAVMlMy3HVocwwjLRfpCPVeEBWYn72EsxiZ0IPtYYUOyj2wqkHZotPp
	FwJeu8bguO5CNBJZpSbLrucjmVhE8LEKNoQvQcTfeMdwFTrF01ywfwRPMVeR+kJcBl1BvnQvdazLR
	peOKFKkhJjPCjPCRa9YzL0Na27df5C99JBvKs9l+SH5LWJoKT4kydFUwdHDwi0YB+HYbUiLzHkAN9
	7R8fp7sBXXRweLZCdrTPhCNeHYzR5qN6hEyKRnXcYtyeGHqNEAvBs02ygIGoba9lExgkrX1uSe2Pd
	C8+a0DHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwq53-0000000Dp2W-2tXN;
	Tue, 16 Apr 2024 21:11:05 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwq4z-0000000Dp1F-3nSD;
	Tue, 16 Apr 2024 21:11:01 +0000
Date: Tue, 16 Apr 2024 14:11:01 -0700
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
Message-ID: <Zh7pZUwmQXF-qC6D@bombadil.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <ZgOXb_oZjsUU12YL@casper.infradead.org>
 <c4c0dad5-41a4-44b4-8f40-2a250571180b@oracle.com>
 <Zg7Z4aJtn3SxY5w1@casper.infradead.org>
 <f3c1d321-0dfc-466f-9f6a-fe2f0513d944@oracle.com>
 <ZhQud1NbO4aMt0MH@bombadil.infradead.org>
 <ZhYQANQATz82ytl1@casper.infradead.org>
 <ZhxBiLSHuW35aoLB@bombadil.infradead.org>
 <Zh2ZptLxnwa_jtSk@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh2ZptLxnwa_jtSk@casper.infradead.org>
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

On Mon, Apr 15, 2024 at 10:18:30PM +0100, Matthew Wilcox wrote:
> On Sun, Apr 14, 2024 at 01:50:16PM -0700, Luis Chamberlain wrote:
> > On Wed, Apr 10, 2024 at 05:05:20AM +0100, Matthew Wilcox wrote:
> > > Have you tried just using the buffer_head code?  I think you heard bad
> > > advice at last LSFMM.  Since then I've landed a bunch of patches which
> > > remove PAGE_SIZE assumptions throughout the buffer_head code, and while
> > > I haven't tried it, it might work.  And it might be easier to make work
> > > than adding more BH hacks to the iomap code.
> > 
> > I have considered it but the issue is that *may work* isn't good enough and
> > without a test plan for buffer-heads on a real filesystem this may never
> > suffice. Addressing a buffere-head iomap compat for the block device cache
> > is less error prone here for now.
> 
> Is it really your position that testing the code I already wrote is
> harder than writing and testing some entirely new code?  Surely the
> tests are the same for both.

The compat code would only allow large folios for iomap, and use
buffer-heads for non-large folios, so nothing much would change except
a special wrapper.

> Besides, we aren't talking about a filesystem on top of the bdev here.
> We're talking about accessing the bdev's page cache directly.

Sure, but my concern was the lack of testing for buffer-head large
folios. While for iomap we'd at least have done the ton of work to
stress test testing large folios while testing XFS with it.

While the block device cache is not a proper full blown filesystem,
it just means since no filesystem has been tested with buffer heads with
large folios its a possible minefield waiting to explode due to lack of
testing.

Is writing a proper test plan for the block device cache code with
buffer-heads with large folios less work than writing the compat code
for the block device cache? I concede that I'm not sure.

I'm happy to try it out to see what blows up.

  Luis

