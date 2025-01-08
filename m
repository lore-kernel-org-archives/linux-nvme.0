Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE6AE77199
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RFF47yrkVJBHoWSFdhCxN9Pmr1E8ln/cV1XqKCoPz5s=; b=o4n0G8YmNUSn4GlO4KOayL29Qd
	/xQyP53fugAN+k9PIZJXTNB7/Y7qkx9JuMCVfy237sSAxfQs3rzSeYvJjP4RC/8XwOhaclAd6WiaF
	Cd5wJJH+eCcbERCl5MWY9fZfcVU3BhyRImb8vtEV49zte0Egc9ItdepOUT5gLpQ97AM9xhvD/7xWX
	095peJVWH7NYOr3HyZk7b/rkbllVyKH+u5WkEOS8LVKA3Kkj6DrfKRi7uhws+qQ0KHJzjEmtded7A
	wdw/mfnLmUthl2k5RXiqjaZl4VpFfYMrY39vHq4AJn1ulUsAUE1yuYGFr4RjGB8EsXnRew6V9QWWL
	YLymi/9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTLb-00000007zez-0AEf;
	Wed, 08 Jan 2025 10:31:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTLY-00000007ze2-0sKm
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:31:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736332290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFF47yrkVJBHoWSFdhCxN9Pmr1E8ln/cV1XqKCoPz5s=;
	b=fa91VBslBPrG6+GNzABaASdGhXVcmqkfyc6n4gvSnQTBWF36fU/35/pNmR94pIifnmm1+E
	JOLQPJNBEM3Gl0y7bqzaCkKtuO6tEiHlhbIqRpXKTJkEhe8CIluRMItvXYhERKOkMae/7N
	cTobu6kRnUr6t9y/Ymid1rZ4CqJ5FvE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-FT0j9aoPO92yisgQAdt35g-1; Wed,
 08 Jan 2025 05:31:29 -0500
X-MC-Unique: FT0j9aoPO92yisgQAdt35g-1
X-Mimecast-MFC-AGG-ID: FT0j9aoPO92yisgQAdt35g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B995719560BB;
	Wed,  8 Jan 2025 10:31:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC26F1956053;
	Wed,  8 Jan 2025 10:31:21 +0000 (UTC)
Date: Wed, 8 Jan 2025 18:31:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 03/10] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
Message-ID: <Z35T8xeLxhXe-zAS@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108092520.1325324-4-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_023132_316701_92D12F61 
X-CRM114-Status: GOOD (  19.94  )
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

On Wed, Jan 08, 2025 at 10:25:00AM +0100, Christoph Hellwig wrote:
> When __blk_mq_update_nr_hw_queues changes the number of tag sets, it
> might have to disable poll queues.  Currently it does so by adjusting
> the BLK_FEAT_POLL, which is a bit against the intent of features that
> describe hardware / driver capabilities, but more importantly causes
> nasty lock order problems with the broadly held freeze when updating the
> number of hardware queues and the limits lock.  Fix this by leaving
> BLK_FEAT_POLL alone, and instead check for the number of poll queues in
> the bio submission and poll handlers.  While this adds extra work to the
> fast path, the variables are in cache lines used by these operations
> anyway, so it should be cheap enough.
> 
> Fixes: 8023e144f9d6 ("block: move the poll flag to queue_limits")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
...

>  /**
>   * submit_bio_noacct - re-submit a bio to the block device layer for I/O
>   * @bio:  The bio describing the location in memory and on the device.
> @@ -805,8 +817,7 @@ void submit_bio_noacct(struct bio *bio)
>  		}
>  	}
>  
> -	if (!(q->limits.features & BLK_FEAT_POLL) &&
> -			(bio->bi_opf & REQ_POLLED)) {
> +	if ((bio->bi_opf & REQ_POLLED) && !bdev_can_poll(bdev)) {

submit_bio_noacct() is called without grabbing .q_usage_counter,
so tagset may be freed now, then use-after-free on q->tag_set?


Thanks,
Ming


