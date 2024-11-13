Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA4CD637D0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RzPWmh0C8RYeAeZIKKXP7q682GlgR+SBS+qZzgFuwNs=; b=erdunPt6hYG0WLQIvHEzkl6BJV
	Gd/54mUA/nv0iISfFW2pbY9Rb6fNLxm8qJn4tKEQYfAmVZCdMMLV8gl/LIaQgvID/GXBlXOxnVQ7t
	IiDtwRE8IL30pzq9zRnpwKB8eO6gi64pU+w6FWDp5b8Cmta3X/1Bs3778vr+m388wru/R81ieUEcd
	pjPfgfqeDr6SXn/7djXS5chwZ7Zzm1zXrRGTLtcGAIlKL8kYIjWRnZo5tvjWdIcMXtpbMB7zxfzhG
	PEZtjKjqS5RVTraWOfcp1M/j43ZMf6lCupaKVQn4uwODesDdUYP0s66q/m4o64uOAQGT3U8+01Rqm
	YyU1Pw0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBMjs-00000008FS5-3Rri;
	Wed, 13 Nov 2024 23:25:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBMjn-00000008FRR-3phj
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 23:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731540325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzPWmh0C8RYeAeZIKKXP7q682GlgR+SBS+qZzgFuwNs=;
	b=EBlJwugVyTv4v7FEJK6h+3JKlGtyGwvSoTI1ot9iGgtIadmBjNPv44YflKhMSPqg6h50ts
	NqarZL3Bo9EYzJMRbtjg9EHKMrRiPJlpW4+x6cD+3l3XG0C6xVcGYstvETslge3gTLNPLe
	1ER2k0EGu9dNQPWISQ3Ie0PjSckuD+w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-nMhwoVnqMQaw94FQXCcIsw-1; Wed, 13 Nov 2024 18:25:21 -0500
X-MC-Unique: nMhwoVnqMQaw94FQXCcIsw-1
X-Mimecast-MFC-AGG-ID: nMhwoVnqMQaw94FQXCcIsw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso273875e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 15:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731540320; x=1732145120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzPWmh0C8RYeAeZIKKXP7q682GlgR+SBS+qZzgFuwNs=;
        b=lyyA75nR7lyElSn2SJIDQxQrWeeYVhQdpn94huuautDLxv+v32eF3JrmLXq8kW0tAK
         GJDG4FB6FKZAwlDplNNTd+hJZfkDM4MSst/1fNIyTKEjav5+YJbgTPCmMxrKM/oTrpl2
         UqMq0F8z7a0xnI5DjuvJTx1WDYUbpAO7be43PmDGhZdaIKM9lyiU1Pxz8tQmPETaYYfd
         mhsgrEtQl0AE1zeAurm7paS7vNUEcWXaLr4H71m5z1Aw9LjnnNDzcfZTQZ/IhxISd8nm
         o1/PA9welL6Ha8i7ueCEQLbiPFSt/FRdA3a44gN2CE2otJHSsdgEoz30DztDyJ8WvKN1
         clzg==
X-Forwarded-Encrypted: i=1; AJvYcCWgZFhJdI1xoB11rBuyAyzDE1Rrl+OVVTFh/rja9lRjKrmKVwpZ1XkxrK12jA2jO5RojbsDfHJn+ZjT@lists.infradead.org
X-Gm-Message-State: AOJu0YxWOSCT8LACU9fs7E2G+U94kCSxLT6c2SxJmyGoJzQGbVZ4hoF7
	Ayv0O1Cc1gR7POEwVmwbx5F1Zakcj1IFMF/feefXwHV89AP/j87R7TDFGOp2y7x0f/1Q2eKAbl5
	wJqpsJoGBaqRpncRM367pWEfLR9XhcM3bIOwqAtiLkDijddvH/+/ZlNvoKHr4RnnG
X-Received: by 2002:a05:600c:3d8d:b0:431:4847:47c0 with SMTP id 5b1f17b1804b1-432da76ec4amr935445e9.7.1731540320199;
        Wed, 13 Nov 2024 15:25:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDNE+4rEsYxD1YNYi7V9qyaFYVxzcxTW8otS2BtZTbP6JFcM1ds70h/SDQ68r3Vw5bW0apPw==
X-Received: by 2002:a05:600c:3d8d:b0:431:4847:47c0 with SMTP id 5b1f17b1804b1-432da76ec4amr935285e9.7.1731540319813;
        Wed, 13 Nov 2024 15:25:19 -0800 (PST)
Received: from redhat.com ([2.55.171.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d9d0a4absm4692895e9.24.2024.11.13.15.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 15:25:18 -0800 (PST)
Date: Wed, 13 Nov 2024 18:25:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 2/6] virtio_blk: reverse request order in virtio_queue_rqs
Message-ID: <20241113182448-mutt-send-email-mst@kernel.org>
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-3-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20241113152050.157179-3-hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 00Njm4Pbxdj5Nd4lRc_Dj-66r6KbDx4RQzwlBoeuWDY_1731540320
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_152528_050099_67082D0B 
X-CRM114-Status: GOOD (  27.98  )
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

On Wed, Nov 13, 2024 at 04:20:42PM +0100, Christoph Hellwig wrote:
> blk_mq_flush_plug_list submits requests in the reverse order that they
> were submitted, which leads to a rather suboptimal I/O pattern especially
> in rotational devices.  Fix this by rewriting nvme_queue_rqs so that it
> always pops the requests from the passed in request list, and then adds
> them to the head of a local submit list.  This actually simplifies the
> code a bit as it removes the complicated list splicing, at the cost of
> extra updates of the rq_next pointer.  As that should be cache hot
> anyway it should be an easy price to pay.
> 
> Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 46 +++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 0e99a4714928..b25f7c06a28e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -471,18 +471,18 @@ static bool virtblk_prep_rq_batch(struct request *req)
>  	return virtblk_prep_rq(req->mq_hctx, vblk, req, vbr) == BLK_STS_OK;
>  }
>  
> -static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
> +static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
>  					struct request **rqlist)
>  {
> +	struct request *req;
>  	unsigned long flags;
> -	int err;
>  	bool kick;
>  
>  	spin_lock_irqsave(&vq->lock, flags);
>  
> -	while (!rq_list_empty(*rqlist)) {
> -		struct request *req = rq_list_pop(rqlist);
> +	while ((req = rq_list_pop(rqlist))) {
>  		struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> +		int err;
>  
>  		err = virtblk_add_req(vq->vq, vbr);
>  		if (err) {
> @@ -495,37 +495,33 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
>  	kick = virtqueue_kick_prepare(vq->vq);
>  	spin_unlock_irqrestore(&vq->lock, flags);
>  
> -	return kick;
> +	if (kick)
> +		virtqueue_notify(vq->vq);
>  }
>  
>  static void virtio_queue_rqs(struct request **rqlist)
>  {
> -	struct request *req, *next, *prev = NULL;
> +	struct request *submit_list = NULL;
>  	struct request *requeue_list = NULL;
> +	struct request **requeue_lastp = &requeue_list;
> +	struct virtio_blk_vq *vq = NULL;
> +	struct request *req;
>  
> -	rq_list_for_each_safe(rqlist, req, next) {
> -		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
> -		bool kick;
> -
> -		if (!virtblk_prep_rq_batch(req)) {
> -			rq_list_move(rqlist, &requeue_list, req, prev);
> -			req = prev;
> -			if (!req)
> -				continue;
> -		}
> +	while ((req = rq_list_pop(rqlist))) {
> +		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req->mq_hctx);
>  
> -		if (!next || req->mq_hctx != next->mq_hctx) {
> -			req->rq_next = NULL;
> -			kick = virtblk_add_req_batch(vq, rqlist);
> -			if (kick)
> -				virtqueue_notify(vq->vq);
> +		if (vq && vq != this_vq)
> +			virtblk_add_req_batch(vq, &submit_list);
> +		vq = this_vq;
>  
> -			*rqlist = next;
> -			prev = NULL;
> -		} else
> -			prev = req;
> +		if (virtblk_prep_rq_batch(req))
> +			rq_list_add(&submit_list, req); /* reverse order */
> +		else
> +			rq_list_add_tail(&requeue_lastp, req);
>  	}
>  
> +	if (vq)
> +		virtblk_add_req_batch(vq, &submit_list);
>  	*rqlist = requeue_list;
>  }



looks ok from virtio POV

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> -- 
> 2.45.2


