Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12376D637D5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 01:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yR1GZUFS0LBQ/guHbrlldU7st7AuyATsxiMe8yNoBo0=; b=huLBN0pSMXzSmwNoAWlTlVXbOU
	s4rbeYS0y7v7vDVwUrHwzMuwTlhcbb3UXO0uqbpc+vf32Rn/+tNIqS7/PaCLWSHPVUrO+1/hKeBVF
	jprtfa5X8oDkE2HDqar4QUK3rV+UAlf3DveUcXIUeWNFGZNNiU0j3qV/jieALk0Ou80cr4K6X2i5W
	QvzVSreM5lHUV6s0rOSeaUUV1xkuXzPi8Ta9MG8u7jhO6bWIbTb+SkJ715J58j9IE/MySFi+FjMQo
	TKJ/9/e3HC4jT1X3jrC34XPtkVImwpsSlps0tos7S6Xm0bwcYjskxvwV6757l6Q9cWoDgqH0kp8f4
	GyctoFdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBOvp-00000008ScE-3vgB;
	Thu, 14 Nov 2024 01:46:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBOvk-00000008SZY-4ACu
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 01:45:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731548754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yR1GZUFS0LBQ/guHbrlldU7st7AuyATsxiMe8yNoBo0=;
	b=DXV+56hllusqiksz4sbuDudGoz/R3YmZ83Vc1Eo3cjI7pK+sToapTP8AT0aO9ULouNAWS4
	5+bfGSxRP0ENJ5wnKPIS07MKeEBkiWAhvnOn2BMRfzN1bNc53b+VPBZPDnjP46gLnIbIHQ
	1vfAUSoBykUdIrVX8W1wNUjPs58zfAg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237--a1l96hQNMq7uvZ2A6y2Xg-1; Wed,
 13 Nov 2024 20:45:50 -0500
X-MC-Unique: -a1l96hQNMq7uvZ2A6y2Xg-1
X-Mimecast-MFC-AGG-ID: -a1l96hQNMq7uvZ2A6y2Xg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C22431955F41;
	Thu, 14 Nov 2024 01:45:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C92A30000DF;
	Thu, 14 Nov 2024 01:45:31 +0000 (UTC)
Date: Thu, 14 Nov 2024 09:45:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v4 01/10] driver core: bus: add irq_get_affinity callback
 to bus_type
Message-ID: <ZzVWNy3oer4jFjFk@fedora>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
 <20241113-refactor-blk-affinity-helpers-v4-1-dd3baa1e267f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-1-dd3baa1e267f@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_174557_130574_E5DC1BF4 
X-CRM114-Status: GOOD (  20.89  )
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

On Wed, Nov 13, 2024 at 03:26:15PM +0100, Daniel Wagner wrote:
> Introducing a callback in struct bus_type so that a subsystem
> can hook up the getters directly. This approach avoids exposing
> random getters in any subsystems APIs.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  include/linux/device/bus.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index cdc4757217f9bb4b36b5c3b8a48bab45737e44c5..b18658bce2c3819fc1cbeb38fb98391d56ec3317 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -48,6 +48,7 @@ struct fwnode_handle;
>   *		will never get called until they do.
>   * @remove:	Called when a device removed from this bus.
>   * @shutdown:	Called at shut-down time to quiesce the device.
> + * @irq_get_affinity:	Get IRQ affinity mask for the device on this bus.
>   *
>   * @online:	Called to put the device back online (after offlining it).
>   * @offline:	Called to put the device offline for hot-removal. May fail.
> @@ -87,6 +88,8 @@ struct bus_type {
>  	void (*sync_state)(struct device *dev);
>  	void (*remove)(struct device *dev);
>  	void (*shutdown)(struct device *dev);
> +	const struct cpumask *(*irq_get_affinity)(struct device *dev,
> +			unsigned int irq_vec);
>  
>  	int (*online)(struct device *dev);
>  	int (*offline)(struct device *dev);
> 

Looks one nice abstraction,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


