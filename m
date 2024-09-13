Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA182FC6160
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 16:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=lYIRTwHdFNOEQePA3uE8ddfoWd7wQo2nchELczNtojo=; b=Qmnejci2aDbxlo
	gsr23nRRtco0UPYA7juW8ZpbdI7ZnJMeOl0OPDUU1YYytJ4+CL2craJh3k/f+XCJpbW2S8ALvzsWn
	gZPT+jFFRL5W1BV7LFFcUZgJwkCojWx/TapTGxCOk7oqtZmMEHuY31x8KjpdZ++12SsesT/pdDUtd
	X72ymlEm5/Hs3Uswz9EJDUeDqw7o1NkqKpjKJa62Qt7U9NvjVNiyIHCG+Nu1m7VylGSEnuSoJG+u5
	OxCSox62HfN63uwi4mg7/D1AmFs529DKNqRUDDiksxI1azksbiemBzkbVlXygF5+Fo8SsOx0Fp+av
	0djzHxjzg5RVM4ugdcCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sp98O-0000000GXmV-0zlD;
	Fri, 13 Sep 2024 16:27:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sp98M-0000000GXlG-0J9j
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 16:26:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9F9D95C59B9;
	Fri, 13 Sep 2024 16:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB45C4CEC0;
	Fri, 13 Sep 2024 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726244816;
	bh=N/dGWdelfzW1jn7M+zLDe+HuQdFpqVd7x9gArCb5Jvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=p16OlQEpr5SAw2jRw6O1xDg5YWbgxPDunmMZ0Sn3z1WK70qMRUtRnSYItwlFquMz3
	 yy4fHiskNpy9vZ9R1OjKG5XM0WxfZrYDWZKb0/As8aq94zr9scbWbt4bcAzJIjgR88
	 Rpbj1q+5++m00rAm0WVpOv4NyToZ4Zs9gpW7nXXy1aFahtHGMLJMOb9K4DhJodJ44o
	 Ymz5cLXQGYn455KbAHQXACFdINjTucrcbGxpjP5qo4i31T6pcHJLE7KUsZhVJvVybl
	 9F9bT9d/Q9e61kw/fi3+lyZzn7S7xg7lmIfws5NMXaF0gXVof2qb/XTgtciVCdizFe
	 7v8BBeLtvAgVA==
Date: Fri, 13 Sep 2024 11:26:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
	linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
	20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <20240913162654.GA713813@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-refactor-blk-affinity-helpers-v1-1-8e058f77af12@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_092658_205713_10EE1DF0 
X-CRM114-Status: GOOD (  21.71  )
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

On Fri, Sep 13, 2024 at 09:41:59AM +0200, Daniel Wagner wrote:
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

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e3a49f66982d..84f9c16b813b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6370,6 +6370,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_BLK_MQ_PCI
> +/**
> + * pci_get_blk_mq_affinity - get affinity mask queue mapping for PCI device
> + * @dev_data:	Pointer to struct pci_dev.
> + * @offset:	Offset to use for the pci irq vector
> + * @queue:	Queue index
> + *
> + * This function returns for a queue the affinity mask for a PCI device.
> + * It is usually used as callback for blk_mq_hctx_map_queues().
> + */
> +const struct cpumask *pci_get_blk_mq_affinity(void *dev_data, int offset,
> +					      int queue)
> +{
> +	struct pci_dev *pdev = dev_data;
> +
> +	return pci_irq_get_affinity(pdev, offset + queue);
> +}
> +EXPORT_SYMBOL_GPL(pci_get_blk_mq_affinity);
> +#endif

IMO this doesn't really fit well in drivers/pci since it doesn't add
any PCI-specific knowledge or require any PCI core internals, and the
parameters are blk-specific.  I don't object to the code, but it seems
like it could go somewhere in block/?

Bjorn

