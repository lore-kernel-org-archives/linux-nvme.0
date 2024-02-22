Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEC6C48BF8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yOb/RuraypnITZK8K9KciUvMA2gEcSTBZFoeNPrttlI=; b=YqzRmrs7x6KykOQBzxecwTqkkX
	wTM/8wZlVvoHGuj711lpmfq+SxB6fUHOsxaWjagxIij2lAYvubsUKthnZ23whGOohmkZV6XtQEdl+
	9ES3Pw0IdGRM/axwvrTPj9o1hSLT7UQYrbaufAzqsGFtqPmhl6v6Bd9aZFdUItDyM7hrk9fpw9yGZ
	rSj4ynbtDNZDddolIEzA1j7P6AC3bhY9nkJjkOyMusX5C+YCgTqm6fw2b4112+zcAraS7JzeixKX6
	clqROXgqAA1dzoUoPeRLzfMQ3mi4hUXB73USAoD8QXZGs3U0NtHyruspkjjt2jw2rwkBPAq3mFI4Q
	zCaexF1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdE4Z-00000006BUj-2Buf;
	Thu, 22 Feb 2024 18:45:31 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdE4T-00000006BTO-2hLZ;
	Thu, 22 Feb 2024 18:45:25 +0000
Date: Thu, 22 Feb 2024 10:45:25 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linuxfoundation.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <ZdeWRaGQo1IX18pL@bombadil.infradead.org>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <ZYUbB3brQ0K3rP97@casper.infradead.org>
 <ZYUgo0a51nCgjLNZ@infradead.org>
 <9b46c48f-d7c4-4ed3-a644-fba90850eab8@acm.org>
 <ZZxOdWoHrKH4ImL7@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZxOdWoHrKH4ImL7@casper.infradead.org>
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

On Mon, Jan 08, 2024 at 07:35:17PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 08, 2024 at 11:30:10AM -0800, Bart Van Assche wrote:
> > On 12/21/23 21:37, Christoph Hellwig wrote:
> > > On Fri, Dec 22, 2023 at 05:13:43AM +0000, Matthew Wilcox wrote:
> > > > It clearly solves a problem (and the one I think it's solving is the
> > > > size of the FTL map).  But I can't see why we should stop working on it,
> > > > just because not all drive manufacturers want to support it.
> > > 
> > > I don't think it is drive vendors.  It is is the SSD divisions which
> > > all pretty much love it (for certain use cases) vs the UFS/eMMC
> > > divisions which tends to often be fearful and less knowledgeable (to
> > > say it nicely) no matter what vendor you're talking to.
> > 
> > Hi Christoph,
> > 
> > If there is a significant number of 4 KiB writes in a workload (e.g.
> > filesystem metadata writes), and the logical block size is increased from
> > 4 KiB to 16 KiB, this will increase write amplification no matter how the
> > SSD storage controller has been designed, isn't it? Is there perhaps
> > something that I'm misunderstanding?
> 
> You're misunderstanding that it's the _drive_ which gets to decide the
> logical block size. Filesystems literally can't do 4kB writes to these
> drives; you can't do a write smaller than a block.  If your clients
> don't think it's a good tradeoff for them, they won't tell Linux that
> the minimum IO size is 16kB.

Yes, but its perhaps good to review how flexible this might be or not.
I can at least mention what I know of for NVMe. Getting a lay of the
land of this for other storage media would be good.

Some of the large capacity NVMe drives have NPWG as 16k, that just means
the Indirection Unit is 16k, the mapping table, so the drive is hinting
*we prefer 16k* but you can still do 4k writes, it just means for all
these drives that a 4k write will be a RMW.

Users who *want* to help avoid RMWs on these drives and want to increase the
writes to be at least 16k can enable a 16k or larger block size so to
align the writes. The experimentation we have done using Daniel Gomez's
eBPF blkalgn tool [0] reveal (as discussed at last year's Plumbers) that
there were still some 4k writes, this was in turn determined to be due
to XFS's buffer cache usage for metadata. Dave recently posted patches to allow
to use large folios on the xfs buffer cache [1], and Daniel has started making
further observations on this which he'll be revealing soon.

[0] https://github.com/dagmcr/bcc/tree/blkalgn-dump
[1] https://lore.kernel.org/all/20240118222216.4131379-1-david@fromorbit.com/

For large capacity NVMe drives with large atomics (NAUWPF), the
nvme block driver will allow for the physical block size to be 16k too,
thus allowing the sector size to be set to 16k when creating the
filesystem, that would *optionally* allow for users to force the
filesystem to not allow *any* writes to the device to be 4k. Note
then that there are two ways to be able to use a sector size of 16k
for NVMe today then, one is if your drive supported 16 LBA format and
another is with these two parameters set to 16k. The later allows you
to stick with 512 byte or 4k LBA format and still use a 16k sector size.
That allows you to remain backward compatible.

Jan Kara's patches "block: Add config option to not allow writing to
mounted devices" [2] should allow us to remove the set_blocksize() call
in xfs_setsize_buftarg() since XFS does not use the block device cache
at all, and his pathces ensure once a filesystem is mounted userspace
won't muck with the block device directly.

As for the impact of this for 4k writes, if you create the filesystem
with a 16 sector size then we're strict, and it means at minimum 16k is
needed. It is no different than what is done for 4k where the logical
block size is 512 bytes and we use a 4k sector size as the physical
block size is 4k. If using buffered IO then we can leverage the page
cache for modifications. Either way, you should do your WAF homework
too. Even if you *do* have 4k workloads, underneath the hood you may see
that as of matter of fact the number of IOs which are 4k are very likely
small in count. In so far as WAF is concerned, the *IO volume* is what
matters.  Luca Bert has a great write up on his team's findings when
evaluating some real world workload's WAF estimates when considering
IO volume [3].

[2] https://lkml.kernel.org/r/20231101173542.23597-1-jack@suse.cz
[3] https://www.micron.com/about/blog/2023/october/real-life-workloads-allow-more-efficient-data-granularity-and-enable-very-large-ssd-capacities

We were not aware of public open source tools to do what they did,
so we worked on a tool that allows just that. You can measure your
workload WAF using Daniel Gomez's WAF tool for NVMe [4] and decide if
the tradeoffs are acceptable. It would be good for us to automate
generic workloads, slap it on kdevops, and compute WAF, for instance.

[4] https://github.com/dagmcr/bcc/tree/nvmeiuwaf

> Some workloads are better with a 4kB block size, no doubt.  Others are
> better with a 512 byte block size.  That doesn't prevent vendors from
> offering 4kB LBA size drives.

Indeed, using large block sizes by no not meant for all workloads. But
it's a good time to also remind folks that larger IOs tend to just be
good for flash storage in general too. So if your WAF measurements check
out, using large block sizes is something to evaluate.

 Luis

