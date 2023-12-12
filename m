Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2097AC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Dec 2023 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxYqGNFOGvazpK92yIj7VH6hGzmyCPduPblR3gIcbdk=; b=lvQkzRqEiTBthlX/cwfxhnxAAO
	+ul7yNPrD8+X6LF4c8JZ9NtYdM7Kq6t2dYbGXce6FWeU4l42Oq4mQnyNhtioGnvHzSmjNHd0VZeci
	Sz/Jfzc2kDGLemhCMEZgJNRVjXgzj6owkWWAX96OtRw+5blTsqIWslhOZLUcFPDF1yJ9HH0MWJZUR
	vTGBiZ5GIBT/WZDGiHYmBKb2vzyPykKjIBiQ0YoFsWdlRWIvOzASbdfj+Z7xDrqfQjLAsZl2pkeD8
	3eUk2V8oPkjotRDPJHCPWW4kA80BQA6AHPlTFN5qr6Y6F+GR7M/f84lax2Zh8QXwzFin3XepY7Y1p
	8ty3NP9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rD5gu-00CEMI-0I;
	Tue, 12 Dec 2023 16:33:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rD5gq-00CEKS-0T
	for linux-nvme@lists.infradead.org;
	Tue, 12 Dec 2023 16:33:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6ACA68C4E; Tue, 12 Dec 2023 17:32:46 +0100 (CET)
Date: Tue, 12 Dec 2023 17:32:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231212163246.GA24594@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_083300_488875_F41AE2E9 
X-CRM114-Status: GOOD (  26.77  )
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

On Tue, Dec 12, 2023 at 11:08:28AM +0000, John Garry wrote:
> Two new fields are added to struct statx - atomic_write_unit_min and
> atomic_write_unit_max. For each atomic individual write, the total length
> of a write must be a between atomic_write_unit_min and
> atomic_write_unit_max, inclusive, and a power-of-2. The write must also be
> at a natural offset in the file wrt the write length.
> 
> SCSI sd.c and scsi_debug and NVMe kernel support is added.
> 
> Some open questions:
> - How to make API extensible for when we have no HW support? In that case,
>   we would prob not have to follow rule of power-of-2 length et al.
>   As a possible solution, maybe we can say that atomic writes are
>   supported for the file via statx, but not set unit_min and max values,
>   and this means that writes need to be just FS block aligned there.

I don't think the power of two length is much of a problem to be
honest, and if we every want to lift it we can still do that easily
by adding a new flag or limit.

What I'm a lot more worried about is how to tell the file system that
allocations are done right for these requirement.  There is no way
a user can know that allocations in an existing file are properly
aligned, so atomic writes will just fail on existing files.

I suspect we need an on-disk flag that forces allocations to be
aligned to the atomic write limit, in some ways similar how the
XFS rt flag works.  You'd need to set it on an empty file, and all
allocations after that are guaranteed to be properly aligned.

> - For block layer, should atomic_write_unit_max be limited by
>   max_sectors_kb? Currently it is not.

Well.  It must be limited to max_hw_sectors to actually work.
max_sectors is a software limit below that, which with modern hardware
is actually pretty silly and a real performance issue with todays
workloads when people don't tweak it..

> - How to improve requirement that iovecs are PAGE-aligned.
>   There are 2x issues:
>   a. We impose this rule to not split BIOs due to virt boundary for
>      NVMe, but there virt boundary is 4K (and not PAGE size, so broken for
>      16K/64K pages). Easy solution is to impose requirement that iovecs
>      are 4K-aligned.
>   b. We don't enforce this rule for virt boundary == 0, i.e. SCSI

.. we require any device that wants to support atomic writes to not
have that silly limit.  For NVMe that would require SGL support
(and some driver changes I've been wanting to make for long where
we always use SGLs for transfers larger than a single PRP if supported)


> - Since debugging torn-writes due to unwanted kernel BIO splitting/merging
>   would be horrible, should we add some kernel storage stack software
>   integrity checks?

Yes, I think we'll need asserts in the drivers.  At least for NVMe I
will insist on them.  For SCSI I think the device actually checks
because the atomic writes are a different command anyway, or am I
misunderstanding how SCSI works here?


