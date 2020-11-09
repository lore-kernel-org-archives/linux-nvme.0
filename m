Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BF9C2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 11:30:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80BA206ED
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 11:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Np26KQaX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mhdghjwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80BA206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FpqSJpgY19kI2jzaw++UI97LZOYBH+iqroTKOtfffyM=; b=Np26KQaXzo/qP/VqvHjF/+nAd
	gibKnfYHxiwnw66VmTGOroXeyLCNY5fJVhJbwtKrwElHbrULCkn1advze2ZgCOSlnjX9Fur5EyKqo
	1N6l2WatpDrRuNYgeQqZBt9v5izrEOfHyu4z/uMWDZXdjoJHnjNZWY0qpjcnZa0tid/pTul58JLFs
	EL5L5eCbO3NVLJ4JhxVHokinD+2pvKgajhFCALqS+U0oAZaJuj+zBKUZ1uECuHKclRBp+Gr4+TyRt
	enFHJbPVr5sTqR7uZEYdpZfnfHfDGMsiXlLPaDuysaMJ1i8Vt9cNI/FP4c99i1rm96PFW9AnLrw0k
	OZvEwBGDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc5NW-0003xw-4S; Mon, 09 Nov 2020 11:30:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc5NR-0003vr-IH
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 11:30:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604921424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJPHU79Z9aFII+RXhVTkpUcHO9yLNqjEBCGqyvXY310=;
 b=Mhdghjwm7aXmE8KtDoh+EzmbhcCZ/fVanmEngTLflzeq05vggxkOjk1UumQzLb3gIfuPE0
 b01VJe//ylD/9TupB5zq7XxBkX+wRthN86iWrpLkz/Qj+zonm4OGj+uXZqweSu2Ylkqtzd
 ic3smf/nMG2m4RKMmiPlGXfynm191jE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-XlwMGj6FNLSUPe7L3Zg1Hw-1; Mon, 09 Nov 2020 06:30:20 -0500
X-MC-Unique: XlwMGj6FNLSUPe7L3Zg1Hw-1
Received: by mail-wr1-f70.google.com with SMTP id f4so1151871wru.21
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 03:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qJPHU79Z9aFII+RXhVTkpUcHO9yLNqjEBCGqyvXY310=;
 b=PBoAPOwzl3P5vCJn8VbbFoQ6tRa0BI2G+ERgSSwMrIzBsadSGNjWJOlsKmxaNFSsGV
 0esXQ2dIIIpMHIy5x4h3xhqzZP0vz2NBDgan6UFar9FmQz1vumOEExiUxeQrKKqGRN+h
 y9FLruG8filJwWntqdYn606KjcOPZcr7f4D8dTIAlmnUzPjpJgu/26Bwx+zaI63Sd6RG
 KMXH5Ip5UujnP2T33RW243T9yZzsk6J1EpbzHj8V2UJjjhgwLFuKoFg5Z32xDw4Novxx
 jjldY0DNogRkG6EAUpJsGy4J2KVXLjqXZHk7767ewA3zsOpThXNqYVC8N1EboCq/bmPR
 u++Q==
X-Gm-Message-State: AOAM531pA2b+/0NZs3di64zJ1m5XT/4DWnmpIqwb58+c4oZHoySN8pHr
 Sga59kTgZJyvzStcqRRoRAkWO6Olk4r+kiQsAp2xzocushpUS0LlczRpvtlYcesuO5RwL4L4rVM
 U/C/Z4M23jRF4fofplenCTMwwZBo=
X-Received: by 2002:a05:6000:1005:: with SMTP id
 a5mr10320348wrx.425.1604921419107; 
 Mon, 09 Nov 2020 03:30:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfMfmWa9Cv9HNLSs0dLMrckBnIhQ+LX5gsNBfqeNBoHRKN7zV/cjWgtINNh6h724r5DlDOEA==
X-Received: by 2002:a05:6000:1005:: with SMTP id
 a5mr10320328wrx.425.1604921418961; 
 Mon, 09 Nov 2020 03:30:18 -0800 (PST)
Received: from redhat.com (bzq-79-181-34-244.red.bezeqint.net. [79.181.34.244])
 by smtp.gmail.com with ESMTPSA id 35sm10972366wro.71.2020.11.09.03.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 03:30:17 -0800 (PST)
Date: Mon, 9 Nov 2020 06:30:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 23/24] virtio-blk: remove a spurious call to
 revalidate_disk_size
Message-ID: <20201109063004-mutt-send-email-mst@kernel.org>
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-24-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20201106190337.1973127-24-hch@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_063025_765029_F19FEF64 
X-CRM114-Status: GOOD (  19.12  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Ilya Dryomov <idryomov@gmail.com>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 06, 2020 at 08:03:35PM +0100, Christoph Hellwig wrote:
> revalidate_disk_size just updates the block device size from the disk
> size.  Thus calling it from revalidate_disk_size doesn't actually do
> anything.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3e812b4c32e669..145606dc52db1e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -598,7 +598,6 @@ static void virtblk_update_cache_mode(struct virtio_device *vdev)
>  	struct virtio_blk *vblk = vdev->priv;
>  
>  	blk_queue_write_cache(vblk->disk->queue, writeback, false);
> -	revalidate_disk_size(vblk->disk, true);
>  }
>  
>  static const char *const virtblk_cache_types[] = {
> -- 
> 2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
