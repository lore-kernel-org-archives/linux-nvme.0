Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96167C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 01:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x0x7La/KJwWUwTRhdc113nlLBaY7LHMOa3RNzKxynnI=; b=sNuKCB+CcPItQBb5zF59yONc3Q
	U1ce9Aqlg9i8+dWjV7x/v4jaqT7B+/N69yi7blFFZOEydVvRiPbJ61YThAiEUzv07XWlf2PUDwk1P
	zG6ZYawHgQ2M1x2/j924MW9cTzn0BsrYXCW5VAH1Izzi2DWZaQHBGz4yzjJFkTH4K8187FDawTW/r
	vGibS87thOJ10XGYDKowWd4mpmqqsadoaxQR2loL+n/WvsbQDwcZICLdUMv0Ua5RF2RT787D9wicS
	ursPG1LWH21G3uPdXhUCTW3RKwrnBR/mTe89qt7+6Rw5rWXjZA6PmHFuMXidqwqqvJz4YewNJ37J+
	CAMkK6yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olgbp-003QdC-UH; Fri, 21 Oct 2022 01:14:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olgbn-003Qba-BK
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 01:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666314838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x0x7La/KJwWUwTRhdc113nlLBaY7LHMOa3RNzKxynnI=;
	b=hhxpfZMrfULYMogzmjHj3YnjUvzwuZBgGlEIsbOJVYzyPt0jUPdooaSdjAE+VyIFDyMv2g
	0U4nV+kN6BMN7a7f5Z+CNZVeGi75QVfGkAIwxtP/+djPySrS9OGTuWRkU/NpvVio7Ad6DS
	r8LBrqVLvQlwj8lI4rwFsfaXJt4PwbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-eDA5xFHcP06FD__MNwUdQg-1; Thu, 20 Oct 2022 21:13:54 -0400
X-MC-Unique: eDA5xFHcP06FD__MNwUdQg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69E14800186;
	Fri, 21 Oct 2022 01:13:48 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A7486426205;
	Fri, 21 Oct 2022 01:13:36 +0000 (UTC)
Date: Fri, 21 Oct 2022 09:13:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Message-ID: <Y1HyOS9A72GZIQWT@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_181359_474511_997B4298 
X-CRM114-Status: GOOD (  20.38  )
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

On Thu, Oct 20, 2022 at 12:56:02PM +0200, Christoph Hellwig wrote:
> For submit_bio based queues there is no (S)RCU critical section during
> I/O submission and thus nothing to wait for in blk_mq_wait_quiesce_done,
> so skip doing any synchronization.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 33292c01875d5..df967c8af9fee 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -280,7 +280,9 @@ EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
>  void blk_mq_quiesce_queue(struct request_queue *q)
>  {
>  	blk_mq_quiesce_queue_nowait(q);
> -	blk_mq_wait_quiesce_done(q);
> +	/* nothing to wait for non-mq queues */
> +	if (queue_is_mq(q))
> +		blk_mq_wait_quiesce_done(q);

This interface can't work as expected for bio drivers, the only user
should be del_gendisk(), but anyway the patch is fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming


