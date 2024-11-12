Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEFED41D4E
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 04:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sFHjXOaXNAUnkOrz7uah0eiCZAGFtgDGTatT6KQolrU=; b=eEjmrFhMNA6lAMLjO5ggXe6tpS
	C8ikGJKJMTUYGhUlsnug7Q4Dx2BASE1B+uy93nc8ickfHlbhlZyoB5blnGWlizVL2VpfVvZrFc738
	twHsDJ3p6LSapb2ANjdIDU9/cXp8yJ2qsUA9gvGt6uNIivPRh574DpOTyDsQrtiUdGczSI4ghiaSo
	oRzbphVfQyVeYQMoeSQ43ytwCDz+wnynoViWUH0Y/VqGV+aBzGzpxDFqVsMJPTtZniA2As5bI2lfH
	gKuCnkSLAnO1VhEjX9OUUBnR90nKPnOhxF+125qUcrW78TAQAUR7TMxquwQJYK6jQAe5r0ebuR7Ae
	RvBE4khQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAiof-00000002BM9-1QyC;
	Tue, 12 Nov 2024 04:47:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAiob-00000002BLk-3UwL
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 04:47:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95CAB68D09; Tue, 12 Nov 2024 05:47:36 +0100 (CET)
Date: Tue, 12 Nov 2024 05:47:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <20241112044736.GA8883@lst.de>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org> <20241111-refactor-blk-affinity-helpers-v2-1-f360ddad231a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-refactor-blk-affinity-helpers-v2-1-f360ddad231a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_204746_137936_4AA22D4D 
X-CRM114-Status: GOOD (  26.04  )
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

On Mon, Nov 11, 2024 at 07:02:09PM +0100, Daniel Wagner wrote:
> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
> hardware queue mapping based on affinity information. These two function
> share common code and only differ on how the affinity information is
> retrieved. Also, those functions are located in the block subsystem
> where it doesn't really fit in. They are virtio and pci subsystem
> specific.
> 
> Introduce a new callback in struct bus_type to get the affinity mask.
> The callbacks can then be populated by the subsystem directly.
> 
> All but one driver use the subsystem default affinity masks. hisi_sas v2
> depends on a driver specific mapping, thus use the optional argument
> get_queue_affinity to retrieve the mapping.

This seems to mix up a few different things:

 1) adding a new bus operation
 2) implementations of that operation for PCI and virtio
 3) a block layer consumer of the operation

all these really should be separate per-subsystem patches.

You'll also need to Cc the driver model maintainers.

> +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> +			    struct device *dev, unsigned int offset,
> +			    get_queue_affinity_fn *get_irq_affinity)
> +{
> +	const struct cpumask *mask = NULL;
> +	unsigned int queue, cpu;
> +
> +	for (queue = 0; queue < qmap->nr_queues; queue++) {
> +		if (get_irq_affinity)
> +			mask = get_irq_affinity(dev, queue + offset);
> +		else if (dev->bus->irq_get_affinity)
> +			mask = dev->bus->irq_get_affinity(dev, queue + offset);
> +
> +		if (!mask)
> +			goto fallback;
> +
> +		for_each_cpu(cpu, mask)
> +			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> +	}

This does different things with a NULL argument vs not.  Please split it
into two separate helpers.  The non-NULL case is only uses in hisi_sas,
so it might be worth just open coding it there as well.

> +static const struct cpumask *pci_device_irq_get_affinity(struct device *dev,
> +					unsigned int irq_vec)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return pci_irq_get_affinity(pdev, irq_vec);

Nit: this could be shortened to:

	return pci_irq_get_affinity(to_pci_dev(dev), irq_vec);


