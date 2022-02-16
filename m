Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B08BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NsOm8I3wVhp67mq5XTWLwjXLvNKUdsLy76RamT1AKWw=; b=WfRNvvPWe3JdIDZX5Lg+sGmn/v
	gFNOEFPVjk7m2tHDsYrww4Et/2nSIw1kpboMf0egWCG51uYJjaf6SWCFu9xaxMmXAABQpeZAt2Ptu
	cDvw/jYeSDO6Qn1gorS+NdSV6AWtl4FWrmbBR7voJQdKo/u5AX1xK30ANsACDUtpoHPXWU43lRThH
	r3Ob58CtE9vg7i3sl+wRD+RXLEiLFCEhLJkkoGa3OW7rtAh1KyGF9EJDN5oEXvzrxS2SMhz4Hti2H
	hX+6ei0OyVpztBm/l7+Xm8yclyrGszywqnkkE7hM8rqypND5JSttX4QCe+S6FDSkEN7V3uRXSToQe
	ms3U3VDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKNnz-007r6C-JF; Wed, 16 Feb 2022 17:09:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKNnw-007r5T-Kt
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 17:09:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F00A868B05; Wed, 16 Feb 2022 18:09:19 +0100 (CET)
Date: Wed, 16 Feb 2022 18:09:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Markus =?iso-8859-1?Q?Bl=F6chl?= <Markus.Bloechl@ipetronik.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Message-ID: <20220216170919.GA20782@lst.de>
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216154950.q3uit4ucl6xupvhe@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216154950.q3uit4ucl6xupvhe@ipetronik.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_090924_861871_54BB589E 
X-CRM114-Status: GOOD (  21.76  )
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

On Wed, Feb 16, 2022 at 04:49:50PM +0100, Markus Blöchl wrote:
> > -	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
> > -	blk_queue_start_drain(q);
> > +	set_bit(GD_DEAD, &disk->state);
> > +	blk_queue_start_drain(disk->queue);
> >  }
> > -EXPORT_SYMBOL_GPL(blk_set_queue_dying);
> > +EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
> 
> I might have missed something here, but assuming I am a driver which
> employs multiple different queues, some with a disk attached to them,
> some without (Is that possible? The admin queue e.g.?)
> and I just lost my connection and want to notify everything below me
> that their connection is dead.
> Would I really want to kill disk queues differently from non-disk
> queues?

Yes.  Things like the admin queue in nvme are under full control of
the driver.  While the "disk" queues just get I/O from the file system
and thus need to be cut off.

> How is the admin queue killed? Is it even?

It isn't.  We just stop submitting to it.

> > --- a/drivers/block/mtip32xx/mtip32xx.c
> > +++ b/drivers/block/mtip32xx/mtip32xx.c
> > @@ -4112,7 +4112,7 @@ static void mtip_pci_remove(struct pci_dev *pdev)
> >  			"Completion workers still active!\n");
> >  	}
> >  
> > -	blk_set_queue_dying(dd->queue);
> > +	blk_mark_disk_dead(dd->disk);
> 
> This driver is weird, I did find are reliably hint that dd->disk always
> exists here. At least mtip_block_remove() has an extra check for that.

The driver is a bit of a mess indeed, but the disk and queue will be
non-NULL if ->probe returns successfully so this is fine.  It is more
that some of the checks are not required.

> It also only set QUEUE_FLAG_DEAD if it detects a surprise removal and
> not QUEUE_FLAG_DYING.

Yes, this driver will need further work.

