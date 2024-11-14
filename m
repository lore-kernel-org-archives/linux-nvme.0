Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570A5D65C61
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uoMm+2i8TmKTGQpX50eO3uTG52uiWMzmm9/S5ypTMAw=; b=CfV52LxQNYbshA1cbzd3jy9PjD
	H6/plpVChctwB7N8q/6WUCu4ERaJjBZkWv4w42FBA6KPwglLHA4s+CU3ewJcka0r7dCHzTWlzQIth
	ruI67fDMTOfc3lErONVGtDXAkl27m+po6OX61LzEhT3IO9Mv1SC1VAO/ZFRBxNhtSM5PZgJ+rWY9C
	TsGehqiESXPje3J8oLREp5EOFi/yn3koJHQKa6odGWHVfMdtzqBFvkSe2RYLqntRv8PWgTxkWHqAk
	li3H+S4D3Qwtx2KJf5+pThqiGfNeUVyNxQQ4w/W+Du/1LSqiX9Vbn40DiJdXDRbks9l4m33j8tUED
	6JobodVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBVve-00000009KEW-1IVG;
	Thu, 14 Nov 2024 09:14:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBVuE-00000009JwN-1xoc
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 09:12:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731575569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uoMm+2i8TmKTGQpX50eO3uTG52uiWMzmm9/S5ypTMAw=;
	b=OQzH16+3taTfBWTRo33aCI/Xkte1z8Uq5PkOAoc2j0vRGXZn/H5FZD5LglteCdzocXcAVi
	V7rWUWgUWBly4LeCJcqbxRM75URawMW9WB5UD83KjyzSUkj5LMoCHjKJ9DyVhc52lkKISu
	3DHDVYMhOChNzIj+KupCZdarKKM3upA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-hb4nU_FsNbGn6R7vUyU_-Q-1; Thu,
 14 Nov 2024 04:12:46 -0500
X-MC-Unique: hb4nU_FsNbGn6R7vUyU_-Q-1
X-Mimecast-MFC-AGG-ID: hb4nU_FsNbGn6R7vUyU_-Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EA53195609E;
	Thu, 14 Nov 2024 09:12:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09DDA19560A3;
	Thu, 14 Nov 2024 09:12:27 +0000 (UTC)
Date: Thu, 14 Nov 2024 17:12:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 05/10] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <ZzW-9rWvKBxFZU1E@fedora>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
 <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org>
 <ZzVZQbZOYhNF08LX@fedora>
 <9fa26099-1922-4b99-883e-bd5f6c58162a@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa26099-1922-4b99-883e-bd5f6c58162a@flourine.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_011250_612234_7AF7B8BF 
X-CRM114-Status: GOOD (  26.20  )
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

On Thu, Nov 14, 2024 at 08:54:46AM +0100, Daniel Wagner wrote:
> On Thu, Nov 14, 2024 at 09:58:25AM +0800, Ming Lei wrote:
> > > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > 
> > Some drivers may not know hctx at all, maybe blk_mq_map_hw_queues()?
> 
> I am not really attach to the name, I am fine with renaming it to
> blk_mq_map_hw_queues.
> 
> > > +	if (dev->driver->irq_get_affinity)
> > > +		irq_get_affinity = dev->driver->irq_get_affinity;
> > > +	else if (dev->bus->irq_get_affinity)
> > > +		irq_get_affinity = dev->bus->irq_get_affinity;
> > 
> > It is one generic API, I think both 'dev->driver' and
> > 'dev->bus' should be validated here.
> 
> What do you have in mind here if we get two masks? What should the
> operation be: AND, OR?

IMO you just need one callback to return the mask.

I feel driver should get higher priority, but in the probe() example,
call_driver_probe() actually tries bus->probe() first.

But looks not an issue for this patchset since only hisi_sas_v2_driver(platform_driver)
defines ->irq_get_affinity(), but the platform_bus_type doesn't have the callback.

> 
> This brings up another topic I left out in this series.
> blk_mq_map_queues does almost the same thing except it starts with the
> mask returned by group_cpus_evenely. If we figure out how this could be
> combined in a sane way it's possible to cleanup even a bit more. A bunch
> of drivers do
> 
> 		if (i != HCTX_TYPE_POLL && offset)
> 			blk_mq_hctx_map_queues(map, dev->dev, offset);
> 		else
> 			blk_mq_map_queues(map);
> 
> IMO it would be nice just to have one blk_mq_map_queues() which handles
> this correctly for both cases.

I guess it is doable, and the driver just setup the tag_set->map[], then call
one generic map_queues API to do everything?


Thanks,
Ming


