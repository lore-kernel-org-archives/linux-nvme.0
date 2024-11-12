Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CE0D42BAF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r8kgShdticKitOxnJKDsIiDYpLGVKqGyZhs35wXCmwA=; b=ULj2BkkFtZnvI3AEyZWCaxyH1/
	SFr0PtzVGtzLePWiACpPw/Ffw9W+WC/tQ974wZnwsj9nzWygNb0972M1ZXW/EsGEVAZUkSHZkcH+p
	vKb2bez6TT9YjLcYp7Yl+ZE+BOMRb6ZKr/1QHWH1JtWxBgkfB0RDhCRsFPt5JaN7f1ouheyP0wi3c
	H4xn2lu1FZL8MHjTGh8clQAHugIlycq2/X92M8Qv8xeyPIePMBgdY0w6uXeB0LGr6FNpFOMzGRKLg
	GkGbvxybpQSURooSKvlf6G+IpjomhKMy9G+cKk49EzN5IbvJQMRcM8suiVXB4c1EmvpK4HsoEJXwU
	lUiI4fSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAuF4-00000004Fzz-0Mmb;
	Tue, 12 Nov 2024 16:59:50 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAu9I-00000004Ecj-2Fva
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 16:53:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 402D5A41EF9;
	Tue, 12 Nov 2024 16:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BF8C4CECD;
	Tue, 12 Nov 2024 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731430430;
	bh=ODw1HrrVUx4XDdn+NA3ZiM07EdzE1pUd7SlEHngh474=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPpko2qbSkx3B/Yke7goINBZ5S4Gf38HLGrkUd18K0+NDW5TDc2VM8SjUAEi81sCE
	 VWJR7e47xV/EaMi8Ut+FCVeSu/Se2MCM1NoE5AuqTmi3OjltsAR34taDLR9bK7barr
	 x0PRbnboZ7eYnBg6m7u87Mtvx+l0Csa6qtyBnsc0=
Date: Tue, 12 Nov 2024 17:53:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <2024111212-rash-suffocate-dc13@gregkh>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
 <2024111202-parish-prowess-78bc@gregkh>
 <c8c671c1-267a-4aa7-a64b-51a461176ad3@flourine.local>
 <2024111215-jury-unlighted-3953@gregkh>
 <5967d256-037e-4ac8-a509-c6955b03db05@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5967d256-037e-4ac8-a509-c6955b03db05@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_085352_799476_0FAA1488 
X-CRM114-Status: GOOD (  24.00  )
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

On Tue, Nov 12, 2024 at 05:15:31PM +0100, Daniel Wagner wrote:
> On Tue, Nov 12, 2024 at 04:42:40PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 12, 2024 at 04:33:09PM +0100, Daniel Wagner wrote:
> > > On Tue, Nov 12, 2024 at 02:58:43PM +0100, Greg Kroah-Hartman wrote:
> > > > > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > > > > +			    struct device *dev, unsigned int offset)
> > > > > +
> > > > > +{
> > > > > +	const struct cpumask *mask;
> > > > > +	unsigned int queue, cpu;
> > > > > +
> > > > > +	if (!dev->bus->irq_get_affinity)
> > > > > +		goto fallback;
> > > > 
> > > > I think this is better than hard-coding it, but are you sure that the
> > > > bus will always be bound to the device here so that you have a valid
> > > > bus-> pointer?
> > > 
> > > No, I just assumed the bus pointer is always valid. If it is possible to
> > > have a device without a bus, than I'll better extend the condition to
> > > 
> > > 	if (!dev->bus || !dev->bus->irq_get_affinity)
> > >         	goto fallback;
> > 
> > I don't know if it's possible as I don't know what codepaths are calling
> > this, it was hard to unwind.  But you should check "just to be safe" :)
> 
> The main path to map_queues is via the probe functions. There are some
> more paths like when updating a tagset after the number of queues but
> that is all after the probe function.
> 
> nvme_probe
>   nvme_alloc_admin_tag_set
>     blk_mq_alloc_tag_set
>        blk_mq_update_queue_map
>           set->ops->map_queues
> 	     blk_mq_htcx_map_queues
>   nvme_alloc_io_tag_set
>     blk_mq_alloc_tag_set
>       blk_mq_update_queue_map
>         set->ops->map_queues
>           blk_mq_htcx_map_queues
> 
> virtscsi_probe, hisi_sas_v3_probe, ...
>   scsi_add_host
>     scsi_add_host_with_dma
>       scsi_mq_setup_tags
>          blk_mq_alloc_tag_set
>            blk_mq_update_queue_map
>              set->ops->map_queues
>                blk_mq_htcx_map_queues
> 
> virtblk_probe
>   blk_mq_alloc_tag_set
>     blk_mq_update_queue_map
>       set->ops->map_queues
>         blk_mq_htcx_map_queues
> 
> Does this help?

Ok, that seems fine.  Worst case, you crash and it's obvious that it
needs to be checked in the future :)

thanks,

greg k-h

