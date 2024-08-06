Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA48C49EA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ihXTnZUUObwiIcTBPsEqn71PFQRrfkK+JC0Kw8IKXs=; b=bscirEX3JyG1Crvx+VuY9NsdeY
	MVnhYVv7l7I3l4Xpevga5NqwUd5oNl4dl41qSVuFN4NLuqWHiCpDDhK19IZ/JaIX6iQNNKV+Ryia/
	GHGGh0I2Ao7//jCNkhTatzJWr8LuBNuQNFon8ZeoYwjWDzhbrk1FOucQKbuPvjWpApbtI/fpMojBo
	FtiLFvHxU9iykmp6HVO/JSDmKMLdFUh5VZksYfKaRTtHsx9RLfab1danXsItUYXMD4fmv61qFkuU4
	3TTz/x6PhS/NR+cwLqJx3XWF2pVCPQvBeFsBBQk5B5nwgD6KQ4wyBf0O96AROXuBYTI20rP48H5eI
	QB9npTyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLYH-000000023lb-0VuA;
	Tue, 06 Aug 2024 14:52:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbKDA-00000001lAo-0jBy
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 13:26:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83FD868D09; Tue,  6 Aug 2024 15:26:45 +0200 (CEST)
Date: Tue, 6 Aug 2024 15:26:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
	storagedev@microchip.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 03/15] blk-mq: introduce blk_mq_dev_map_queues
Message-ID: <20240806132645.GC13883@lst.de>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de> <20240806-isolcpus-io-queues-v3-3-da0eecfeaf8b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-isolcpus-io-queues-v3-3-da0eecfeaf8b@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_062648_519466_14165B87 
X-CRM114-Status: GOOD (  30.22  )
X-Mailman-Approved-At: Tue, 06 Aug 2024 07:51:53 -0700
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

On Tue, Aug 06, 2024 at 02:06:35PM +0200, Daniel Wagner wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
> hardware queue mapping based on affinity information. These two
> function share code which only differs on how the affinity information
> is retrieved. Also there is the hisi_sas which open codes the same loop.
> 
> Thus introduce a new helper function for creating these mappings which
> takes an callback function for fetching the affinity mask. Also
> introduce common helper function for PCI and virtio devices to retrieve
> affinity masks.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [dwagner: - removed fallback mapping
>           - added affintity helpers
> 	  - updated commit message]
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  block/blk-mq-cpumap.c         | 35 +++++++++++++++++++++++++++++++++++
>  block/blk-mq-pci.c            | 18 ++++++++++++++++++
>  block/blk-mq-virtio.c         | 19 +++++++++++++++++++
>  include/linux/blk-mq-pci.h    |  2 ++
>  include/linux/blk-mq-virtio.h |  3 +++
>  include/linux/blk-mq.h        |  5 +++++
>  6 files changed, 82 insertions(+)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9638b25fd521..7037a2dc485f 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -54,3 +54,38 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
>  
>  	return NUMA_NO_NODE;
>  }
> +
> +/**
> + * blk_mq_dev_map_queues - Create CPU to hardware queue mapping
> + * @qmap:	CPU to hardware queue map.
> + * @dev_off:	Offset to use for the device.
> + * @dev_data:	Device data passed to get_queue_affinity().
> + * @get_queue_affinity:	Callback to retrieve queue affinity.
> + *
> + * Create a CPU to hardware queue mapping in @qmap. For each queue
> + * @get_queue_affinity will be called to retrieve the affinity for given
> + * queue.
> + */
> +void blk_mq_dev_map_queues(struct blk_mq_queue_map *qmap,
> +			   void *dev_data, int dev_off,
> +			   get_queue_affinty_fn *get_queue_affinity)
> +{
> +	const struct cpumask *mask;
> +	unsigned int queue, cpu;
> +
> +	for (queue = 0; queue < qmap->nr_queues; queue++) {
> +		mask = get_queue_affinity(dev_data, dev_off, queue);
> +		if (!mask)
> +			goto fallback;
> +
> +		for_each_cpu(cpu, mask)
> +			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> +	}
> +
> +	return;
> +
> +fallback:
> +	WARN_ON_ONCE(qmap->nr_queues > 1);
> +	blk_mq_clear_mq_map(qmap);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_dev_map_queues);
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
> index d47b5c73c9eb..71a73238aeb2 100644
> --- a/block/blk-mq-pci.c
> +++ b/block/blk-mq-pci.c
> @@ -44,3 +44,21 @@ void blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
>  	blk_mq_clear_mq_map(qmap);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_pci_map_queues);
> +
> +/**
> + * blk_mq_pci_get_queue_affinity - get affinity mask queue mapping for PCI device
> + * @dev_data:	Pointer to struct pci_dev.
> + * @offset:	Offset to use for the pci irq vector
> + * @queue:	Queue index
> + *
> + * This function returns for a queue the affinity mask for a PCI device.
> + * It is usually used as callback for blk_mq_dev_map_queues().
> + */
> +const struct cpumask *blk_mq_pci_get_queue_affinity(void *dev_data, int offset,
> +						    int queue)
> +{
> +	struct pci_dev *pdev = dev_data;
> +
> +	return pci_irq_get_affinity(pdev, offset + queue);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_pci_get_queue_affinity);
> diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
> index 68d0945c0b08..d3d33f8d69ce 100644
> --- a/block/blk-mq-virtio.c
> +++ b/block/blk-mq-virtio.c
> @@ -44,3 +44,22 @@ void blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
>  	blk_mq_map_queues(qmap);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_virtio_map_queues);
> +
> +/**
> + * blk_mq_virtio_get_queue_affinity - get affinity mask queue mapping for virtio device

Please avoid the overly long line here.

> +const struct cpumask *blk_mq_virtio_get_queue_affinity(void *dev_data,
> +						       int offset,
> +						       int queue)
> +{

And maybe use sane formatting here:

const struct cpumask *blk_mq_virtio_get_queue_affinity(void *dev_data,
		int offset, int queue)

/me also wonders why the parameters aren't unsigned, but that's history..


