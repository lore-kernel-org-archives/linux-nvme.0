Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13463C30658
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 01:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HkHFklPdCXa0Ta+zmSNBk3VvlYbMDCS7mKA5dRTIGdo=; b=GIIEOVnRJEh7eDFfr2XGzgvGNJ
	kWxHmhwxk3I/Y7dvSCjJ5EibloSxeSz50RE49PuGdTqiFIuClxnoTzwi4ohc/Xa8CTETEvF8J9Q+K
	tHCKd6TYhXn+OGLh291gmonZRudiLbQKonX5D/vmwW8zClm4iXuRkPDDOtOcnEDInZ9D958WB+CmR
	EVUbr5ugVjDnkOHJSxK6YxWv+iPb6IvO4JpSe/bVNIoXlSv2kLPpmp48txYgF9Lp4abnqX0qesIx0
	qGfk0TQZkzJqY6mSQfgBrCup21UvMNQLAx3sDALtWdmJ6Zgg8hZ/ZPqSyL0fakEd/cdK/8CDUtAHv
	noRL0ciQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOp9T-00000008W6U-0H39;
	Wed, 03 Jul 2024 01:51:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOp9R-00000008W64-1973
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 01:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719971476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkHFklPdCXa0Ta+zmSNBk3VvlYbMDCS7mKA5dRTIGdo=;
	b=TrgQnwHQgcKoT2QNR3HvFvFxrMNh+z13iU+RPYJWzvO1yC2AagpqTMa7YAklSl2qa96FVW
	3OHDOxfI4hbY7UthKvQVE4CL4H2pgI1wLKhAX9wbMC1n00KCNuRSmz5vd96ftJxcYJzafk
	9G5dngBMKk5bfCSxpR3wVGNQiQgPESg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-AzciHdz3OFCug9pfvLzxLw-1; Tue,
 02 Jul 2024 21:51:15 -0400
X-MC-Unique: AzciHdz3OFCug9pfvLzxLw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 968D919560B5;
	Wed,  3 Jul 2024 01:51:13 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 338921955E80;
	Wed,  3 Jul 2024 01:51:07 +0000 (UTC)
Date: Wed, 3 Jul 2024 09:51:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Lawrence Troup <ltroup@cisco.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
Message-ID: <ZoSuhqlKvKyyMQn5@fedora>
References: <20240702104112.4123810-1-ming.lei@redhat.com>
 <20240702115002.GA16219@lst.de>
 <ZoPum7MPTuA6/t7O@fedora>
 <hdvvssh5azfwzgymk3olmtfwwpc2fnyzjflqt4pl2jt3pm4s2w@nbek7v47kzcv>
MIME-Version: 1.0
In-Reply-To: <hdvvssh5azfwzgymk3olmtfwwpc2fnyzjflqt4pl2jt3pm4s2w@nbek7v47kzcv>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_185117_405215_0DB3665C 
X-CRM114-Status: GOOD (  25.33  )
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

On Tue, Jul 02, 2024 at 06:28:19PM +0200, Daniel Wagner wrote:
> On Tue, Jul 02, 2024 at 08:12:11PM GMT, Ming Lei wrote:
> > On Tue, Jul 02, 2024 at 01:50:02PM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 02, 2024 at 06:41:12PM +0800, Ming Lei wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > People _really_ want to control their interrupt affinity in some
> > > > cases, such as Openshift with Performance profile, in which each
> > > > irq's affinity is completely specified from userspace. Turns out
> > > > that 'isolcpus=managed_irqs' isn't enough.
> > > > 
> > > > Add module parameter to allow unmanaged interrupts, just as some
> > > > SCSI drivers are doing.
> > > 
> > > Same as before: hell no.  We can't just add hacky global kernel
> > > parameters everywhere.  We need the cpu isolation infrastructure to
> > > work properly instead of piling hacks of hacks in every relevant driver.
> > 
> > Per my understanding, here cpu isolation infrastructure can't work for
> > Openshift, in which IO workload can be run on applications which are executed
> > on isolated CPUs, meantime userspace do expect that interrupts can be
> > triggered on user-specified CPU cores only in controllable way.  
> > 
> > Marcelo and Lawrence may have more input in this area.
> > 
> > Also irq allocation really belongs to device & driver stuff, how can that be
> > hack? We even may not abstract public API in block layer for handling
> > irq related thing.
> 
> I am confused. I though you told me that my series 'nvme-pci: honor
> isolcpus configuration' is not necessary. But you still need this patch

Your patch fixes nothing basically, meantime it introduces regression. But
I don't object the approach if blk-mq regressions can be solved.

> to get the affinity sorted out? Wouldn't it make sense to figure out how
> we can make my series working also for your use case? E.g. we could
> introduce another HK type (io_queue) to control the affinity. This would
> decouple if from the managed_irq option.

Adding new HK type can't help this issue because Openshift environment needs
to control each irq's affinity by themselves dynamically, and even IO workload
may be run on isolated CPUs.


Thanks, 
Ming


