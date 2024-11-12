Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002A6D42B8E
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 15:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wy4zAOKDbBW4NMEbuxSABbtSAqmMQvJQ+ZUerOuIRsE=; b=npOGgFw2zOf+Ct+pQboJYLBC9Q
	W0WACJkrkRUBnCcFX46Vjp5r34bDcbfMpCT6shAuCIO6H8pAkZ0ObuoUes3tsYTlHcHnpvz1bmeZ3
	7AIvqqvXpb3fd/I+rqFcYF0IUj43YkZC6d54K2MjUuvb+LPr3oN24TGniYdc7iWicT/JA0ySVEWcg
	ADLVxACg4Z1cq1smwH8bjwwMwGDVycjd/VR/ZmH2IALPlLRQSyK2EsPk+HP3g/mMyamCdh0imRKUH
	ulqQR5ZV/j9rsgQmfr7FUOINlNvf0qCnVSJp+XIia+CbJ4FNXTIEkUsKfojx0MDXn4QVPK931aoPT
	koktjYfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAsOJ-00000003rlz-0FOS;
	Tue, 12 Nov 2024 15:01:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tArPw-00000003flo-2TsY
	for linux-nvme@bombadil.infradead.org;
	Tue, 12 Nov 2024 13:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wy4zAOKDbBW4NMEbuxSABbtSAqmMQvJQ+ZUerOuIRsE=; b=hYtksTBMVHKZzAXyAiQe3yibGZ
	kOWKR7L8ZBOaEIeMm9L9mgbDqt70RaDI78kaZy8S8E7Ei16pqYFRqv9iydhesN9WJ+e+VNylFrOLS
	Riu67vl7Oi4vWuFU/U0s+8D90ERCCZ+yr9ULVAgHcXYljBBgAMrUeNxg6kbAprUESHItaMYxDuJ9T
	jIPCV9G9jMvHZ8aQbFpEkNzWDaELzPoUTe0TbjxbUfwNuKvop+QEqWVu7p4j9T/7E6gGJuTIijEnU
	3pFLPJ4fuj/v/GL7rOtYlqvFzq6QEkJtb+/1uISMz49vuKRGe8JHPCmqDLqxah4ENE0kD8ypCjZFq
	ToDm/H3g==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tArPt-0000000D55F-0zLl
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 13:58:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A82765C06AA;
	Tue, 12 Nov 2024 13:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341EAC4CECD;
	Tue, 12 Nov 2024 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731419926;
	bh=4pQscTrEU5vmK5o46Z8CwGup1txTZg9HfKzeFdSrbS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEVL3aiL8wTkbdWnNSbzgcdNk3RQPWC313AxWLqPSQ8lsIHiJyIIQ+a1+0brKoEv7
	 KUUta4ZAheLRxq/dXvj3W5IPp6XNi2jYXbYffK6aebTP7RStJ8pz1CsuOdvXtnlcum
	 RimsoDVR8th5qGmtSlee4+rtTASaMD19tU6j829U=
Date: Tue, 12 Nov 2024 14:58:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 4/8] blk-mp: introduce blk_mq_hctx_map_queues
Message-ID: <2024111202-parish-prowess-78bc@gregkh>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_135849_588859_0056516E 
X-CRM114-Status: GOOD (  24.71  )
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

On Tue, Nov 12, 2024 at 02:26:19PM +0100, Daniel Wagner wrote:
> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
> hardware queue mapping based on affinity information. These two function
> share common code and only differ on how the affinity information is
> retrieved. Also, those functions are located in the block subsystem
> where it doesn't really fit in. They are virtio and pci subsystem
> specific.
> 
> Thus introduce provide a generic mapping function which uses the
> irq_get_affinity callback from bus_type.
> 
> Originally idea from Ming Lei <ming.lei@redhat.com>
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  block/blk-mq-cpumap.c  | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  2 ++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..db22a7d523a2762b76398fdd768f55efd1d6d669 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -11,6 +11,7 @@
>  #include <linux/smp.h>
>  #include <linux/cpu.h>
>  #include <linux/group_cpus.h>
> +#include <linux/device/bus.h>
>  
>  #include "blk.h"
>  #include "blk-mq.h"
> @@ -54,3 +55,39 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
>  
>  	return NUMA_NO_NODE;
>  }
> +
> +/**
> + * blk_mq_hctx_map_queues - Create CPU to hardware queue mapping
> + * @qmap:	CPU to hardware queue map.
> + * @dev:	The device to map queues.
> + * @offset:	Queue offset to use for the device.
> + *
> + * Create a CPU to hardware queue mapping in @qmap. The struct bus_type
> + * irq_get_affinity callback will be used to retrieve the affinity.
> + */
> +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> +			    struct device *dev, unsigned int offset)
> +
> +{
> +	const struct cpumask *mask;
> +	unsigned int queue, cpu;
> +
> +	if (!dev->bus->irq_get_affinity)
> +		goto fallback;

I think this is better than hard-coding it, but are you sure that the
bus will always be bound to the device here so that you have a valid
bus-> pointer?

thanks,

greg k-h

