Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F2AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R07ML6m3nOWSyXwBLuPgc4cjFzZSzHlISnMnJ8rQV/Y=; b=NymyLS4y7S0k6qrQzSRZn55jXT
	qJxZQ0HH0ikcr+APVKvuZDHCmBPuockKiKM3iyvmBWe5BQ8/4IfOPVm8uUAHhGqfM6P8T9DvDhxMD
	EIsFsa+ySko72xxaEMV0tSBX0scqFM7YvQ1blm7L1hi7uD+uvGtbWdEif2nkqV6weJAzirpfKUcDZ
	AePlW26rCQCSo7Wb/FOJ7Yg+0U30yDJFkpjFAtcC40F+92wEkHwsvMJoRALZ9CQn2CknZUkbhB06d
	CLTnCPRNSRT40uQY5yGUglL/v+xlm77r/M+X5GvCDC1TUta3QF2RkARwBvLM1czlbBlxNQCqbDrVm
	cM71n2yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKMVG-007Yhm-Lm; Wed, 16 Feb 2022 15:46:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKMVD-007Yga-O8
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 15:46:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C07C768B05; Wed, 16 Feb 2022 16:45:55 +0100 (CET)
Date: Wed, 16 Feb 2022 16:45:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
 markus.bloechl@ipetronik.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Message-ID: <20220216154555.GA19362@lst.de>
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216150901.4166235-2-hch@lst.de>
 <20220216153722.GB1936276@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216153722.GB1936276@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_074559_960287_0560D8DA 
X-CRM114-Status: GOOD (  19.71  )
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

On Wed, Feb 16, 2022 at 07:37:22AM -0800, Keith Busch wrote:
> On Wed, Feb 16, 2022 at 04:09:01PM +0100, Christoph Hellwig wrote:
> > -	fsync_bdev(disk->part0);
> > +	/*
> > +	 * If this is not a surprise removal see if there is a file system
> > +	 * mounted on this device and sync it (although this won't work for
> > +	 * partitions).  For surprise removals that have already marked the
> > +	 * disk dead skip this call as no I/O is possible anyway.
> > +	 */
> > +	if (!test_bit(GD_DEAD, &disk->state))
> > +		fsync_bdev(disk->part0);
> >  	__invalidate_device(disk->part0, true);
> 
> It used to be that any dirty pages would attempt to write, and get an
> error on a surprise removal. Now that you're skipping the fsync_bdev(),
> is something else taking responsibility to error those pages?

truncate_inode_pages when closing the device.

