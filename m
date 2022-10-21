Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E09C43217
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 01:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KKA52vvbdJ19DM1uaw2+qmDoOCSKKzKeEBsIYnSVXIM=; b=JsbdFJ07TbVzCdaafuSyNs4YeC
	oRMv57c0ySZpcDlH1/fvhxPEupI6cbCVv03lS2pbh0ynsDXRT+Q6g9VPEHJDhPwga5zYUrsueQCNY
	hiMKvRNVDcEsQcDfwIfo+GsTPM1xts1J9zVTwUGqkguiOvrn1y+CVD1mtqXLgbbYBoaWSie0FY4ms
	NjGK432goxYscpOYtYPKwKePMOuHUx7Uh3c5m5tVCUjY73wIsEYQl5Dl9O5kj6ogRTxKZsIkKKGnW
	7PKqHHEikFFmI2RoNJS/fHJKM1krNPU8N5u6F+OcNi8uyvLzvPavdoPizVinVjCJcwaQVX2qwg7hB
	ZsROPDRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olgXQ-003PBf-EZ; Fri, 21 Oct 2022 01:09:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olgXO-003PAv-NF
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 01:09:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666314564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKA52vvbdJ19DM1uaw2+qmDoOCSKKzKeEBsIYnSVXIM=;
	b=O/vjA7PKayi2m7UqPhLki3PfKN5wacnTcXAcFr33b/pCml5L0KQGNstgZKm74ahT+6Jjov
	42cTm0HCn60qPiNTd3AA3+aZ7UfNhxuvmQzxAo4kMIbDGNoXwpbyFTebiyff3Pl58DJ4db
	HudEtlJ2RdGyNlzoZk7wmr7yeUSPWl0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-2wXbEbqaO-SUV26G1WUbdQ-1; Thu, 20 Oct 2022 21:09:20 -0400
X-MC-Unique: 2wXbEbqaO-SUV26G1WUbdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B47C6811E81;
	Fri, 21 Oct 2022 01:09:19 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BE16240CA41E;
	Fri, 21 Oct 2022 01:09:13 +0000 (UTC)
Date: Fri, 21 Oct 2022 09:09:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Message-ID: <Y1HxM+3bXNpsZvzk@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_180926_868293_40F10D87 
X-CRM114-Status: GOOD (  27.73  )
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

On Thu, Oct 20, 2022 at 12:56:01PM +0200, Christoph Hellwig wrote:
> nvme and xen-blkfront are already doing this to stop buffered writes from
> creating dirty pages that can't be written out later.  Move it to the
> common code.  Note that this follows the xen-blkfront version that does
> not send and uevent as the uevent is a bit confusing when the device is
> about to go away a little later, and the the size change is just to stop
> buffered writes faster.
> 
> This also removes the comment about the ordering from nvme, as bd_mutex
> not only is gone entirely, but also hasn't been used for locking updates
> to the disk size long before that, and thus the ordering requirement
> documented there doesn't apply any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c                | 3 +++
>  drivers/block/xen-blkfront.c | 1 -
>  drivers/nvme/host/core.c     | 7 +------
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 17b33c62423df..2877b5f905579 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -555,6 +555,9 @@ void blk_mark_disk_dead(struct gendisk *disk)
>  {
>  	set_bit(GD_DEAD, &disk->state);
>  	blk_queue_start_drain(disk->queue);
> +
> +	/* stop buffered writers from dirtying pages that can't written out */
> +	set_capacity(disk, 0);

The idea makes sense:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Just one small issue on mtip32xx, which may call blk_mark_disk_dead() in
irq context, and ->bd_size_lock is actually not irq safe.

But mtip32xx is already broken since blk_queue_start_drain() need mutex,
maybe mtip32xx isn't actively used at all.

Thanks,
Ming


