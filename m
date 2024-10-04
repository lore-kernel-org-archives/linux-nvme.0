Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFABCFA745
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 05:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=krIJ/7Xkumosckw9QlRmBKkVjGlcSrcqvYLCkRLS6Yg=; b=rLcfFqcnEL7/qQeZjTmJDtv7jG
	Wr1vdCAi7QvrSj4Ab7vqrEqF3ORWyGCNhwbV7MDb6rWMaVB37L9m0UW7MzAAWPqcR5V1ROEla3ZFS
	GfWEA9zSH8hcHB5kwprh5jU7fPck5TJgUChehu/HT4uvA38Yr1c1TpECNgzm297y2KhJvTJFpuWPh
	2hkseDP8uGxylgceq38WOyQCJcaMBNhObaRxlcIxcKsViUT5SvNYdlwgS4m/bVnsBQ6EhTo3Sz2OQ
	22EqfXGgfsxmqtTUiGuDKS2fUTpNd72HfbsFSlkaxbRBJ+VQRswVU6s+aBgZc6nBF+ToNo69Er55T
	jn3g7XIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swaud-0000000B441-1hSz;
	Fri, 04 Oct 2024 05:31:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swaua-0000000B43D-3avG
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 05:31:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2B83227A87; Fri,  4 Oct 2024 07:31:21 +0200 (CEST)
Date: Fri, 4 Oct 2024 07:31:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241004053121.GB14265@lst.de>
References: <20241001092047.GA23730@lst.de> <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk> <20241002075140.GB20819@lst.de> <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk> <20241002151344.GA20364@lst.de> <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com> <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com> <20241003125400.GB17031@lst.de> <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_223133_130997_2DF59082 
X-CRM114-Status: GOOD (  27.47  )
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

On Thu, Oct 03, 2024 at 04:14:57PM -0600, Jens Axboe wrote:
> On 10/3/24 6:54 AM, Christoph Hellwig wrote:
> > For file: yes.  The problem is when you have more files than buckets on
> > the device or file systems.  Typical enterprise SSDs support somewhere
> > between 8 and 16 write streams, and there typically is more data than
> > that.  So trying to group it somehow is good idea as not all files can
> > have their own bucket.
> > 
> > Allowing this inside a file like done in this patch set on the other
> > hand is pretty crazy.
> 
> I do agree that per-file hints are not ideal. In the spirit of making
> some progress, how about we just retain per-io hints initially? We can
> certainly make that work over dio. Yes buffered IO won't work initially,
> but at least we're getting somewhere.

Huh?  Per I/O hints at the syscall level are the problem (see also the
reply from Martin).  Per file make total sense, but we need the file
system in control.

The real problem is further down the stack.  For the SCSI temperature
hints just passing them on make sense.  But when you map to some kind
of stream separation in the device, no matter if that is streams, FDP,
or various kinds of streams we don't even support in thing like CF
and SDcard, the driver is not the right place to map temperature hint
to streams.  The requires some kind of intelligence.  It could be
dirt simple and just do a best effort mapping of the temperature
hints 1:1 to separate write streams, or do a little mapping if there
is not enough of them which should work fine for a raw block device.

But one we have a file system things get more complicated:

 - the file system will want it's own streams for metadata and GC
 - even with that on beefy enough hardware you can have more streams
   then temperature levels, and the file system can and should
   do intelligen placement (based usually on files)

Or to summarize:  the per-file temperature hints make sense as a user
interface.  Per-I/O hints tend to be really messy at least if a file
system is involved.  Placing the temperatures to separate write streams
in the driver does not scale even to the most trivial write stream
aware file system implementations.

And for anyone who followed the previous discussions of the patches
none of this should been new, each point has been made at least three
times before.


