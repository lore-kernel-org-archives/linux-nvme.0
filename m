Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB469C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 02:53:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1510A23888
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 02:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1510A23888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xvpwZfMacCkk4lsgSYgrmVHN/0DkDYfILs0sBcvAdg8=; b=T9NEWdg/pY6TdMYxGmgqtCRBA
	VSKNwkFFDgpeCHKtNGMF7A9uLm9m5qm7zE9ZOFQ5C9KJLUdZYAo03jxSt8FyLDagpIPPvfiYifijF
	l7jO56nxF5KqdtgQl8KJa2fMHhf295ExuzKTkDosPuuCJpzjzczP79xxCHAR/CA8N+FA/amvufYb+
	PkYqx9OkYRizgLxjrXaRVteIudTmi/JNeMs6gegiXbmDBhjHrNMjEtqi0SX7QGET/kB+G+z5VcLOl
	Dgp1LZj23TD+B5r906rWRaCywHWiCODWzEZntUcrhI1YFiqN9ndolNrqa/BgHzrPxQLPN13y3efYG
	FTuUJssqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmpbF-00008G-NG; Wed, 09 Dec 2020 02:53:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmpbD-00007k-GW
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 02:53:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607482383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cFNY6oR+hixdAWaVKQm4SgGYUWW8X4hMf/ko6NanEgg=;
 b=Cds9MCj9zTNt580aj687JYv2uwlK5g/aR20yGlmmdtjQQ8+tKgvuFWdJV1LsocXv/28VcK
 /KYUMnw+oiGqXaPplN3xLz3EK+1EmmIj4t4tCd+opZU5UXKi3tffzp4eiheDtZYt7pmync
 AZKp5i63jN2t4bM8pUmU+4MGKYGD0m0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-q6C_rUbMONuOm0y1RKtmGw-1; Tue, 08 Dec 2020 21:52:59 -0500
X-MC-Unique: q6C_rUbMONuOm0y1RKtmGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A816107ACE3;
 Wed,  9 Dec 2020 02:52:57 +0000 (UTC)
Received: from T590 (ovpn-12-139.pek2.redhat.com [10.72.12.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84BED6064B;
 Wed,  9 Dec 2020 02:52:41 +0000 (UTC)
Date: Wed, 9 Dec 2020 10:52:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] rbd: remove the ->set_read_only method
Message-ID: <20201209025236.GE1217988@T590>
References: <20201208162829.2424563-1-hch@lst.de>
 <20201208162829.2424563-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208162829.2424563-6-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_215303_588445_553DBCDE 
X-CRM114-Status: GOOD (  20.46  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 08, 2020 at 05:28:28PM +0100, Christoph Hellwig wrote:
> Now that the hardware read-only state can't be changed by the BLKROSET
> ioctl, the code in this method is not required anymore.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Acked-by: Ilya Dryomov <idryomov@gmail.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  drivers/block/rbd.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 2ed79b09439a82..2c64ca15ca079f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -692,29 +692,10 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
>  	put_device(&rbd_dev->dev);
>  }
>  
> -static int rbd_set_read_only(struct block_device *bdev, bool ro)
> -{
> -	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
> -
> -	/*
> -	 * Both images mapped read-only and snapshots can't be marked
> -	 * read-write.
> -	 */
> -	if (!ro) {
> -		if (rbd_is_ro(rbd_dev))
> -			return -EROFS;
> -
> -		rbd_assert(!rbd_is_snap(rbd_dev));
> -	}
> -
> -	return 0;
> -}
> -
>  static const struct block_device_operations rbd_bd_ops = {
>  	.owner			= THIS_MODULE,
>  	.open			= rbd_open,
>  	.release		= rbd_release,
> -	.set_read_only		= rbd_set_read_only,
>  };
>  
>  /*
> -- 
> 2.29.2
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
