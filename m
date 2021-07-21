Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444E1C636C8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 00:30:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F1761009
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 00:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F1761009
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=hGUvYMPHJi14aJ7zAswZhE5Kgf1PLueeT23kc9+Jiw8=; b=AuV8j2PqeDC7VP
	Ihn0MKBNC2fk6cWbmJOUXf/cOfQQHZkIkMPvGchpZHG3MnmcQ7UvZMmUnWZ0StYwGPuGvqlYyVaOO
	DOQ6/RiTu1V8pumXF72XG5NW8AyPCCs+OhlosDR0DpBRRV/hFHO+p+vphq+A4Bghmf5AdDMvFConk
	ciMlmXWX/SQ4e0p6E9qkvqkuQnOnTAxUy4n5UCCy3VrVXYafkBfQDVMdIOewOPrQh2TXutVJ+MNAl
	Hz1byook3J8GF7ZOB5sxRHT2ySCwkp3nNzD5vcE/LigYdkjBeieIdZDB8vYrTzE8nVn4GMZGxZ+dk
	lt+Jz3MSftqlInvtDvOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m607s-00EBaI-VU; Wed, 21 Jul 2021 00:30:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m607q-00EBZy-1X
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 00:30:15 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42F1960BBB;
 Wed, 21 Jul 2021 00:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626827413;
 bh=oA6LUVtEtIPCXpJhxFUKzyM7hTN95PCWkcpLTJ+YT4s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=pbmtrLNrkZYFQkdU0kuOtTOeJfzUKbGu52QkdgdAuMv3fn9SroY+iz6gdFUVG5Yb/
 enLzZ04deMTAR7bQPV3QY6J8+qIRDfmA/uh3OPf2cldVkua5juXwId6NUJv6mKE6AH
 oS3g8bpcwuPWqhf5+Z4fzvdcsAkjAvMVQ09gqUREW/mElhJwEjl/2b/gG6+NR4seRZ
 jieHyIu3xrHenFcCoHFtTCgnAIC/Mg13pMqC4O7czpnFnTpi0/bS6VwNCH4ILcmdYf
 HWx+Mm8FgbuzFoPHj2djpLNP+S+CtX3V6thz08cJPHdhWZ/2JT4pF7W+gdv32zjUlG
 twPnb45fzlmyg==
Date: Tue, 20 Jul 2021 19:30:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
Message-ID: <20210721003011.GA144876@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YPKjQxZ4roigdvbq@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_173014_167711_93EB1323 
X-CRM114-Status: GOOD (  39.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Jul 17, 2021 at 05:30:43PM +0800, Ming Lei wrote:
> On Fri, Jul 16, 2021 at 03:01:54PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jul 15, 2021 at 08:08:42PM +0800, Ming Lei wrote:
> > > irq vector allocation with managed affinity may be used by driver, and
> > > blk-mq needs this info because managed irq will be shutdown when all
> > > CPUs in the affinity mask are offline.
> > > 
> > > The info of using managed irq is often produced by drivers(pci subsystem,
> > 
> > Add space between "drivers" and "(".
> > s/pci/PCI/
> 
> OK.
> 
> > Does this "managed IRQ" (or "managed affinity", not sure what the
> > correct terminology is here) have something to do with devm?
> > 
> > > platform device, ...), and it is consumed by blk-mq, so different subsystems
> > > are involved in this info flow
> > 
> > Add period at end of sentence.
> 
> OK.
> 
> > > Address this issue by adding one field of .irq_affinity_managed into
> > > 'struct device'.
> > > 
> > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/base/platform.c | 7 +++++++
> > >  drivers/pci/msi.c       | 3 +++
> > >  include/linux/device.h  | 1 +
> > >  3 files changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > index 8640578f45e9..d28cb91d5cf9 100644
> > > --- a/drivers/base/platform.c
> > > +++ b/drivers/base/platform.c
> > > @@ -388,6 +388,13 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
> > >  				ptr->irq[i], ret);
> > >  			goto err_free_desc;
> > >  		}
> > > +
> > > +		/*
> > > +		 * mark the device as irq affinity managed if any irq affinity
> > > +		 * descriptor is managed
> > > +		 */
> > > +		if (desc[i].is_managed)
> > > +			dev->dev.irq_affinity_managed = true;
> > >  	}
> > >  
> > >  	devres_add(&dev->dev, ptr);
> > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > index 3d6db20d1b2b..7ddec90b711d 100644
> > > --- a/drivers/pci/msi.c
> > > +++ b/drivers/pci/msi.c
> > > @@ -1197,6 +1197,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> > >  	if (flags & PCI_IRQ_AFFINITY) {
> > >  		if (!affd)
> > >  			affd = &msi_default_affd;
> > > +		dev->dev.irq_affinity_managed = true;
> > 
> > This is really opaque to me.  I can't tell what the connection between
> > PCI_IRQ_AFFINITY and irq_affinity_managed is.
> 
> Comment for PCI_IRQ_AFFINITY is 'Auto-assign affinity',
> 'irq_affinity_managed' basically means that irq's affinity is managed by
> kernel.
> 
> What blk-mq needs is exactly if PCI_IRQ_AFFINITY is applied when
> allocating irq vectors. When PCI_IRQ_AFFINITY is used, genirq will
> shutdown the irq when all CPUs in the assigned affinity are offline,
> then blk-mq has to drain all in-flight IOs which will be completed
> via this irq and prevent new IO. That is the connection.
> 
> Or you think 'irq_affinity_managed' isn't named well?

I've been looking at "devm" management where there is a concept of
devm-managed IRQs, and you mentioned "managed IRQ" in the commit log.
But IIUC this is a completely different sort of management.

> > AFAICT the only place irq_affinity_managed is ultimately used is
> > blk_mq_hctx_notify_offline(), and there's no obvious connection
> > between that and this code.
> 
> I believe the connection is described in comment.

You mean the comment that says "hctx needn't to be deactivated in case
managed irq isn't used"?  Sorry, that really doesn't explain to me why
pci_alloc_irq_vectors_affinity() needs to set irq_affinity_managed.
There's just a lot of magic here that cannot be deduced by reading the
code.

Nit: s/needn't to be/needn't be/ in that comment.  Or maybe even
"Deactivate hctx only when managed IRQ is used"?  I still have no idea
what that means, but at least it's easier to read :)  Or maybe this is
actually "draining a queue" instead of "deactivating"?

Bjorn

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
