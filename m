Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A222C3ABD1
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2024 06:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=53GBqJUN42SLaloC1+9g1zj0dZctta2Y0HZg+VyYduE=; b=465gF5mznZccV8psyD7vAwx/TU
	N2Y+D0Dggf/dtWsytmI6xM8MaoLJ7+9EcbI9/eUbuRcWytHWktGhjNCFntSGu5HJU/uI+GjplrJ3w
	1FzsYuu3HQs/D8CnqNFC0h7TgWIf/rX0gnxYphiF1+vw84+Kx5og7nJiXt+HVqpzT6FI4AfR4vC3f
	ZyNTsv/YJ12neFKwLUnJHLoHY0iHxOyuqOJYtbVsUXYlZ+cYiQTZYj6Xfxh5vle0wh+Cs2/E9wQtU
	2PZnXzFqPjvJvCBhsSnLxfOYr+R0J8qIrORvDM2+3PJ7t+KxDzdC3YxT0eadqD6HPC6nsmuBWh3xt
	PG+ZQe8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sq5ZA-00000003ENT-2zXh;
	Mon, 16 Sep 2024 06:50:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sq5XW-00000003Dvq-2uw4
	for linux-nvme@lists.infradead.org;
	Mon, 16 Sep 2024 06:48:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92036227AAA; Mon, 16 Sep 2024 08:48:46 +0200 (CEST)
Date: Mon, 16 Sep 2024 08:48:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
	Ming Lei <ming.lei@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <20240916064846.GA15950@lst.de>
References: <20240913-refactor-blk-affinity-helpers-v1-1-8e058f77af12@suse.de> <20240913162654.GA713813@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913162654.GA713813@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240915_234850_911813_59E053A5 
X-CRM114-Status: GOOD (  18.34  )
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

On Fri, Sep 13, 2024 at 11:26:54AM -0500, Bjorn Helgaas wrote:
> > +const struct cpumask *pci_get_blk_mq_affinity(void *dev_data, int offset,
> > +					      int queue)
> > +{
> > +	struct pci_dev *pdev = dev_data;
> > +
> > +	return pci_irq_get_affinity(pdev, offset + queue);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_get_blk_mq_affinity);
> > +#endif
> 
> IMO this doesn't really fit well in drivers/pci since it doesn't add
> any PCI-specific knowledge or require any PCI core internals, and the
> parameters are blk-specific.  I don't object to the code, but it seems
> like it could go somewhere in block/?

That's where it, or rather the current equivalent, lives, which is a bit
silly.  That being said, I suspect the nicest thing would be to offer a
real irq_get_affinity interface at the bus level.

e.g. add something like:


	const struct cpumask *(*irq_get_affinity(struct device *dev,
			unsigned int irq_vec);

to struct bus_type so that any layer can just query the irq affinity
for buses that support it without extra glue code.

