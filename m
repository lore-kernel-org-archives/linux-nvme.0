Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B0AC3DA4B
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jul 2024 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+aATKqGDV5IzQmJ+JLT5ocpCvUT9TSL3kxd/GUOGX8=; b=knhR6do6hS99zhRkF/nkdmBVw9
	O3Dob1gsYQgLkvY5+homBzQK2P/6ip3JCHJX3ZyyQKVk9I6Q9uDc+BdKk0QYtoHgRDlXxfx8XqEoP
	OQbUE4X+V+ZqxaNuUfAiygGh6WqohqJsjwf9aaFVZDQzk2+KswdGHT1kSmFDyWH4aACdyKnVwtSH5
	oclEyE4nvMGvffrsa1tcS7MRS5AN24Idig2bU4OETlyYzsBpjwowseySvfhacmavd4XMqOf4vU/O2
	1lmfyvskvFV6/JklHeXMyrLCVHlwrW1NqmBtOYRrJjSXbKhgnmMc7MKtNCsnsQBHUxZ89v/uij6bx
	GuaHqIPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTOUW-00000007jGO-42w5;
	Mon, 15 Jul 2024 16:23:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTOUT-00000007jFN-2Wgo
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jul 2024 16:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721060632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+aATKqGDV5IzQmJ+JLT5ocpCvUT9TSL3kxd/GUOGX8=;
	b=APnG3Rn9sp494pdaJMeGAs7iReP7wVC9zvUDkipXY71ziVG5Eg+wb4/TGwUipCcte8g08S
	MvMe6lhiU09JFfyA82mk3Dtu11tiCaAJrJDu64azsW5s3ld7g38IGOBV12UPXjzQo0868Y
	7Zqk+wU2kpDBKgFDuuxiE22XoKCMtSo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-y6wVeYXhPdqzRm2tII2ekw-1; Mon,
 15 Jul 2024 12:23:49 -0400
X-MC-Unique: y6wVeYXhPdqzRm2tII2ekw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAF4F19560A2;
	Mon, 15 Jul 2024 16:23:46 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 145251955D42;
	Mon, 15 Jul 2024 16:23:45 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 6AAB0400DF31E; Mon, 15 Jul 2024 13:03:02 -0300 (-03)
Date: Mon, 15 Jul 2024 13:03:02 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Lawrence Troup <ltroup@cisco.com>
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
Message-ID: <ZpVINh3BA88U6KEc@tpad>
References: <20240702104112.4123810-1-ming.lei@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20240702104112.4123810-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_092353_737389_5B496F17 
X-CRM114-Status: GOOD (  27.84  )
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

On Tue, Jul 02, 2024 at 06:41:12PM +0800, Ming Lei wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> People _really_ want to control their interrupt affinity in some
> cases, such as Openshift with Performance profile, in which each
> irq's affinity is completely specified from userspace. Turns out
> that 'isolcpus=managed_irqs' isn't enough.
> 
> Add module parameter to allow unmanaged interrupts, just as some
> SCSI drivers are doing.
> 
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> v2->v3:
> 	- rebase on for-next
> 	- add openshift use case
> 
> v1->v2: skip the the AFFINITY vector allocation if the parameter is
> provided instead trying to make the vector code handle all post_vectors.
> 
>  drivers/nvme/host/pci.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5d8035218de9..a39c99c9b64d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -63,6 +63,11 @@ MODULE_PARM_DESC(sgl_threshold,
>  		"Use SGLs when average request segment size is larger or equal to "
>  		"this size. Use 0 to disable SGLs.");
>  
> +static bool managed_irqs = true;
> +module_param(managed_irqs, bool, 0444);
> +MODULE_PARM_DESC(managed_irqs,
> +		 "set to false for user controlled irq affinity");
> +

What if you set "static bool managed_irqs" to false when isolcpus is being used?

For example:

if (housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
	managed_irqs = false;

Then there is no additional parameter to tune (which addresses
Christoph's concern).

>  #define NVME_PCI_MIN_QUEUE_SIZE 2
>  #define NVME_PCI_MAX_QUEUE_SIZE 4095
>  static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
> @@ -456,7 +461,7 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  		 * affinity), so use the regular blk-mq cpu mapping
>  		 */
>  		map->queue_offset = qoff;
> -		if (i != HCTX_TYPE_POLL && offset)
> +		if (managed_irqs && i != HCTX_TYPE_POLL && offset)
>  			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
>  		else
>  			blk_mq_map_queues(map);
> @@ -2226,6 +2231,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>  	};
>  	unsigned int irq_queues, poll_queues;
>  	unsigned int flags = PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY;
> +	int ret;
>  
>  	/*
>  	 * Poll queues don't need interrupts, but we need at least one I/O queue
> @@ -2251,8 +2257,16 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>  		irq_queues += (nr_io_queues - poll_queues);
>  	if (dev->ctrl.quirks & NVME_QUIRK_BROKEN_MSI)
>  		flags &= ~PCI_IRQ_MSI;
> -	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues, flags,
> +
> +	if (managed_irqs)
> +		return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues, flags,
>  					      &affd);
> +
> +	flags &= ~PCI_IRQ_AFFINITY;
> +	ret = pci_alloc_irq_vectors(pdev, 1, irq_queues, flags);
> +	if (ret > 0)
> +		nvme_calc_irq_sets(&affd, ret - 1);
> +	return ret;
>  }
>  
>  static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
> -- 
> 2.44.0
> 
> 


