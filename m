Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350B9C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:23:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5C861027
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE5C861027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=di/mgHWCbOSixMC0cEIa3R/F3C7ddJkvJ703pJuD8+8=; b=cIw0k+6fJ625zo
	LrmoMqLG7UC3C9Te1cLSFD+ApSZdr0oC8UdrTMGS/AqntL+Ra1FJcFMFcn0pxwWtza1e8KAGklZ6J
	sBo3zSyECqWXaeQb0lSF5Np2ThO4KUDgdZp4V6DdQhYueoNvzfMDFaVjEdhQ5S9G7tRHFmMAB2f74
	T4p4JgJIdtdwOhLOxeo5ma4q5xX8aNg13xtz7BxmndKpG0I4dA44JJOCcZmXuG1uny9onD0Ixc7Xr
	X7CjYYFsdoBVGham4dGyTJJzD9CTdaGwJ87gmDekJwpk/Yoi9/USi2k67lvZuV2iqhdV7oZaeRp6H
	O/JnsTl14V+qSfm7LB8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1macLx-00GHwl-9c; Wed, 13 Oct 2021 11:23:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mab3c-00FsGu-EU
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 10:00:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634119219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9gPj3nuZlcSDGfCiGQhu51vhw4f1xgSFD80SN59RDZY=;
 b=XDsKe2MvPRWD/xmNwabRsoNv61cV5B3A4PXg11Pe0ZbDFgO8Ox/BEUkCnzpA1/WbbSzqAa
 c792StwPzcRoo/zRfU+SoRQGXYlkpYkfGqM4Temcd0Plp2qmJU4NrNiYUeuoIwByKdl9lL
 qpXnIRXyaIQJECAls9NOVGZaellxmz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-FYSHSaNTM9W_bThuF7esPw-1; Wed, 13 Oct 2021 06:00:09 -0400
X-MC-Unique: FYSHSaNTM9W_bThuF7esPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04A5919057A0;
 Wed, 13 Oct 2021 10:00:08 +0000 (UTC)
Received: from T590 (ovpn-8-39.pek2.redhat.com [10.72.8.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CC5B1972D;
 Wed, 13 Oct 2021 10:00:02 +0000 (UTC)
Date: Wed, 13 Oct 2021 17:59:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
Message-ID: <YWauHUIqvS29pLnW@T590>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211012111226.760968-15-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_030020_600718_3E9DA148 
X-CRM114-Status: GOOD (  24.27  )
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

On Tue, Oct 12, 2021 at 01:12:24PM +0200, Christoph Hellwig wrote:
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
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
> ---

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

Now bdev, gendisk and request_queue are freed after RCU grace period, so this
way is safe since 340e84573878 ("block: delay freeing the gendisk").


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
