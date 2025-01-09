Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07631E77188
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 02:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NI/7sQZJsUB7MRKETVbNrqqCnlEl+xyWkxCJ71vt8Ik=; b=rCKXd8r87attmiaDFD8bd9jg97
	FoCpCkXyXTJ2OvKU+OR8v+2a2+Ju343x3SGRdt9PnWUynfwRyU4gltNO8ZuCL5uZLUodsSYOPuaII
	Ja827Ftttwca0MBmycRPSGfS9gAMKAwICqYG6Jq4pKe1Yh4KHWuXxxeljQF9l/ce5zhxRnrrB7yhf
	+gkObxVQbw33kgj4LcNrVxCS2QIrPo4x5kHVetu8HHDJqL+ytON3EMgj5201tnb26P77XgOIn71Fi
	w25763n+5x7gXHZMmmXuT1vlJUSqU0hPlQDcb0D39tGgSBUPAQ9Mpwkxh4y5JJafVOLZS2O6zUNfr
	jpY0QNOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVi8G-0000000AOgM-07yz;
	Thu, 09 Jan 2025 02:18:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVi8D-0000000AOfx-3dIG
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 02:18:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736389124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NI/7sQZJsUB7MRKETVbNrqqCnlEl+xyWkxCJ71vt8Ik=;
	b=V+nN4OyWBfG3z4dZ9+afDCTv/Zd5rRxpzBQGnwrU+pVaeIu4J76RFm8jsGxEtrfRg4ilCg
	Wq6dSNkhj+G6FW9A1ETbHZugUImcAtC2/d4pqNpNGXDOEfIvwf3gcNo5yO8nHl/+JPUVr/
	62HOyE01WeZQZLm/6/eXVceNGUJmtWw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-7FSoSldJMXm3ogIjfdzqow-1; Wed,
 08 Jan 2025 21:18:37 -0500
X-MC-Unique: 7FSoSldJMXm3ogIjfdzqow-1
X-Mimecast-MFC-AGG-ID: 7FSoSldJMXm3ogIjfdzqow
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3DF5195608B;
	Thu,  9 Jan 2025 02:18:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EB1419560AD;
	Thu,  9 Jan 2025 02:18:28 +0000 (UTC)
Date: Thu, 9 Jan 2025 10:18:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 03/10] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
Message-ID: <Z38x7mzrQPEiUOpv@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-4-hch@lst.de>
 <Z35T8xeLxhXe-zAS@fedora>
 <20250108152705.GA24792@lst.de>
 <a3bd231c-0568-4dad-9268-bc7edaace94b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3bd231c-0568-4dad-9268-bc7edaace94b@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_181845_976102_F9721B94 
X-CRM114-Status: GOOD (  26.19  )
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

On Thu, Jan 09, 2025 at 09:05:49AM +0900, Damien Le Moal wrote:
> On 1/9/25 00:27, Christoph Hellwig wrote:
> > On Wed, Jan 08, 2025 at 06:31:15PM +0800, Ming Lei wrote:
> >>> -	if (!(q->limits.features & BLK_FEAT_POLL) &&
> >>> -			(bio->bi_opf & REQ_POLLED)) {
> >>> +	if ((bio->bi_opf & REQ_POLLED) && !bdev_can_poll(bdev)) {
> >>
> >> submit_bio_noacct() is called without grabbing .q_usage_counter,
> >> so tagset may be freed now, then use-after-free on q->tag_set?
> > 
> > Indeed.  That also means the previous check wasn't reliable either.
> > I think we can simple move the check into
> > blk_mq_submit_bio/__submit_bio which means we'll do a bunch more
> > checks before we eventually fail, but otherwise it'll work the
> > same.
> 
> Given that the request queue is the same for all tag sets, I do not think we

No, it isn't same.

> need to have the queue_limits_start_update()/commit_update() within the tag set
> loop in __blk_mq_update_nr_hw_queues(). So something like this should be enough
> for an initial fix, no ?
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8ac19d4ae3c0..ac71e9cee25b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4986,6 +4986,7 @@ static void __blk_mq_update_nr_hw_queues(struct
> blk_mq_tag_set *set,
>                                                         int nr_hw_queues)
>  {
>         struct request_queue *q;
> +       struct queue_limits lim;
>         LIST_HEAD(head);
>         int prev_nr_hw_queues = set->nr_hw_queues;
>         int i;
> @@ -4999,8 +5000,10 @@ static void __blk_mq_update_nr_hw_queues(struct
> blk_mq_tag_set *set,
>         if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
>                 return;
> 
> +       lim = queue_limits_start_update(q);
>         list_for_each_entry(q, &set->tag_list, tag_set_list)
>                 blk_mq_freeze_queue(q);

It could be worse, since the limits_lock is connected with lots of other
subsystem's lock(debugfs, sysfs dir, ...), it may introduce new deadlock
risk.

Thanks,
Ming


