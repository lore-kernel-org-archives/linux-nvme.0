Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D79D58E48
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 02:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IXF3HVABPTZBa89KUkOFW6l2cVIoXXvBTemknfS00g8=; b=4KrOm8O1HvjoFx82pFZqW9Y0Eo
	O2pBPofw0F4fw7MMpLz7hTIWTqp1/iUK1fZQaaxAQdjEDw4HOAhzhk4qWW5EXKMku2PhSbJ5ELWfz
	Oq6dBB+roI17V0qqslcY7zt/OC8kQ3NGJvOVuFQucTxBCQ9FHNMZj3+fITgV3jNT2ZA+sYT6gl46G
	kHD5iGrR6TyjOa8QOjpsgKgzdDkp5kYME1ZBDIkeJ5EPboVYZ5L5q4jvgjccWwvtie6BmLx5Osira
	HFc1YjEhJvmPLllS/jApsqywQlK/FYhum2n8BoZty/HGrWYqkfeWFTPrVkIo6sL+aGC666AeBINco
	jfIqoHiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwtMk-0000000C91k-0XCN;
	Mon, 02 Mar 2026 02:50:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwtMh-0000000C91G-0Bmn
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 02:50:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772419833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXF3HVABPTZBa89KUkOFW6l2cVIoXXvBTemknfS00g8=;
	b=WTRLkPWDf5U+8PY/Ov/4I3Br7xem2sQP5VSX96pw5Bw/09EAoI+ImDgH9xUbbsJI6B6Q1M
	bq2jZSLorYu3znAhmdZPBfRk19dqGFbftNhY21vNc32+dMqp2DvLZqys9vp1gFJEtwlHxg
	0i2AJWBffPwU5z1+pk/GsB/4bJJgHL0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-G5OB1YsaNp-Y-TuLuNQluQ-1; Sun,
 01 Mar 2026 21:50:27 -0500
X-MC-Unique: G5OB1YsaNp-Y-TuLuNQluQ-1
X-Mimecast-MFC-AGG-ID: G5OB1YsaNp-Y-TuLuNQluQ_1772419825
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B0C118002C4;
	Mon,  2 Mar 2026 02:50:25 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8929F1956053;
	Mon,  2 Mar 2026 02:50:24 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6222oNRc1830001
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 1 Mar 2026 21:50:23 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6222oNtt1830000;
	Sun, 1 Mar 2026 21:50:23 -0500
Date: Sun, 1 Mar 2026 21:50:23 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/24] scsi-multipath: introduce scsi_device head
 structure
Message-ID: <aaT676hImMTt5tYh@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-4-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260225153627.1032500-4-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 7xke_tZjj4k5bMy8uH3vnxbVv9CvRTM6rDRTWbrNhCg_1772419825
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_185035_162864_1CCF98E5 
X-CRM114-Status: GOOD (  29.33  )
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

On Wed, Feb 25, 2026 at 03:36:06PM +0000, John Garry wrote:
> Introduce a scsi_device head structure - scsi_mpath_head - to manage
> multipathing for a scsi_device. This is similar to nvme_ns_head structure.
> 
> There is no reference in scsi_mpath_head to any disk, as this would be
> mananged by the scsi_disk driver.
> 
> A list of scsi_mpath_head structures is managed to lookup for matching
> multipathed scsi_device's. Matching is done through the scsi_device
> unique id.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/scsi/scsi_multipath.c | 147 ++++++++++++++++++++++++++++++++++
>  drivers/scsi/scsi_sysfs.c     |   3 +
>  include/scsi/scsi_multipath.h |  29 +++++++
>  3 files changed, 179 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 04e0bad3d9204..49316269fad8e 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
>
> @@ -107,6 +178,7 @@ static void scsi_multipath_sdev_uninit(struct scsi_device *sdev)
>  
>  int scsi_mpath_dev_alloc(struct scsi_device *sdev)
>  {
> +	struct scsi_mpath_head *scsi_mpath_head;
>  	int ret;
>  
>  	if (!scsi_multipath)
> @@ -127,13 +199,75 @@ int scsi_mpath_dev_alloc(struct scsi_device *sdev)
>  		goto out_uninit;
>  	}
>  
> +	scsi_mpath_head = scsi_mpath_find_head(sdev->scsi_mpath_dev);
> +	if (scsi_mpath_head)
> +		goto found;
> +	/* scsi_mpath_disks_list lock held */

Typo. It should be "scsi_mpath_heads_list lock still held". Also, why
split the locking between this function and scsi_mpath_find_head()? It
seems like it would be clearer if you did in all here.

> +	scsi_mpath_head = scsi_mpath_alloc_head();
> +	if (!scsi_mpath_head)
> +		goto out_uninit;

It seems resonable to failback to treating the device as non-multipathed
if you can't setup the multipathing resources. But you should probably
warn if that happens.

> +
> +	strcpy(scsi_mpath_head->wwid, sdev->scsi_mpath_dev->device_id_str);
> +
> +	ret = device_add(&scsi_mpath_head->dev);
> +	if (ret)
> +		goto out_put_head;
> +
> +	list_add_tail(&scsi_mpath_head->entry, &scsi_mpath_heads_list);
> +
> +	mutex_unlock(&scsi_mpath_heads_lock);
> +	sdev->scsi_mpath_dev->scsi_mpath_head = scsi_mpath_head;

You already set sdev->scsi_mpath_dev->scsi_mpath_head right before you
return.

> +
> +found:
> +	sdev->scsi_mpath_dev->index = ida_alloc(&scsi_mpath_head->ida, GFP_KERNEL);
> +	if (sdev->scsi_mpath_dev->index < 0) {
> +		ret = sdev->scsi_mpath_dev->index;
> +		goto out_put_head;

&scsi_mpath_heads_lock is already unlocked here, but it will get
unlocked again in out_uninit

> +	}
> +
> +	mutex_lock(&scsi_mpath_head->lock);
> +	scsi_mpath_head->dev_count++;
> +	mutex_unlock(&scsi_mpath_head->lock);
> +
> +	sdev->scsi_mpath_dev->scsi_mpath_head = scsi_mpath_head;
>  	return 0;
>  
> +out_put_head:
> +	scsi_mpath_put_head(scsi_mpath_head);
>  out_uninit:
> +	mutex_unlock(&scsi_mpath_heads_lock);
>  	scsi_multipath_sdev_uninit(sdev);
>  	return ret;
>  }
>  
> +static void scsi_mpath_remove_head(struct scsi_mpath_device *scsi_mpath_dev)
> +{
> +	struct scsi_mpath_head *scsi_mpath_head =
> +			scsi_mpath_dev->scsi_mpath_head;
> +	bool last_path = false;
> +
> +	mutex_lock(&scsi_mpath_head->lock);
> +	scsi_mpath_head->dev_count--;
> +	if (scsi_mpath_head->dev_count == 0)
> +		last_path = true;
> +	mutex_unlock(&scsi_mpath_head->lock);

The locking of scsi_mpath_head->lock makes it appear that
scsi_mpath_remove_head() and scsi_mpath_dev_alloc() can both happen at
the same time. I didn't check enough to verify if that's actually the
case, but if it's not, then the lock is unnecessary. If they can run at
the same time, then I don't see anything keeping scsi_mpath_dev_alloc()
from calling scsi_mpath_find_head() and finding a scsi_mpath_head that
is just about to have its device deleted by
device_del(&scsi_mpath_head->dev). If this happens, the device won't
get re-added.

-Ben

> +
> +	if (last_path)
> +		device_del(&scsi_mpath_head->dev);
> +
> +	scsi_mpath_dev->scsi_mpath_head = NULL;
> +	scsi_mpath_put_head(scsi_mpath_head);
> +}


