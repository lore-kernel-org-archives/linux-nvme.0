Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F888C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 07:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4dgB368h39jUH72MkhrNqUEvkvtvGjaTCE4fAqTyJIE=; b=HxgEb9kgR9H0X+W1p7VZuvbRzP
	Yj/KBhmfAehuOxPpggRR08qO9GeYNY8nrP1/pBeAaRe46U7B4i4oCSpemcW13OpShteCVPsul23Jp
	tuiL9fBm1P9DWCiC7y/WORsrRDMH228GIynQuYKkEv9eEtEneLpy19eB2kjXab2jtF2x48a1JSWhU
	iWEQ+lrLNz+nGWtaAysME/0Zx2Yqg0hQ8/sXPkGnqllfjSCOXZrPxn4x/ykeEuQuhpl+qEEcSDnxE
	rh6m3ESYQX87TFvrD26px7uwPEx1AE0amWTsHy2h9s9aL8EyMwdtiOxidgc3yXIQxI1va5g26BT9B
	3R/gVRkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCGMK-006l7C-WE; Tue, 25 Jan 2022 07:35:21 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCGF1-006iy9-8V
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 07:27:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 308C868BEB; Tue, 25 Jan 2022 08:27:40 +0100 (CET)
Date: Tue, 25 Jan 2022 08:27:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 09/13] scsi: force unfreezing queue into atomic mode
Message-ID: <20220125072739.GA27777@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-10-ming.lei@redhat.com>
 <20220124131516.GH27269@lst.de> <Ye80kxTBojm6GN8k@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye80kxTBojm6GN8k@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_232747_508067_5398E8CE 
X-CRM114-Status: GOOD (  21.90  )
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

On Tue, Jan 25, 2022 at 07:21:55AM +0800, Ming Lei wrote:
> > > @@ -3670,7 +3670,7 @@ static void scsi_disk_release(struct device *dev)
> > >  	 * in case multiple processes open a /dev/sd... node concurrently.
> > >  	 */
> > >  	blk_mq_freeze_queue(q);
> > > -	blk_mq_unfreeze_queue(q);
> > > +	__blk_mq_unfreeze_queue(q, true);
> > 
> > I think the right thing here is to drop the freeze/unfreeze pair.
> > Now that del_gendisk properly freezes the queue, we don't need this
> > protection as the issue that Bart fixed with it can't happen any more.
> 
> As you see, the last patch removes freeze/unfreeze pair in del_gendisk(),
> which looks not very useful: it can't drain IO on bio based driver, and
> del_gendisk() is supposed to provide consistent behavior for both request
> and bio based driver.

So what is the advantage of trying to remove the freeze from where
it belongs (common unregister code) while keeping it where it is a bandaid
(driver specific unregister code)?

