Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FD8C3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 12:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HiraDDQpqmwe2DNHjOhcf2/uc0J1k/EhobAEpqxem9Y=; b=0m1LvB9698+ZbzFrNiR8/8T/0X
	6e0nQ92h95Y1XGSSPUk8i8m/18YymVtlqsAxK1SZnQOkeFchNrxSEBDBVTk1VKQMFGrGcaYrXPXkR
	RZajBsjUVTYaFjI0yV8Jr4h82lKMcJqgW5fBpWakemLw94Suk6Te+V39YvxbQFdNwICgSnjXIm2l1
	t3Ekuw7oUZjYRsfMl31Rw3bRixP50CPXg7tvYoMsZytVX62u4JqjIV36lvDnCDQNYivzQeDPcYTuq
	gW9jTyk2FOTe9JhOrMQtb3e0FKZXMltKqRNi0qrw1KqFEdUxieeCUXRJWIOHi8WU2p/FfnH2tdn2e
	3N9AEG0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOcN5-00000006cyl-2Zqw;
	Tue, 02 Jul 2024 12:12:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOcN2-00000006cwl-3uij
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 12:12:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719922347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HiraDDQpqmwe2DNHjOhcf2/uc0J1k/EhobAEpqxem9Y=;
	b=RQP0Z6O3/dvI/wP4v5aPVAuCfc1D8iOW/2qufuqSf/UeYrd0/56VScTqNBLa2MAKntLb5H
	4YRfPEGQmVJbB0QkGiDA4X/BSjXRBzfXqEVqTQH87we+U3AdoUZhYSshiq9lqze+k4YbX6
	03LAr3j5YAThlBKhA5h8fUqdOJNG3vs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-p82i0ChAMIOa-VMVDEqkRA-1; Tue,
 02 Jul 2024 08:12:24 -0400
X-MC-Unique: p82i0ChAMIOa-VMVDEqkRA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 709D01956058;
	Tue,  2 Jul 2024 12:12:22 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21CEE1956048;
	Tue,  2 Jul 2024 12:12:16 +0000 (UTC)
Date: Tue, 2 Jul 2024 20:12:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Lawrence Troup <ltroup@cisco.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
Message-ID: <ZoPum7MPTuA6/t7O@fedora>
References: <20240702104112.4123810-1-ming.lei@redhat.com>
 <20240702115002.GA16219@lst.de>
MIME-Version: 1.0
In-Reply-To: <20240702115002.GA16219@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_051229_065727_EB5F52B7 
X-CRM114-Status: GOOD (  15.70  )
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

On Tue, Jul 02, 2024 at 01:50:02PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 06:41:12PM +0800, Ming Lei wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > People _really_ want to control their interrupt affinity in some
> > cases, such as Openshift with Performance profile, in which each
> > irq's affinity is completely specified from userspace. Turns out
> > that 'isolcpus=managed_irqs' isn't enough.
> > 
> > Add module parameter to allow unmanaged interrupts, just as some
> > SCSI drivers are doing.
> 
> Same as before: hell no.  We can't just add hacky global kernel
> parameters everywhere.  We need the cpu isolation infrastructure to
> work properly instead of piling hacks of hacks in every relevant driver.

Per my understanding, here cpu isolation infrastructure can't work for
Openshift, in which IO workload can be run on applications which are executed
on isolated CPUs, meantime userspace do expect that interrupts can be
triggered on user-specified CPU cores only in controllable way.  

Marcelo and Lawrence may have more input in this area.

Also irq allocation really belongs to device & driver stuff, how can that be
hack? We even may not abstract public API in block layer for handling
irq related thing.


Thanks, 
Ming


