Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5F6C83030
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 05:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0kW8oUgo2at5mquwnfNXSKiB+ZB/4tMovHOoKiqJN0=; b=BB6M7VH7SF9/VHarkF+9ET1aMt
	j1NHk3J4NlmevaoH5CSKFuOshCIIZBq3fVlMr3OW8SGS8iPo0gQCxJNdj0uflqKtn0cOzHCYLGCYD
	3bkln3WUWQSSEjNA4VwhBwC7xHastE/rhFtfT80qFgW3N1XhXUgJ911nGHddOMYW0wYEGq2aV+Dff
	wOhtwf2Pfj9Pobrb7qafSYqyfVlXiEc6zGufZeZjdHVYYf9fpAm0ZIJgCOF5bDtIacEI0tazVdGfn
	m0HB4PtJF8jSjTbTgMANRgG2yAeIdGL981lDJK0oGGpblwDb+ua4zWV73CdiALG02CvgQlhiVTzl8
	UK5iCHgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYedW-00000001T2h-2Cwf;
	Mon, 07 Jul 2025 05:43:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYecb-00000001Srm-2qgB
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 05:42:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07766227A87; Mon,  7 Jul 2025 07:42:28 +0200 (CEST)
Date: Mon, 7 Jul 2025 07:42:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v7 08/10] blk-mq: use hk cpus only when
 isolcpus=io_queue is enabled
Message-ID: <20250707054227.GB28625@lst.de>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org> <20250702-isolcpus-io-queues-v7-8-557aa7eacce4@kernel.org> <20250703090158.GA4757@lst.de> <75aafd33-0aff-4cf7-872f-f110ed896213@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75aafd33-0aff-4cf7-872f-f110ed896213@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250706_224233_859160_5DE76259 
X-CRM114-Status: GOOD (  21.10  )
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

On Fri, Jul 04, 2025 at 11:00:56AM +0200, Daniel Wagner wrote:
> > I'm no expert on the housekeeping stuff, but why isn't the
> > housekeeping_enabled check done in housekeeping_cpumask directly so
> > that the drivers could use housekeeping_cpumask without a blk-mq
> > wrapper?
> 
> Yes, housekeeping_cpumask will return cpu_possible_mask when housekeping
> is disabled. Though some drivers want cpu_online_mask instead. If all
> drivers would agree on one version of the mask it should allow to drop
> to these helpers (maybe we the houskeeping API needs to be extended then
> though)

Drivers don't get cpu hotplug notifications, so cpu_possible_mask is
the only valid answer right now.  That could change if we ever implement
notifications to the drivers.

> This is also what Hannes brought up. If the number of supported hardware
> queues for a device is less than cpu_possible_mask, it really makes
> sense to distribute the hardware queues only between the online cpus. I
> think the only two drivers which are interested in the cpu_possible_mask
> are nvme-pci and virtio.

That's the only two drivers that get it right :(

