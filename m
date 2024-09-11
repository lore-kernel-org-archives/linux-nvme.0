Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95E4EE0219
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GGsOkIL9TNemGTxpiM6W31phHoLaifU1AV8GWKD2zdw=; b=qIv+54aZXDtt5A9Yfpu8GtseIf
	hD+2uXlO7gaey4gSYb89xfyWBSeyIMBy6e46peCZpDFV+IQZQkFDh8EguOEufcEc+NaqTjr5HsuOf
	ogAdPhb6B4d20jpVO6LTWxnsbMN5CE4KxTdAhVXJNMhpSzJR24jM/V8hp+n/yYBLAy0SnCoQ0x1yj
	LYgiQBz1xAmccb75Opcw8vnHznJuOZaBMnJuHFUZJjAkZe7aGgvjz1azET6j3Qf1DXRFaLB2YJkSs
	SATK5YlvcElfr1QRJXhcidvPbNIXrezdYNg/KkzcMOpb53+nnNj0bUDXxfcUVzj1B1ok40v5XDQwm
	39vdt3RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIcw-00000008cci-47md;
	Wed, 11 Sep 2024 08:23:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIXV-00000008bBe-3F5P
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 08:17:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70F4A227AB6; Wed, 11 Sep 2024 10:17:20 +0200 (CEST)
Date: Wed, 11 Sep 2024 10:17:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCHv3 06/10] blk-integrity: simplify counting segments
Message-ID: <20240911081720.GA7372@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-7-kbusch@meta.com> <20240910154105.GF23805@lst.de> <ZuBua91J2X5Yt-72@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuBua91J2X5Yt-72@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_011725_982899_B7F6842B 
X-CRM114-Status: GOOD (  20.18  )
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

On Tue, Sep 10, 2024 at 10:06:03AM -0600, Keith Busch wrote:
> Exactly. bio_integrity_add_page will use the queue's limits to decide if
> it can combine pages into one vector, so appending pages through that
> interface will always result in the most compact bip vector.
> 
> This patch doesn't combine merged bio's but that's unlikely to have
> mergable segments.

Oh, bio_integrity_add_page uses bvec_try_merge_hw_page.  That means it
doesn't really work well for our stacking model, as any stacking driver
can and will change these.  Maybe we need to take a step back and fully
apply the immutable biovec and split at final submission model to
metadata?

> The common use cases don't add integrity data until after the bio is
> already split in __bio_split_to_limits(), and it won't be split again
> after integrity is added via bio_integrity_prep(). The common path
> always adds integrity in a single segment, so it's always valid.

Where common case is the somewhat awful auto PI in the lowest level
driver.  I'd really much prefer to move to the file system adding
the PI wherever possible, as that way it can actually look into it
(and return it to the driver, etc).

> There are just a few other users that set their own bio integrity before
> submitting (the nvme and scsi target drivers), and I think both can
> break from possible bio splitting, but I haven't been able to test
> those. 

Yes.  Plus dm-integrity and the new io_uring read/write with PI code
that's being submitted. I plan to also support this from the file
system eventually.  None of these seems widely used, which I think
explains the current messy state of PI as soon as merging/splitting
or remapping is involved.


