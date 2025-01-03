Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74146E77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L8WSe4H2v/GqI7YH/KmjD+sC/5yZdirSTWKkaRsWuyM=; b=YYHivD31TfNdylfmfLj+d97unr
	mbTQaXPDOuacLxLS6quGJ5IiLDsMVuZlIIX9WMLvhxgB6xNDLmzM3CGCu1hTqK1FrE9HoxlF7bJT8
	1NLJ8S0jxEcf3OIQd3vd5ha3J29vGJCezAHlELQf5S9xgPBvAK0BZ3ixxC712ls1G32dbzt3mAf4C
	dcT5bLyO6Yqp4FG3rNQUXEIL5GHRPwIASLCDWomXX9yYnOQOgkxl+1jEVheSCUfFTfH/p0w2L3LNa
	FD0goaYGF7MKnpRQFhZWjPcnAQASFAeVZC8aGs/YmlKTiB8R12oodKyB2ANROgKv3ESao+rmgWUFI
	igseZ6Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbVA-0000000CG0x-39JA;
	Fri, 03 Jan 2025 06:49:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbV5-0000000CFzQ-0mco
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 06:49:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 03BAE68BEB; Fri,  3 Jan 2025 07:49:26 +0100 (CET)
Date: Fri, 3 Jan 2025 07:49:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Oliver Sang <oliver.sang@intel.com>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>, linux-btrfs@vger.kernel.org,
	linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <20250103064925.GB27984@lst.de>
References: <202412122112.ca47bcec-lkp@intel.com> <20241213143224.GA16111@lst.de> <20241217045527.GA16091@lst.de> <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020> <20241217065614.GA19113@lst.de> <Z3ZhNYHKZPMpv8Cz@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3ZhNYHKZPMpv8Cz@ryzen>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_224939_358108_AE9C72C2 
X-CRM114-Status: GOOD (  21.71  )
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

On Thu, Jan 02, 2025 at 10:49:41AM +0100, Niklas Cassel wrote:
> > > from below information, it seems an 'ahci' to me. but since I have limited
> > > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > > please let us know. thanks a lot!
> > 
> > Yes, this looks like ahci.  Thanks a lot!
> 
> Did this ever get resolved?
> 
> I haven't seen a patch that seems to address this.
> 
> AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
> reordering when issuing a batch of commands, my guess is that the problem
> also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
> or block layer.

I started looking into this before the holidays.  blktrace shows perfectly
sequential writes without any reordering using ahci, directly on the
block device or using xfs and btrfs when using dd.  I also started
looking into what the test does and got as far as checking out the
stress-ng source tree and looking at stress-aiol.c.  AFAICS the default
submission does simple reads and writes using increasing offsets.
So if the test result isn't a fluke either the aio code does some
weird reordering or btrfs does.

Oliver, did the test also show any interesting results on non-btrfs
setups?


