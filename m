Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD97C48BDF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 02:31:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110A361246
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 02:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110A361246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dg2QKwBe3Vd9h8u9dE0VNNz+lCtxZUQXD8Lg+Dai+tY=; b=da18gVUjyb7J8+
	5AI14wo7cAlRLfCCQBjbs9jkthLbRnkiY3QdpqYiyLB+5Du3+xWPql/APZqF2FbTb+Gozk/Ep6Eal
	oqQzVZEN8VpuUTRBo+KdttcFEW6hqnDiSk8biZc/aB/oZcyGabbTRLeA40BUqkxsYtpJ5QbR4Ousc
	k+HA5k2eLKpr8WrxSbctG+crfzeiBwGMLtxoEOn7a4U1khKg7S9Yh7tHz9ypvqcWPsOdFwyBs1ONQ
	rVxEnFKrkdp8TRuuUugh25p65+Aw1eHxRHIiprnYvqCC8SosuGIAew0cv93WoSvrOX3gGzksZXwzE
	V88plLuZkGBm8i4H7nGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltLKJ-004Sr5-Jt; Wed, 16 Jun 2021 02:30:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltLKG-004SqO-M1
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 02:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623810643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6D2FLYsK7JeK0vnQ+MjYTD2DRF3ATEwQXscjYAEAPw=;
 b=QUG77u2hD/FOit7DzOPd8fUryhLt4SlklbxbKI8b39cglXIQq83amg1BjmBscDGsFYZEtM
 3A7gbli/eFCQtbXU6ZbbkJTs5UnmcAneTODUKO9oFctMHWctE4bHw2CLi8V3h6wHvkqBp/
 Rx3Fcxiaavff70C5mVh2ti8zGLEDfM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Y5zuCd8_MzeZ5AjSJEsUuQ-1; Tue, 15 Jun 2021 22:30:39 -0400
X-MC-Unique: Y5zuCd8_MzeZ5AjSJEsUuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13ACF81840D;
 Wed, 16 Jun 2021 02:30:38 +0000 (UTC)
Received: from T590 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EF9119C66;
 Wed, 16 Jun 2021 02:30:28 +0000 (UTC)
Date: Wed, 16 Jun 2021 10:30:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/16] block: switch polling to be bio based
Message-ID: <YMliP6sFVuPhMbOB@T590>
References: <20210615131034.752623-1-hch@lst.de>
 <20210615131034.752623-14-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210615131034.752623-14-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_193044_842105_80EEEB9A 
X-CRM114-Status: GOOD (  33.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 15, 2021 at 03:10:31PM +0200, Christoph Hellwig wrote:
> Replace the blk_poll interface that requires the caller to keep a queue
> and cookie from the submissions with polling based on the bio.
> 
> Polling for the bio itself leads to a few advantages:
> 
>  - the cookie construction can made entirely private in blk-mq.c
>  - the caller does not need to remember the request_queue and cookie
>    separately and thus sidesteps their lifetime issues
>  - keeping the device and the cookie inside the bio allows to trivially
>    support polling BIOs remapping by stacking drivers
>  - a lot of code to propagate the cookie back up the submission path can
>    be removed entirely.
> 

...

> +/**
> + * bio_poll - poll for BIO completions
> + * @bio: bio to poll for
> + * @flags: BLK_POLL_* flags that control the behavior
> + *
> + * Poll for completions on queue associated with the bio. Returns number of
> + * completed entries found.
> + *
> + * Note: the caller must either be the context that submitted @bio, or
> + * be in a RCU critical section to prevent freeing of @bio.
> + */
> +int bio_poll(struct bio *bio, unsigned int flags)
> +{
> +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> +	int ret;
> +
> +	if (cookie == BLK_QC_T_NONE ||
> +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> +		return 0;
> +
> +	if (current->plug)
> +		blk_flush_plug_list(current->plug, false);
> +
> +	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
> +		return 0;
> +	if (WARN_ON_ONCE(!queue_is_mq(q)))
> +		ret = 0;	/* not yet implemented, should not happen */
> +	else
> +		ret = blk_mq_poll(q, cookie, flags);
> +	blk_queue_exit(q);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(bio_poll);
> +
> +/*
> + * Helper to implement file_operations.iopoll.  Requires the bio to be stored
> + * in iocb->private, and cleared before freeing the bio.
> + */
> +int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags)
> +{
> +	struct bio *bio;
> +	int ret = 0;
> +
> +	/*
> +	 * Note: the bio cache only uses SLAB_TYPESAFE_BY_RCU, so bio can
> +	 * point to a freshly allocated bio at this point.  If that happens
> +	 * we have a few cases to consider:
> +	 *
> +	 *  1) the bio is beeing initialized and bi_bdev is NULL.  We can just
> +	 *     simply nothing in this case
> +	 *  2) the bio points to a not poll enabled device.  bio_poll will catch
> +	 *     this and return 0
> +	 *  3) the bio points to a poll capable device, including but not
> +	 *     limited to the one that the original bio pointed to.  In this
> +	 *     case we will call into the actual poll method and poll for I/O,
> +	 *     even if we don't need to, but it won't cause harm either.
> +	 *
> +	 * For cases 2) and 3) above the RCU grace period ensures that bi_bdev
> +	 * is still allocated. Because partitions hold a reference to the whole
> +	 * device bdev and thus disk, the disk is also still valid.  Grabbing
> +	 * a reference to the queue in bio_poll() ensures the hctxs and requests
> +	 * are still valid as well.
> +	 */

Not sure disk is valid, we only hold the disk when opening a bdev, but
the bdev can be closed during polling. Also disk always holds one
reference on request queue, so if disk is valid, no need to grab queue's
refcnt in bio_poll().


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
