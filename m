Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE482C6FA86
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fTXfM16EyzMdd6KzU6GPZWnMgRNiiiQnBhMGGC3fAHc=; b=g8Em+nATmzuM8tXzYaTyeHKgLH
	eBE0lTQcv7J0X4KnN8PH7g/ut6Xj9qd9XQUoDXHdBt4K2YsGdvHZILqhOtqerfOWBZ+z1lPyd7D3c
	8F40iwhXeJx3mMA9kj4GyXDZCCELVJ+X0HhNg/yXDnUR6PSXVKZTMAOX/JZjU5Si205uTgkM5QjIH
	byVTctiPzOwTHaZuEmVNy9CMqZZyBML9mtrY2ERkbb07CH/bgXwRcfVyns2ps2HNfQvecY8HFj0ei
	fCnkejbfZoeM6sReg2qxrz8wVghsAxrJAuME/OMWnGaDKdKp8AjcTVFLR/ECFKvXyogSqmCJAczX4
	ZQnKl6SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obITK-00ERaQ-5F; Thu, 22 Sep 2022 09:26:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obIHA-00EO0b-OT
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 09:13:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663838023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTXfM16EyzMdd6KzU6GPZWnMgRNiiiQnBhMGGC3fAHc=;
	b=XGML3WEs+XMMGLjl+w2MUiT+FHlJ2o0D9KnNUfwIaQgY8FDnAPIkYlb3xY5ztvYP5WnIEq
	nRKGyHUtuLXZq9khCW2hTfi8MQo5nxCZ/D5EXVsZVD1JOFWvmPjYYxjN1x4UOI89iGm/Ve
	493bsnlLJ1f7WeGYArzajBggm8n2eNI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-wXTBLHQ7Ma-Z0JJWH5XcQQ-1; Thu, 22 Sep 2022 05:13:40 -0400
X-MC-Unique: wXTBLHQ7Ma-Z0JJWH5XcQQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3AF7800186;
	Thu, 22 Sep 2022 09:13:39 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E8EA492B0F;
	Thu, 22 Sep 2022 09:13:34 +0000 (UTC)
Date: Thu, 22 Sep 2022 17:13:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: avoid to hang in the cpuhp offline handler
Message-ID: <YywnOO42kvr8CotB@T590>
References: <20220920021724.1841850-1-ming.lei@redhat.com>
 <19568225-56a1-f545-b8de-a219b7f843b7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19568225-56a1-f545-b8de-a219b7f843b7@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_021344_910251_DB332D2A 
X-CRM114-Status: GOOD (  22.67  )
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

On Thu, Sep 22, 2022 at 09:47:09AM +0100, John Garry wrote:
> On 20/09/2022 03:17, Ming Lei wrote:
> > For avoiding to trigger io timeout when one hctx becomes inactive, we
> > drain IOs when all CPUs of one hctx are offline. However, driver's
> > timeout handler may require cpus_read_lock, such as nvme-pci,
> > pci_alloc_irq_vectors_affinity() is called in nvme-pci reset context,
> > and irq_build_affinity_masks() needs cpus_read_lock().
> > 
> > Meantime when blk-mq's cpuhp offline handler is called, cpus_write_lock
> > is held, so deadlock is caused.
> > 
> > Fixes the issue by breaking the wait loop if enough long time elapses,
> > and these in-flight not drained IO still can be handled by timeout
> > handler.
> 
> I don't think that that this is a good idea - that is because often drivers
> cannot safely handle scenario of timeout of an IO which has actually
> completed. NVMe timeout handler may poll for completion, but SCSI does not.
> 
> Indeed, if we were going to allow the timeout handler handle these in-flight
> IO then there is no point in having this hotplug handler in the first place.

That is true from the beginning, and we did know the point, I remember that
Hannes asked this question in LSF/MM, and there are many drivers which don't
implement timeout handler.

For this issue, it looks more like one nvme specific since nvme timeout handler
can't move on during nvme reset. Let's see if it can be fixed by nvme
driver.

BTW nvme error handling is really fragile, not only this one, such as, any timeout
during reset will cause device removed.


Thanks.
Ming


