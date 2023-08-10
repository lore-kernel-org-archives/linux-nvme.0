Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DE9C001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNpUhxfG0oagA+OSHR3CBYIVBwq8hSKrFiUJQDT85NI=; b=FMTtOtkzPwCx3qn1W2OYoXKkGl
	PY8vkgDzEXFzkscULfE+tvbRilX1C7XX9HLfauor9EJWX1Bg09WfhbbpWDzbCAC/NrrhfIW+3hYDC
	6IWzlYttE8mQfNEkTUKqlWQnQ6uCtXl+dpMqNKgiXdxlFliSwd16aJ9MYS8oWqwo8DfUzaxDiKr/x
	/pTL8JeAs6v2YRN9CX4vVArzA0FEcFmCzA1LQDYiKcRaVWsknmkMmW1aT1QHV+0pm8+FXBmHhKvwh
	HZbbam30axJ5WfJS4FQopL22Rxtzmup6Zs/AJU2TKJPTRgWGfjoS3q+HKEebYzFwZDAvLz389bPW2
	stY38w1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUBGK-008XZ1-0S;
	Thu, 10 Aug 2023 19:24:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUBGH-008XXN-08
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 19:23:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691695435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eNpUhxfG0oagA+OSHR3CBYIVBwq8hSKrFiUJQDT85NI=;
	b=a5C3fAnJillqqDzf9asR/dEcy1BHnCTsbNR3l8JqIohN80KAuZbOM08fcl5sKOfJ6nwQ+B
	cGEqAUNmS42uRAdgcu2BCwJxJKPSh8W87nqlMm329I2Cucs6qZyouwspilCaED6edzzuDU
	vxqesVNudAiZBnogVVknCvWG9s67y90=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Ycvn7fE-Nk-dZlyw2Uenpg-1; Thu, 10 Aug 2023 15:23:54 -0400
X-MC-Unique: Ycvn7fE-Nk-dZlyw2Uenpg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3176eb6babbso1067859f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 10 Aug 2023 12:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695433; x=1692300233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNpUhxfG0oagA+OSHR3CBYIVBwq8hSKrFiUJQDT85NI=;
        b=Ps1TPS/kkG4v3l9UWIVVVesvc7cj117JNNdxGeuIxbjojOiDkW6p8GjeRoe/qu4dkk
         yT1NHgj07DKg8GpBWRQEXplZc4cJ01rRzTgj38x9gomYdRrYn76BZrTFIQ6wM/cdiFKF
         getXuPg7gpveDolezH900hg3hGEy2E5BvdOoXAq54qH9jzzFnbzZzopGC/taxUO0kwOE
         A+S9UMi5Fa2D4nneus0tF9NHOmp2xTYno3lReyWh7qaZ1R8mbtmlxbXSwJZPFVukcwGC
         MitX4KOnL2ayJNzdSm2p90WbNiDkepQhAvS/j2XnTD7E0mD3IO5Z0odz+TDsuAvzpYO8
         UZLw==
X-Gm-Message-State: AOJu0Yw4UC0BcA3MDLYQFTL94NIjfALcSIrtnrB6Tix0o+e2bolJsYS6
	j00ZphFQCi342cbR08/OZmrL+zHWMQmlyFgK2fyoErXzh9pUsXUYd3H1UpBUyj/xs2b5En3/NLc
	eh3aDsUsqhZFYi+AvKLo9Za8iP+w=
X-Received: by 2002:a5d:444d:0:b0:317:ce01:fe99 with SMTP id x13-20020a5d444d000000b00317ce01fe99mr2842388wrr.9.1691695433189;
        Thu, 10 Aug 2023 12:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR0CV1UmR4DNEMAn9v2ToSkc3HIbFYdNRmAuQjKcn2GH2b+kNRcs5y/tG7/rWE1x5qPYNz9w==
X-Received: by 2002:a5d:444d:0:b0:317:ce01:fe99 with SMTP id x13-20020a5d444d000000b00317ce01fe99mr2842373wrr.9.1691695432826;
        Thu, 10 Aug 2023 12:23:52 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d6886000000b00317f01fa3c4sm3018221wru.112.2023.08.10.12.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:23:52 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:23:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V3 04/14] virtio-blk: limit max allowed submit queues
Message-ID: <20230810152310-mutt-send-email-mst@kernel.org>
References: <20230808104239.146085-1-ming.lei@redhat.com>
 <20230808104239.146085-5-ming.lei@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230808104239.146085-5-ming.lei@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_122357_144217_B4CFB934 
X-CRM114-Status: GOOD (  23.11  )
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

On Tue, Aug 08, 2023 at 06:42:29PM +0800, Ming Lei wrote:
> Take blk-mq's knowledge into account for calculating io queues.
> 
> Fix wrong queue mapping in case of kdump kernel.
> 
> On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> still returns all CPUs because 'maxcpus=1' just bring up one single
> cpu core during booting.
> 
> blk-mq sees single queue in kdump kernel, and in driver's viewpoint
> there are still multiple queues, this inconsistency causes driver to apply
> wrong queue mapping for handling IO, and IO timeout is triggered.
> 
> Meantime, single queue makes much less resource utilization, and reduce
> risk of kernel failure.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

superficially:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but this patch only makes sense if the rest of patchset is merged.
feel free to merge directly.

> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 1fe011676d07..4ba79fe2a1b4 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1047,7 +1047,8 @@ static int init_vq(struct virtio_blk *vblk)
>  
>  	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
>  
> -	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
> +	vblk->io_queues[HCTX_TYPE_DEFAULT] = min_t(unsigned,
> +			num_vqs - num_poll_vqs, blk_mq_max_nr_hw_queues());
>  	vblk->io_queues[HCTX_TYPE_READ] = 0;
>  	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
>  
> -- 
> 2.40.1


