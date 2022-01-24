Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E68C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gQEUf8Yw0+oBdSBFNHCviY2/G5KTnhmbsfvm8S52S70=; b=z1Nwt8hkkw3uHDYAHvaJ2nn4xA
	hG7gu9+l4B8vmb9SVEYSC+dDaNGicuNbPleILGfguGUFmZ2P/z9E3Zh6sR0kQMsJiILWTEpQALM8f
	w2AWvMN9L4Tb3GSKV8+Dmv7tC5tGdljKUaG1S0sJO0MfNqu/eJuZ3OCIH5z02WM1XdXA+yH4i8Qgn
	r7oZjKPr2P6rqSJ165xs5infHgjecT+de5Jn9f0Vpc17/HJliDDbzgbmJcPYz5/d0zYk4dgPFqjBl
	eOvti2LYToWC6iveKiUjgQFrVjG+PM2GT307mw+NAdKIPICjBZVzrTrwJ+bbpFwrh4wO9DU1UGNf2
	w8S5HcEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBzIm-003Taz-Im; Mon, 24 Jan 2022 13:22:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBzIf-003TWk-J8
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 13:22:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1D85868BEB; Mon, 24 Jan 2022 14:22:22 +0100 (CET)
Date: Mon, 24 Jan 2022 14:22:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 11/13] block: move blk_exit_queue into disk_release
Message-ID: <20220124132221.GJ27269@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-12-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-12-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_052225_828070_3C534359 
X-CRM114-Status: GOOD (  22.83  )
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

On Sat, Jan 22, 2022 at 07:10:52PM +0800, Ming Lei wrote:
>  3 files changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d51b0aa2e4e4..72ae9955cf27 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3101,6 +3101,9 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  	struct blk_mq_tags *drv_tags;
>  	struct page *page;
>  
> +	if (list_empty(&tags->page_list))
> +		return;

Please split this out and document why it is needed.

> +/* Unconfigure the I/O scheduler and dissociate from the cgroup controller. */
> +static void blk_exit_queue(struct request_queue *q)
> +{
> +	/*
> +	 * Since the I/O scheduler exit code may access cgroup information,
> +	 * perform I/O scheduler exit before disassociating from the block
> +	 * cgroup controller.
> +	 */
> +	if (q->elevator) {
> +		ioc_clear_queue(q);
> +
> +		mutex_lock(&q->sysfs_lock);
> +		blk_mq_sched_free_rqs(q);
> +		elevator_exit(q);
> +		mutex_unlock(&q->sysfs_lock);
> +	}
> +}

Given that this all deals with the I/O scheduler the naming seems
wrong.  It almost seems like we'd want to move ioc_clear_queue and
blk_mq_sched_free_rqs into elevator_exit to have somewhat sensible
helpers.  That would add extra locking of q->sysfs_lock for
ioc_clear_queue, but given that elevator_switch_mq already does
that, this seems harmless.


