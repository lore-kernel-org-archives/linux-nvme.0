Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1B6D3A67C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8qLB6+x3AQio11Aq1E1qW/JYwhfeQT1IFMu4c6LbwhE=; b=RY7dpPPSQ/xZ3tmRDCoKn4dh81
	0+7AcxTMb68EjTorvurM7C2+VNZwWgU7zEeAhxuVZ+y20Kp4K6in2lKcVmE/LTwN4+PZN1E/e8bB4
	9gDD2Vu4HN987n+rzmvhtXqTNE9ZaOIJn48LxPEULughxQvO4Dgn2RoUCzqMHXkTYu4NREvPG7UX0
	Gecrs6hrucspnG2YpM4F7Ja4VVh4p6p0+ROsW6sBLXgNNNTx0GhOQLFBDUq1GeRWZyee8gc4fUfp8
	A526R6lJFzMkq4fycR9BqKKYm01a+s2YzcjjZhSp6eOXab7DjijZQQ27dgRfkdRXvHxiIgU7Wfeqg
	ihdd8TcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rDs-0000000FWnT-3TE7;
	Tue, 29 Oct 2024 18:45:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5ozk-0000000F6ct-483d
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 16:23:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 61A6C5C4A2A;
	Tue, 29 Oct 2024 16:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504EFC4CECD;
	Tue, 29 Oct 2024 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730218980;
	bh=rnqDaUxeAcqkIk/Vh8WJ9TxoWp2/b9FHNdxNoOJlIGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmO/oYVPLqeC34LQRu1PYdnSvZd4ijfcozDJ/SywAmS8CCeUdPO4Fei0e+9PG7HGl
	 vDX2HjNZVgs0J/AzgItViMJdpiiaKg8CzAexngMVRoxuFOCVWnE7RWrU2kpRi0lnGZ
	 A4LNtMgy/AaERrSI2RzlS22JN6iLwo/Be9JAw1deT9ivdMKL9drQfgjaaIhceCP600
	 /pPjlAohYl149PBupNLsUs5Mb0RhmWrwAFePvBX4VbuZjcJfFHM3vNn+DrE8lnOvuz
	 bTWTe4ltpcTa4zF94DrK960V4pDkPfbP2q+pxxNotVMGXyc292q+8mPV1BVYUA3e2s
	 OMYC/pMJ5z6+w==
Date: Tue, 29 Oct 2024 10:22:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyEL4FOBMr4H8DGM@kbusch-mbp>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-10-kbusch@meta.com>
 <20241029152654.GC26431@lst.de>
 <ZyEAb-zgvBlzZiaQ@kbusch-mbp>
 <20241029153702.GA27545@lst.de>
 <ZyEBhOoDHKJs4EEY@kbusch-mbp>
 <20241029155330.GA27856@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029155330.GA27856@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_092301_140105_AA56B372 
X-CRM114-Status: GOOD (  27.56  )
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

On Tue, Oct 29, 2024 at 04:53:30PM +0100, Christoph Hellwig wrote:
> On Tue, Oct 29, 2024 at 09:38:44AM -0600, Keith Busch wrote:
> > They're not exposed as write streams. Patch 7/9 sets the feature if it
> > is a placement id or not, and only nvme sets it, so scsi's attributes
> > are not claiming to be a write stream.
> 
> So it shows up in sysfs, but:
> 
>  - queue_max_write_hints (which really should be queue_max_write_streams)
>    still picks it up, and from there the statx interface
> 
>  - per-inode fcntl hint that encode a temperature still magically
>    get dumpted into the write streams if they are set.
> 
> In other words it's a really leaky half-backed abstraction.

Exactly why I asked last time: "who uses it and how do you want them to
use it" :)
 
> Let's brainstorm how it could be done better:
> 
>  - the max_write_streams values only set by block devices that actually
>    do support write streams, and not the fire and forget temperature
>    hints.  They way this is queried is by having a non-zero value
>    there, not need for an extra flag.

So we need a completely different attribute for SCSI's permanent write
streams? You'd mentioned earlier you were okay with having SCSI be able
to utilized per-io raw block write hints. Having multiple things to
check for what are all just write classifiers seems unnecessarily
complicated.

>  - but the struct file (or maybe inode) gets a supported flag, as stream
>    separation needs to be supported by the file system 
>  - a separate fcntl is used to set per-inode streams (if you care about
>    that, seem like the bdev use case focusses on per-I/O).  In that case
>    we'd probably also need a separate inode field for them, or a somewhat
>    complicated scheme to decide what is stored in the inode field if there
>    is only one.

No need to create a new fcntl. The people already testing this are
successfully using FDP with the existing fcntl hints. Their applications
leverage FDP as way to separate files based on expected lifetime. It is
how they want to use it and it is working above expectations. 

>  - for block devices bdev/fops.c maps the temperature hints into write
>    streams if write streams are supported, any user that mixes and
>    matches write streams and temperature hints gets what they deserve

That's fine. This patch series pretty much accomplishes that part.

>  - this could also be a helper for file systems that want to do the
>    same.
> 
> Just a quick writeup while I'm on the run, there's probably a hole or
> two that could be poked into it.

