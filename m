Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F22EE77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WHomfacRzefhD+fXbxHYEFTGHgt/EzW8qOZ2AgMz5/o=; b=47Np5eRTKH7cC0FqvntCl4ZbxF
	lyTCFLAWhmysF796+5NIvlAdNFD6QTBb1sNpOqIAmAOD218ImsQrsCkjkC5ThloJuBjRDzr4XhfZk
	pUjn09WZQ21EdAV+TLIVuVyvAtxLo4nUaBZShL4tOQuMGuv/equyl1idIgFbBsQNaxe4w0CKS6zSg
	amih8ytDGAh3q2zwFaDKNjmABzyH8NnRu2BhqH0dEnvd7Sa88KbEOkNGNxeeG7qs5TGbBbIhWUiAM
	iVhE5ojQN9itQnuvSb4DwvcxL9hc5F5Xxz+C6oMQgVqUAzMHKNgrwycP7zHWaDK/RUbpkl0Wesmi4
	ji+Nx1Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkzy-00000000zdW-11my;
	Mon, 06 Jan 2025 11:10:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkvS-00000000ynG-0sKR
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 11:05:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4122D68B05; Mon,  6 Jan 2025 12:05:32 +0100 (CET)
Date: Mon, 6 Jan 2025 12:05:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 05/10] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
Message-ID: <20250106110532.GA22062@lst.de>
References: <20250106100645.850445-1-hch@lst.de> <20250106100645.850445-6-hch@lst.de> <4addcb5e-fc88-4a86-a464-cc25d8674267@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4addcb5e-fc88-4a86-a464-cc25d8674267@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_030538_389676_3D3F0192 
X-CRM114-Status: GOOD (  15.78  )
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

On Mon, Jan 06, 2025 at 04:31:23PM +0530, Nilay Shroff wrote:
> > +static bool bdev_can_poll(struct block_device *bdev)
> > +{
> > +	struct request_queue *q = bdev_get_queue(bdev);
> > +
> > +	if (queue_is_mq(q))
> > +		return blk_mq_can_poll(q->tag_set);
> > +	return q->limits.features & BLK_FEAT_POLL;
> > +}
> > +
> 
> Should we make bdev_can_poll() inline ?

I don't really see the point.  It's file local and doesn't have any
magic that could confuse the code generator, so we might as well leave
it to the compiler.  Although that might be about to change per the
discussion with Damien, which could require it in blk-sysfs, in
which case it should become an inline in a header.


