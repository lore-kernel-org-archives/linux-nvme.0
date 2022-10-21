Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF165C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 01:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rubxu5P5m0yu63YebC/bkr+rMDHRCz0exG7/VTY1p5I=; b=TkuYAfe1LRbMNUVRzFqXk4adHb
	7BlOx8deiYde2HlSrOttGCzXQLm0n0H/TrzzBXlGcmBJYQsEH2YUwanPftT+wzAEO58KPyofodQ5a
	1BZfG+3miLpnKzw4edYi+9eas7qHrnFaRoH2YIfLgjMCoNCj2JMbkCScAb9i3ZeSOZT+Cmy7VP/a4
	Q/jZoVlTgye73InIrbJOHpge1zwpw6L7W/4X9gj6zYpYl8yQyuiKPCy9RAYX8mAMBXXzFa6dSsJRA
	qJSf/LkA9S1m/xLazeLbtoAUJOVWOu7XQHVq2v4AppeEMhZZGTxUECibpiXsuIhN/mzvjEeu+JvWv
	J+q00eFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olh7q-004GuM-S4; Fri, 21 Oct 2022 01:47:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olh7o-004Gsx-LH
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 01:47:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666316822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rubxu5P5m0yu63YebC/bkr+rMDHRCz0exG7/VTY1p5I=;
	b=EylaCPAWZw/3njkpXP3EnCTH62q9pH2/dXmLxX3jSXja2/9T2G/yXZ4rhUCWqPmy6XR+vV
	0uhttkZKK1t+usKalAaaVHS7N9M4jHmNZPe/Cl+8Mdsz04CVsdMNC57EwcVUmRV/R2YjsV
	XrN+HrKZt58rWIMP0CuAD7/MrfEce4E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-WYpq7VaSOFCIvvnJf5CBIA-1; Thu, 20 Oct 2022 21:46:58 -0400
X-MC-Unique: WYpq7VaSOFCIvvnJf5CBIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C65593810D51;
	Fri, 21 Oct 2022 01:46:56 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E989D40E8B14;
	Fri, 21 Oct 2022 01:46:42 +0000 (UTC)
Date: Fri, 21 Oct 2022 09:46:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/8] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Message-ID: <Y1H5+Z5HotPo7yWV@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-5-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_184704_937799_01AE3A44 
X-CRM114-Status: GOOD (  22.56  )
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

On Thu, Oct 20, 2022 at 12:56:04PM +0200, Christoph Hellwig wrote:
> Noting in blk_mq_wait_quiesce_done needs the request_queue now, so just
> pass the tagset, and move the non-mq check into the only caller that
> needs it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c           | 10 +++++-----
>  drivers/nvme/host/core.c |  4 ++--
>  drivers/scsi/scsi_lib.c  |  2 +-
>  include/linux/blk-mq.h   |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4a81a2da43328..cf8f9f9a96c35 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -254,15 +254,15 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
>  /**
>   * blk_mq_wait_quiesce_done() - wait until in-progress quiesce is done
> - * @q: request queue.
> + * @set: tag_set to wait on
>   *
>   * Note: it is driver's responsibility for making sure that quiesce has
>   * been started.
>   */
> -void blk_mq_wait_quiesce_done(struct request_queue *q)
> +void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set)

The change is fine, but the interface could confuse people, it
looks like it is waiting for whole tagset quiesced, but it needs
to mark all request queues as quiesced first, otherwise it is just
wait for one specific queue's quiesce.

So suggest to document such thing.


Thanks,
Ming


