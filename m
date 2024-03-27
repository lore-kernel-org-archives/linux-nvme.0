Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B2FC54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Mar 2024 03:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rk1STaKASJZMOQESaE4YdsbKcHTwjlEtdkr30vV9pdg=; b=CGMzD2FzSJYPMs+lImuLxD0M0u
	BI1GQrZ+9LCh6eUn/miZfEjm82SsJxtvYSh8mL79eU7apIk85OajWUbaNYu8e4YXIKwJOjCpY6AxH
	qME+udcyvs/7jR1BfhGf4t1zhDIWofZ1GOO5M86BPGhBF8iUrOHtWAp6UUbJ/3r/kLvb2KF9piAaB
	e9JQCp1AoRdlqd5VUQb+78JrMoNS1jUz/1PK2Uc5+K7AtfoTvccr0q5iaYZJWvgSLjW6DxNuO+Zxj
	1e8ycUJ8L2yNyryvimz8C9/t5bbHBC9WgMGwh3H1/hujfrI9HsXdiGk+sv+UVGAC5DrMnE+YGTMKP
	4ZjCq6Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpKIo-00000007M6V-1mJQ;
	Wed, 27 Mar 2024 03:50:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpKIm-00000007M6J-1KWx
	for linux-nvme@bombadil.infradead.org;
	Wed, 27 Mar 2024 03:50:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rk1STaKASJZMOQESaE4YdsbKcHTwjlEtdkr30vV9pdg=; b=k6AI2bfnRnr2I3SiqEJhR0ATer
	L/tOjZtLNhHZu7N988MPkHPWZJoBDo+zKoYivmHKkU31eNPCva+VjDW+1R4Gm2R9QCg9X4JWeyq/e
	dI4XLAOq1DzhKn4YwIj+lcTmhL1RkuTgK/i1pDSmi9D6Lm5kMFE+Q+1wlg5UMNTm5hOwkCAqbRAJj
	IEUAQSGMrFpTRQY4p8k8ZrEEaxVf4ciY1E1jJcKZIkIQFhgMyGawFsbfpoeYbqpLUo4LPaD/rKBC3
	+6OIEw+02Zj2ueHh3TKcU/mDZsebPI/D73/FkvUZGJNikrmvbubgTIxVumhEwo5Ifk7nNsozpsf7o
	FJjRTWDA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpKIh-00000002xYu-3gF1;
	Wed, 27 Mar 2024 03:50:07 +0000
Date: Wed, 27 Mar 2024 03:50:07 +0000
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
Message-ID: <ZgOXb_oZjsUU12YL@casper.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326133813.3224593-1-john.g.garry@oracle.com>
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

On Tue, Mar 26, 2024 at 01:38:03PM +0000, John Garry wrote:
> The goal here is to provide an interface that allows applications use
> application-specific block sizes larger than logical block size
> reported by the storage device or larger than filesystem block size as
> reported by stat().
> 
> With this new interface, application blocks will never be torn or
> fractured when written. For a power fail, for each individual application
> block, all or none of the data to be written. A racing atomic write and
> read will mean that the read sees all the old data or all the new data,
> but never a mix of old and new.
> 
> Three new fields are added to struct statx - atomic_write_unit_min,
> atomic_write_unit_max, and atomic_write_segments_max. For each atomic
> individual write, the total length of a write must be a between
> atomic_write_unit_min and atomic_write_unit_max, inclusive, and a
> power-of-2. The write must also be at a natural offset in the file
> wrt the write length. For pwritev2, iovcnt is limited by
> atomic_write_segments_max.
> 
> There has been some discussion on supporting buffered IO and whether the
> API is suitable, like:
> https://lore.kernel.org/linux-nvme/ZeembVG-ygFal6Eb@casper.infradead.org/
> 
> Specifically the concern is that supporting a range of sizes of atomic IO
> in the pagecache is complex to support. For this, my idea is that FSes can
> fix atomic_write_unit_min and atomic_write_unit_max at the same size, the
> extent alignment size, which should be easier to support. We may need to
> implement O_ATOMIC to avoid mixing atomic and non-atomic IOs for this. I
> have no proposed solution for atomic write buffered IO for bdev file
> operations, but I know of no requirement for this.

The thing is that there's no requirement for an interface as complex as
the one you're proposing here.  I've talked to a few database people
and all they want is to increase the untorn write boundary from "one
disc block" to one database block, typically 8kB or 16kB.

So they would be quite happy with a much simpler interface where they
set the inode block size at inode creation time, and then all writes to
that inode were guaranteed to be untorn.  This would also be simpler to
implement for buffered writes.

Who's asking for this more complex interface?

