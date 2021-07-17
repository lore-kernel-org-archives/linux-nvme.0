Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC04C636C9
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 09:31:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6B6613BB
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 09:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6B6613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HDgVCoEscPD8sqd2OpNRQ3iAmVj75+qtutjF8Jv9Kvg=; b=3kXD2ktROSesHT
	55X2EaAsqiXMN/DaERVW/4VfNE0koXIDyWTzwjcw0zduDq0B3vsJzjMg+4pA7caKLZhxgDjTNZ1J5
	7+TAQeTPm7dH9CjE3ffojkOPgC46kbgaPA0aaTqmnyrboo/ldl7DeX7N1wS5/BkkXRpIbxsSpAkum
	Dk1UtI4K7Or/4jvb25vB41CfBn60QCUMSZmkMZKbZznd3cRH5ptdj6PlybhRS7FjGQ39iEBrksJIn
	mihK3aWoOmxzfJ6lZiLbgMmi3PZvfTA5+Fdtbc9ZO4bdL4NfU/m5j4PRrwJbfe2PUiWqLXivITrHA
	XfvdEU9Fjzt2u6rN1oQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4gfA-006MmP-5q; Sat, 17 Jul 2021 09:31:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4gf7-006Mld-AL
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 09:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626514265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qpkQ64ZywmmGid3wm2wpO4W6jPhvZtPWa6GAG8VtSbo=;
 b=RPeTG1xP0ojA65g4BwQEHk70btfaozScT7QM38tKz4DBfopf/lBREQupUbbbknXGejDSt0
 zSqo0nj0g3d0sm4mW6XKodOjJZ9O+1bHPiJBPp5P67UB5ejquHNiFiUaC4cRRfkxkwpwY2
 oJBA8oHz2Fwl8qPhuPZ4AByP/cW3xYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-fkIVUY3gMrKMjaSGLm28wg-1; Sat, 17 Jul 2021 05:31:03 -0400
X-MC-Unique: fkIVUY3gMrKMjaSGLm28wg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D3B8100B3AC;
 Sat, 17 Jul 2021 09:31:00 +0000 (UTC)
Received: from T590 (ovpn-12-83.pek2.redhat.com [10.72.12.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DC6360C0F;
 Sat, 17 Jul 2021 09:30:48 +0000 (UTC)
Date: Sat, 17 Jul 2021 17:30:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <YPKjQxZ4roigdvbq@T590>
References: <20210715120844.636968-2-ming.lei@redhat.com>
 <20210716200154.GA2113453@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210716200154.GA2113453@bjorn-Precision-5520>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210717_023109_494464_76CD1957 
X-CRM114-Status: GOOD (  32.12  )
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

On Fri, Jul 16, 2021 at 03:01:54PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 15, 2021 at 08:08:42PM +0800, Ming Lei wrote:
> > irq vector allocation with managed affinity may be used by driver, and
> > blk-mq needs this info because managed irq will be shutdown when all
> > CPUs in the affinity mask are offline.
> > 
> > The info of using managed irq is often produced by drivers(pci subsystem,
> 
> Add space between "drivers" and "(".
> s/pci/PCI/

OK.

> 
> Does this "managed IRQ" (or "managed affinity", not sure what the
> correct terminology is here) have something to do with devm?
> 
> > platform device, ...), and it is consumed by blk-mq, so different subsystems
> > are involved in this info flow
> 
> Add period at end of sentence.

OK.

> 
> > Address this issue by adding one field of .irq_affinity_managed into
> > 'struct device'.
> > 
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/base/platform.c | 7 +++++++
> >  drivers/pci/msi.c       | 3 +++
> >  include/linux/device.h  | 1 +
> >  3 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 8640578f45e9..d28cb91d5cf9 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -388,6 +388,13 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
> >  				ptr->irq[i], ret);
> >  			goto err_free_desc;
> >  		}
> > +
> > +		/*
> > +		 * mark the device as irq affinity managed if any irq affinity
> > +		 * descriptor is managed
> > +		 */
> > +		if (desc[i].is_managed)
> > +			dev->dev.irq_affinity_managed = true;
> >  	}
> >  
> >  	devres_add(&dev->dev, ptr);
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 3d6db20d1b2b..7ddec90b711d 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -1197,6 +1197,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> >  	if (flags & PCI_IRQ_AFFINITY) {
> >  		if (!affd)
> >  			affd = &msi_default_affd;
> > +		dev->dev.irq_affinity_managed = true;
> 
> This is really opaque to me.  I can't tell what the connection between
> PCI_IRQ_AFFINITY and irq_affinity_managed is.

Comment for PCI_IRQ_AFFINITY is 'Auto-assign affinity',
'irq_affinity_managed' basically means that irq's affinity is managed by
kernel.

What blk-mq needs is exactly if PCI_IRQ_AFFINITY is applied when
allocating irq vectors. When PCI_IRQ_AFFINITY is used, genirq will
shutdown the irq when all CPUs in the assigned affinity are offline,
then blk-mq has to drain all in-flight IOs which will be completed
via this irq and prevent new IO. That is the connection.

Or you think 'irq_affinity_managed' isn't named well?

> 
> AFAICT the only place irq_affinity_managed is ultimately used is
> blk_mq_hctx_notify_offline(), and there's no obvious connection
> between that and this code.

I believe the connection is described in comment.


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
