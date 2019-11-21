Return-Path: <SRS0=O3HW=ZN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A7DC432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 03:12:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D7020721
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 03:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UThSmj/5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2QWUAjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D7020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0H28RZORGwm9BYHbpGDVf2Y/2UHXT2mdYhS8dPCHkx0=; b=UThSmj/5YMxQHY
	fW2KJWuptWNX996Mdu+/B0d6FcjQqRE3injWwopKkbu9F2kyQV2OPgB0ky3EczlpZqKXKAwejlYHx
	08dy/SfGec48H1jh+cvslhAO3ABNFqtvzhItep+PPzKvoeszdz9cvzg0ov/IxNQDcJat2BQgJKD6p
	5kJfoGwDeb6FYsC8MRcn85NHD7iC86dtFgdwx2kaaaEXFxwzjmAR1dJ+8eKCGQYwD/cXnXoRvW3Wu
	ut2EI45Ky+jKbD7ZjUEcQf2dEVGcSgfM0aDUYZ1vi97NWS4th/+RI0aHpjBOke6uh7qJ+SxfqYxAy
	JlRGJeHhNLXy8HhXQzRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXctG-0000g9-3t; Thu, 21 Nov 2019 03:12:18 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXctD-0000fd-3i
 for linux-nvme@lists.infradead.org; Thu, 21 Nov 2019 03:12:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574305933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41lah+ACXvcakjL3LjU52DamzGku7M/KkABLyewmk4w=;
 b=V2QWUAjsPbyJ8EJ8SLdf5rmKYrXGxpE/c7eda20o5i5AjVQfnFCvp+390diYqDDnfYyLuL
 22eMQW/90kDw2IhNw4J31kN0XeDWtpTCPTj3vvjAT2nu826dHqLd04LX+aGFXsZVsPLaKV
 ophRQjw4E4a/9AoW+htOmOmV3e/K31o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-tYV-m5tLO2GO026XdeltuQ-1; Wed, 20 Nov 2019 22:12:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9B39593A0;
 Thu, 21 Nov 2019 03:12:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4404C53C30;
 Thu, 21 Nov 2019 03:11:58 +0000 (UTC)
Date: Thu, 21 Nov 2019 11:11:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: Re: [PATCH V3 0/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Message-ID: <20191121031154.GJ24548@ming.t460p>
References: <20191114025917.24634-1-ming.lei@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191114025917.24634-1-ming.lei@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: tYV-m5tLO2GO026XdeltuQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191120_191215_226232_1876BE01 
X-CRM114-Status: GOOD (  12.89  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 Jens Axboe <axboe@fb.com>, Nadolski Edmund <edmund.nadolski@intel.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 14, 2019 at 10:59:15AM +0800, Ming Lei wrote:
> Hi,
> 
> The two patches fix one performance regression on Microsoft Corporation device. The
> root cause is that Microsoft device applies aggressive interrupt coalescing, so
> single job fio performance drops much after we removes checking cq in
> f9dde187fa92("nvme-pci: remove cq check after submission").
> 
> Turns out this issue is very specific on Microsoft device, so add
> a quirk for checking CQ on this device.
> 
> V3:
> 	- replace spin_trylock_irqsave with spin_trylock_irq
> 	- fix comment on cq_lock & cq_poll_lock
> 
> V2:
> 	- only check CQ for Microsoft device.
> 
> 
> 
> Ming Lei (2):
>   nvme-pci: move sq/cq_poll lock initialization into nvme_init_queue
>   nvme-pci: check CQ after batch submission for Microsoft device
> 
>  drivers/nvme/host/nvme.h |  6 +++
>  drivers/nvme/host/pci.c  | 98 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 90 insertions(+), 14 deletions(-)
> 
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Long Li <longli@microsoft.com>
> -- 
> 2.20.1
> 

Hi Guys,

Ping...

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
