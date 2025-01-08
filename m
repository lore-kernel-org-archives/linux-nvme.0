Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC282E77199
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h8MKGtPXrHxodv6IJOBdUynL5Tj6j6ePplpFAKUSADQ=; b=QngdZUz7DvHl4tUEkpLJKQy5Mm
	4AGQCuYt1jHsMdzPrSG5UellADa0mAF7TNHRsvGwttHH/mbK/PEcIxSs3zH92nRoTmgHH1ebjjYnp
	I7Rm4FFILxRk6aMznuDQ+f5Oh3xwzZrmkNgKLsvNFejEBaa6HywH7RDoeCqZ+nbSMTzcPcB6h24Uo
	WaXYEP+zbJ9SI1Fdp6H3UXH5QqhCk4DH7iE9wpuFFocnqCVW+f5tTuneGs2aI7zQZ0ienhFRoZ8f3
	CAdv8kiEf2gOHzcJsnEdswx9JyphqVlisFadttI/Shrgks3Hijr/gfS1pRDm04E8ubLndgs1htp6v
	KuRVVD0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVThx-000000084o1-0fNq;
	Wed, 08 Jan 2025 10:54:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTTK-000000081No-13Cu
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:39:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9FA835C486D;
	Wed,  8 Jan 2025 10:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C209FC4CEDF;
	Wed,  8 Jan 2025 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736332773;
	bh=wWO6nKxlaHTQ6vNc0Fh7xbXckRbHyUTC/A+5O8lcDs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvOE7pREw2XNT2FOLTj9XPsqmdUeDCjXbEwyNhfEKPa7cxVIO69gpfrMyzn35bcNj
	 iMJzQvYfKm382us4awXbrEM/hNYmEI2kU9LmXnB45a24U4ZNqSS81qrpyoY9+0cEmL
	 KBQTxCUgaAWuU8YY5mKpXW7a2dOw0w93XLnr8MiWLQCV4//I1omUR1lbpBdvMpvCoH
	 lJr2Eo6tE9UM7t07kb8xvCs0q1KaRAzicyugQE0QlBSJ34BBMoWrOe8jenbsiu+Zgv
	 18H1f1QFusrNdKMR0ldDqAUoMNCwVawZaNxftCXhzc1N4S6yPunX+b9YQZvLaFYSud
	 TeOhkvgOJhi5w==
Date: Wed, 8 Jan 2025 11:39:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	linux-btrfs@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z35VVvuT0nl0iDfd@ryzen>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
 <Z3epOlVGDBqj72xC@ryzen>
 <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_023934_377747_2DF7B499 
X-CRM114-Status: GOOD (  31.82  )
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

On Tue, Jan 07, 2025 at 04:27:44PM +0800, Oliver Sang wrote:
> hi, Niklas,
> 
> On Fri, Jan 03, 2025 at 10:09:14AM +0100, Niklas Cassel wrote:
> > On Fri, Jan 03, 2025 at 07:49:25AM +0100, Christoph Hellwig wrote:
> > > On Thu, Jan 02, 2025 at 10:49:41AM +0100, Niklas Cassel wrote:
> > > > > > from below information, it seems an 'ahci' to me. but since I have limited
> > > > > > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > > > > > please let us know. thanks a lot!
> > > > > 
> > > > > Yes, this looks like ahci.  Thanks a lot!
> > > > 
> > > > Did this ever get resolved?
> > > > 
> > > > I haven't seen a patch that seems to address this.
> > > > 
> > > > AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
> > > > reordering when issuing a batch of commands, my guess is that the problem
> > > > also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
> > > > or block layer.
> > > 
> > > I started looking into this before the holidays.  blktrace shows perfectly
> > > sequential writes without any reordering using ahci, directly on the
> > > block device or using xfs and btrfs when using dd.  I also started
> > > looking into what the test does and got as far as checking out the
> > > stress-ng source tree and looking at stress-aiol.c.  AFAICS the default
> > > submission does simple reads and writes using increasing offsets.
> > > So if the test result isn't a fluke either the aio code does some
> > > weird reordering or btrfs does.
> > > 
> > > Oliver, did the test also show any interesting results on non-btrfs
> > > setups?
> > > 
> > 
> > One thing that came to mind.
> > Some distros (e.g. Fedora and openSUSE) ship with an udev rule that sets
> > the I/O scheduler to BFQ for single-queue HDDs.
> > 
> > It could very well be the I/O scheduler that reorders.
> > 
> > Oliver, which I/O scheduler are you using?
> > $ cat /sys/block/sdb/queue/scheduler 
> > none mq-deadline kyber [bfq]
> 
> while our test running:
> 
> # cat /sys/block/sdb/queue/scheduler
> none [mq-deadline] kyber bfq

The stddev numbers you showed is all over the place, so are we certain
if this is a regression caused by commit e70c301faece ("block:
don't reorder requests in blk_add_rq_to_plug") ?

Do you know if the stddev has such big variation for this test even before
the commit?


If it is not too much to ask... It might be interesting to know if we see
a regression when comparing before/after e70c301faece with scheduler none
instead of mq-deadline.


Kind regards,
Niklas

