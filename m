Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DA8E77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9EsumI1jP1p+uy4RtospfpMToMMhsfbee4epaY9CLDQ=; b=FxUtcTdUnuFRw6IAVWTpJfJvAc
	o40arV0BTzvqAtERv/3mALRuZ56tQeRCPMxXZf1SmsT8RsMyLHgs/Af5LXsnUSuU6fPZk+Gioy8sN
	J+24jPZaSKTVMRARFuHVlSqngR6F9LYXSw5LxTH3uE1kiXocs+QeIX04WNTutUqS3t8olabdhi5TA
	neuQuaJKhGKFuy12R+Uq7MsyhXIvUQwUlk0dKCAv6AvUpJo1ZaqRbjUqyNT0DvShpPzuGDbUEPukr
	GqUE+rHLFDtzVnacMFO2h/St9UWMZM4D37QC4N0hGBn8/ZpK2EEWUZ41EITupqahlPd7+JkmIf2jq
	IaLrKy9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdgJ-0000000CYGk-1KTv;
	Fri, 03 Jan 2025 09:09:23 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdgG-0000000CYGA-28JZ
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 09:09:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9896DA4057D;
	Fri,  3 Jan 2025 09:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27344C4CECE;
	Fri,  3 Jan 2025 09:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735895359;
	bh=EV+hiXpMnVwPGQUO7JrQyTZCFrVUBDW19vmgMtQRWGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOPpH7Z1DWY+qC+ZswNYpEj1NogUVt18Le5PmNjKRycWQMWFCXz5ZLu/ps6JGuouv
	 YSRXpSielIWAG4ix5MM9Ly/Bue7AivSVToUq8B4/BO/uVX4jr/jg4rg3eP+2SNDEUL
	 44mc7IJ9OfPI5JQsikHpGMEibSRHvEs/rBPlE6w4zebF34+H49VhgEMNJjevnkXpJq
	 sF6JIRKKHop6Iz5soaFjfVKtPAMAu5fFp6/IasYWTFyXhJZ30e4piw20lSDqRQdUJL
	 zy3JPS0vSxCPQDWkerdOHwvXMT5v7NOsqhiTJW/U4huW6LtT4kQBvtn0daaSZ8Ix0R
	 1x37gPSi3R4Kw==
Date: Fri, 3 Jan 2025 10:09:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>, linux-btrfs@vger.kernel.org,
	linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z3epOlVGDBqj72xC@ryzen>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103064925.GB27984@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_010920_606682_43D96CAC 
X-CRM114-Status: GOOD (  23.16  )
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

On Fri, Jan 03, 2025 at 07:49:25AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 02, 2025 at 10:49:41AM +0100, Niklas Cassel wrote:
> > > > from below information, it seems an 'ahci' to me. but since I have limited
> > > > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > > > please let us know. thanks a lot!
> > > 
> > > Yes, this looks like ahci.  Thanks a lot!
> > 
> > Did this ever get resolved?
> > 
> > I haven't seen a patch that seems to address this.
> > 
> > AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
> > reordering when issuing a batch of commands, my guess is that the problem
> > also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
> > or block layer.
> 
> I started looking into this before the holidays.  blktrace shows perfectly
> sequential writes without any reordering using ahci, directly on the
> block device or using xfs and btrfs when using dd.  I also started
> looking into what the test does and got as far as checking out the
> stress-ng source tree and looking at stress-aiol.c.  AFAICS the default
> submission does simple reads and writes using increasing offsets.
> So if the test result isn't a fluke either the aio code does some
> weird reordering or btrfs does.
> 
> Oliver, did the test also show any interesting results on non-btrfs
> setups?
> 

One thing that came to mind.
Some distros (e.g. Fedora and openSUSE) ship with an udev rule that sets
the I/O scheduler to BFQ for single-queue HDDs.

It could very well be the I/O scheduler that reorders.

Oliver, which I/O scheduler are you using?
$ cat /sys/block/sdb/queue/scheduler 
none mq-deadline kyber [bfq]


Kind regards,
Niklas

