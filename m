Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B096DC25B10
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 00:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DUsYOvhdWWM9ZVtT1kCTyY15sOEM0ZUX3VDbW/nl+4o=; b=fkp6pSYymAuawi6lk4rghQ9yZl
	JK+JDISJUZozygPVxxrrbn0fJEusZG7viZ0zqL+wXrQg4KwoEzOyXh6LaLGJjX3vKcRlL3GYC44ks
	FCvm1RmcplTiiDAe9etJONz2WNInHRxB+WNyYDH5O/BdAJFhskdzUQgyca81Sa5BqwHECrY9drtXa
	+zCrLx2Gb8uSppdF/rm0ML01MB6SkSfXP5qTm9nXrFH4W49flB01cnZTqj6fkIS0Mdl2whvwYLpo2
	9MVoeiM0J5rx60SCuWXEVetsGjGpLRPKDupSDClj+PKLRtT0U835ZuOi3ZLpdyd4lk9RWwsIktkpk
	RxukYFVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5arI-00000006vEE-0tRL;
	Sat, 11 May 2024 00:45:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5arF-00000006vDQ-1mJk
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 00:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715388300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUsYOvhdWWM9ZVtT1kCTyY15sOEM0ZUX3VDbW/nl+4o=;
	b=Q7y9eZiYJhbnKJt/S5Al8qBMwnmkmYGaKhJR8O0C7tOoSSS8zhPqHZGP/F5rZOSMq1STTM
	qZ4hBVtLO1tyCKVjrS7iqP1qpmTUB7CSbTeUNwrEJQG4UlBIJPINQBD7yayZh1xvHjWmcK
	5vs1XvRfRzGx5nuz8fXpq/bPufH+fhY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-_BAlvk6-MVG-4UMYE2pyuA-1; Fri,
 10 May 2024 20:44:58 -0400
X-MC-Unique: _BAlvk6-MVG-4UMYE2pyuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDEC029AA3B3;
	Sat, 11 May 2024 00:44:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A2DDF2087D79;
	Sat, 11 May 2024 00:44:54 +0000 (UTC)
Date: Sat, 11 May 2024 08:44:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, ming.lei@redhat.com
Subject: Re: [PATCHv2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj6/gqxxDD74IYR6@fedora>
References: <20240510174645.3987951-1-kbusch@meta.com>
 <Zj6yDtRzl68zspQY@fedora>
 <Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_174501_561975_4EA9F2CA 
X-CRM114-Status: GOOD (  20.86  )
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

On Fri, May 10, 2024 at 06:29:23PM -0600, Keith Busch wrote:
> On Sat, May 11, 2024 at 07:47:26AM +0800, Ming Lei wrote:
> > On Fri, May 10, 2024 at 10:46:45AM -0700, Keith Busch wrote:
> > >  		map->queue_offset = qoff;
> > > -		if (i != HCTX_TYPE_POLL && offset)
> > > +		if (managed_irqs && i != HCTX_TYPE_POLL && offset)
> > >  			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
> > >  		else
> > >  			blk_mq_map_queues(map);
> > 
> > Now the queue mapping is built with nothing from irq affinity which is
> > setup from userspace, and performance could be pretty bad.
> 
> This just decouples the sw from the irq mappings. Every cpu still has a
> blk-mq hctx, there's just no connection to the completing CPU if you
> enable this.

I don't object to unmanaged irq, which is actually supported in some scsi
hosts too, but all or most of them still wire pci irq vector affinities with
hw queue, instead of using mapping from blk_mq_map_queues() simply. 

> 
> Everyone expects nvme performance will suffer. IO latency and CPU
> efficieny are not everyone's top priority, so allowing people to
> optimize for something else seems like a reasonable request.

I guess more people may be interested in 'something else', care to share
them in the commit log, cause nvme is going to support it.

>  
> > Is there any benefit to use unmanaged irq in this way?
> 
> The immediate desire is more predictable scheduling on a subset of CPUs
> by steering hardware interrupts somewhere else. It's the same reason
> RDMA undid managed interrupts.
> 
>   231243c82793428 ("Revert "mlx5: move affinity hints assignments to generic code")

The above commit only mentions it becomes not flexible since user can't
adjust irq affinity any more.

It is understandable for network, there is long history people need to adjust
irq affinity from user space.


Thanks,
Ming


