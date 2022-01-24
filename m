Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C9FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nzwb+SbNYhrPZxrZzSwC8wiWrljoE2GsyAB7tcm0Bhc=; b=mmmBi2p4H5SlVazB/TiL1uJwPv
	7Oqah8+jrjD6nwyh0AgVPYBv1GlI2+IqaylGJy/eB8l4tY8pYe94T8j1AOraPhyVH+T435AsNK3ie
	ZVQyfXTYaOn/+0lfW7zVjC+NjgxDk7gvWj/Qw3KH2iN0CSGCcyUZUld/MhNCIAh/+AGdr3I6HvS5g
	sRZhVesJwSWN7ntJOEJYR3DNNNB7lFcViQOuEOju9elwBIVk9MOw2xahfSi3Wh6gODDjf+tYgKyqU
	WouU0vy6vJ49VasLhapHrwQAU+tRq1AJT0tZW9ZpFWjhYjJjpUwS9SUkUYztKZEMA+aB5LUQ2Wy6Y
	O/uWL4NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBzFS-003SEZ-A0; Mon, 24 Jan 2022 13:19:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBzBo-003QPm-OY
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 13:15:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 10B4068BEB; Mon, 24 Jan 2022 14:15:17 +0100 (CET)
Date: Mon, 24 Jan 2022 14:15:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 09/13] scsi: force unfreezing queue into atomic mode
Message-ID: <20220124131516.GH27269@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-10-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-10-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_051520_986188_5C3D90F1 
X-CRM114-Status: GOOD (  22.01  )
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

On Sat, Jan 22, 2022 at 07:10:50PM +0800, Ming Lei wrote:
> In scsi_disk_release() request queue is frozen for clearing
> disk->private_data, and there can't be any FS IO issued to
> this queue, and only private passthrough request will be handled, so
> force unfreezing queue into atomic mode.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 0e73c3f2f381..27f04c860f00 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3670,7 +3670,7 @@ static void scsi_disk_release(struct device *dev)
>  	 * in case multiple processes open a /dev/sd... node concurrently.
>  	 */
>  	blk_mq_freeze_queue(q);
> -	blk_mq_unfreeze_queue(q);
> +	__blk_mq_unfreeze_queue(q, true);

I think the right thing here is to drop the freeze/unfreeze pair.
Now that del_gendisk properly freezes the queue, we don't need this
protection as the issue that Bart fixed with it can't happen any more.

