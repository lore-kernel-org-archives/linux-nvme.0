Return-Path: <SRS0=C+HF=L2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81092C11F68
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 15:56:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D45613F7
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 15:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D45613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RwgRj9tjVCPeO8dxo7sYXBxZ7mDBH710c+cDCc3brsw=; b=ExWnCAsbTfxH/Q
	kgGq1QFoLpVcFpgHUEVPpIWquPJuRwTKp8JMogAKSdQhQVm9MRLZKaP8yKs1EwLIACfeb8Er1sj5N
	jLw9wEe7ZVlYYCr87aQuRazmpN5MRCF975PHEk4/IhO1YqgysRSrovq531N3zQUEgAXt5gw4zw2qh
	EVInTeR5o+jBBCaJHpT/HUnfe2RKbmtkPtzutsQqRudoQheAc1dnwOHaUNPKRTiUQ/EkrvvqzxYI/
	hMoaq6fQM1ML/CM7xz8vqDTZFMm/OodCkjW42bBHfeyKDob9q9zr/JwM0tO1ep0y95L6q3NH1aB+z
	3VyOgXuLfaqJKM2zAy+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lzLWF-003THV-NZ; Fri, 02 Jul 2021 15:55:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzLWC-003TGP-GB
 for linux-nvme@lists.infradead.org; Fri, 02 Jul 2021 15:55:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625241350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=508AyhKpE8jUDrBFR0nb6Agup3ldPNqzk6KlIwcdo6g=;
 b=e81EbUvOC8uYnJq5JoJalPrmgLYULa0Qia/Uu+D1GEWaq+8IpxS94jiknI3cETft/ggnnn
 mFbLIqczCguCvfGmeYRvjMUM/5xHCGwf10YpqUcFSPF/CFt2oe0cQj8B5T6R12cUFsPBb7
 EQpDkHMorjds7EC0D7kKVG6dGDYCoQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-yJ6sObgxMYqtYp8lgMx78g-1; Fri, 02 Jul 2021 11:55:47 -0400
X-MC-Unique: yJ6sObgxMYqtYp8lgMx78g-1
Received: by mail-wm1-f72.google.com with SMTP id
 n37-20020a05600c3ba5b02901fe49ba3bd0so1078605wms.1
 for <linux-nvme@lists.infradead.org>; Fri, 02 Jul 2021 08:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=508AyhKpE8jUDrBFR0nb6Agup3ldPNqzk6KlIwcdo6g=;
 b=uTU0/qYLccMp5hEGRMlmIesfFa6XNvndGviX0B8l2LSk5awtECHxQU+XdwlltD1YFg
 KlZb0fDqiQGOzNDGtGJGcblRHalVYRT/+v3nileycRahE0F5No7DkGsZEklMoRKzWmbZ
 5NKsKdBs7m2IpP3MGrJr5LuMTwn0rkNnIfltI8Js7GYlPiRkXl3s5//7X8Rdgv4szy/5
 h/jJL1IzvBre5pmzCi+E0z8p6Ml5EblQkCkG8GIc0gZ0GRP+KiyuJJOZm45uZ6g1Uzmf
 LokpiKPZ368n+VttqA1Z206GLWdRLtprfBlfTc2pEPLOvMKQMm8prgfzDi72MgoVDgHC
 dfLA==
X-Gm-Message-State: AOAM532FzhqHBIns/84+AuEOZ4v81oTmlMA9rKPS7e1Xs/hbakKdSsDp
 /NmivFnQVMX1Ig6N5oyeM2Il5Zc2/1yQ7OEq4ndYHsG9G4asOTk06yxQiL86y36SlU5B/KH36cS
 0TvrqPAtTTh6BM+eCXBo6D3dVI9c=
X-Received: by 2002:a1c:1dd1:: with SMTP id d200mr205135wmd.82.1625241346471; 
 Fri, 02 Jul 2021 08:55:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5g/VM21EKC5p1b+bedRgUGipGzZg9oN5IehHhOj+/WVKmexFW92+hQHKujHlDSVZapekDzw==
X-Received: by 2002:a1c:1dd1:: with SMTP id d200mr205117wmd.82.1625241346342; 
 Fri, 02 Jul 2021 08:55:46 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id n12sm4180006wmq.5.2021.07.02.08.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jul 2021 08:55:45 -0700 (PDT)
Date: Fri, 2 Jul 2021 11:55:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>,
 Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
Message-ID: <20210702115430-mutt-send-email-mst@kernel.org>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210702150555.2401722-6-ming.lei@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210702_085552_660896_C3032D6D 
X-CRM114-Status: GOOD (  25.01  )
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

On Fri, Jul 02, 2021 at 11:05:54PM +0800, Ming Lei wrote:
> blk-mq needs to know if the device uses managed irq, so add one field
> to virtio_device for recording if device uses managed irq.
> 
> If the driver use managed irq, this flag has to be set so it can be
> passed to blk-mq.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>


The API seems somewhat confusing. virtio does not request
a managed irq as such, does it? I think it's a decision taken
by the irq core.

Any way to query the irq to find out if it's managed?


> ---
>  drivers/block/virtio_blk.c         | 2 ++
>  drivers/scsi/virtio_scsi.c         | 1 +
>  drivers/virtio/virtio_pci_common.c | 1 +
>  include/linux/virtio.h             | 1 +
>  4 files changed, 5 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index e4bd3b1fc3c2..33b9c80ac475 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -764,6 +764,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	vblk->tag_set.queue_depth = queue_depth;
>  	vblk->tag_set.numa_node = NUMA_NO_NODE;
>  	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> +	if (vdev->use_managed_irq)
> +		vblk->tag_set.flags |= BLK_MQ_F_MANAGED_IRQ;
>  	vblk->tag_set.cmd_size =
>  		sizeof(struct virtblk_req) +
>  		sizeof(struct scatterlist) * sg_elems;
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index b9c86a7e3b97..f301917abc84 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -891,6 +891,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
>  	shost->max_channel = 0;
>  	shost->max_cmd_len = VIRTIO_SCSI_CDB_SIZE;
>  	shost->nr_hw_queues = num_queues;
> +	shost->use_managed_irq = vdev->use_managed_irq;
>  
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>  	if (virtio_has_feature(vdev, VIRTIO_SCSI_F_T10_PI)) {
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 222d630c41fc..f2ac48fb477b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -128,6 +128,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  	if (desc) {
>  		flags |= PCI_IRQ_AFFINITY;
>  		desc->pre_vectors++; /* virtio config vector */
> +		vdev->use_managed_irq = true;
>  	}
>  
>  	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b1894e0323fa..85cc773b2dc7 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -109,6 +109,7 @@ struct virtio_device {
>  	bool failed;
>  	bool config_enabled;
>  	bool config_change_pending;
> +	bool use_managed_irq;
>  	spinlock_t config_lock;
>  	struct device dev;
>  	struct virtio_device_id id;
> -- 
> 2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
