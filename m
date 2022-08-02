Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F6FC00144
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Aug 2022 00:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BD5DFqwAa4Usxy9UXF0CCQO/Bx9SeGClzw/R9MYxEr4=; b=qKg28BlWUiMfeFYiGvveOa+CEo
	dQ90GlyIuXEn9wEAHWFiRtZu9O3P+5QXOwLeGGLt3oNwMKaZ3trLQvLLb1n0d/w4iDobApVmMKyRo
	/uIOTVxEzRvQmdlyDDK5EZqD3p5iTuBqb+hXyU/FZEQBO8xNpmH+3NxoZx+2KpIqzBRxeGlG+jxBP
	R4KDTONanAbqHU6vWlURma2Ab8b53ztFMriOjoYzXumnS2ve4o+5cB7hpZkIYTLmED9lyZ6wjUC4/
	bEcIaEdt7zRQrEgvfXOMlLoo1LY8ORCJHBq1tBUmqklmqcYdefsNOcgKK7h2ZRwtEM2oBUAAyFm1C
	/qwJz9UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIfPi-00EPUO-Bk; Tue, 02 Aug 2022 00:05:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIfPZ-00EOp7-7P
	for linux-nvme@lists.infradead.org; Tue, 02 Aug 2022 00:05:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659398722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BD5DFqwAa4Usxy9UXF0CCQO/Bx9SeGClzw/R9MYxEr4=;
	b=XCm+qshqG7bHnks+TlfGFbx+rv5xopvDLZYI7WqKLYZG5hvmnhBi5ySxqwCr4krpF1QjLR
	wkFzVbflmWrtf35j/0q1JKf1wmHwWXsbQ2ngLNDc92p4b+TwbA/4QtdETVzd+QTnryghKt
	LQy2QcNCbQvsYfgnJUb+HY76H9xHksw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-ebMe7vNPOCeXatfwG96C9Q-1; Mon, 01 Aug 2022 20:05:19 -0400
X-MC-Unique: ebMe7vNPOCeXatfwG96C9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E330802D1C;
	Tue,  2 Aug 2022 00:05:19 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0A4F4010FA3;
	Tue,  2 Aug 2022 00:05:14 +0000 (UTC)
Date: Tue, 2 Aug 2022 08:05:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	ming.lei@redhat.com
Subject: Re: [PATCH] nvme-pci: fix race between pci reset and nvme probe
Message-ID: <YuhqNUNgkT9HpLEo@T590>
References: <20220801125753.1434024-1-ming.lei@redhat.com>
 <YufkHXoUrw7jRLuT@kbusch-mbp>
MIME-Version: 1.0
In-Reply-To: <YufkHXoUrw7jRLuT@kbusch-mbp>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_170527_348420_9D4F8E0F 
X-CRM114-Status: GOOD (  28.57  )
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

On Mon, Aug 01, 2022 at 08:33:01AM -0600, Keith Busch wrote:
> On Mon, Aug 01, 2022 at 08:57:53PM +0800, Ming Lei wrote:
> > After nvme_probe() returns, device lock is released, and PCI reset
> > handler may come, meantime reset work is just scheduled and should
> > be in-progress.
> > 
> > When nvme_reset_prepare() is run, all NSs may not be allocated yet
> > and each NS's request queue won't be frozen by nvme_dev_disable().
> > 
> > But when nvme_reset_done() is called for resetting controller, all
> > NSs may have been scanned successfully, and nvme_wait_freeze() is
> > called on un-frozen request queues, then wait forever.
> > 
> > Fix the issue by holding device lock for resetting from nvme probe.
> > 
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Link: https://lore.kernel.org/linux-block/CAHj4cs--KPTAGP=jj+7KMe=arDv=HeGeOgs1T8vbusyk=EjXow@mail.gmail.com/#r
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/nvme/host/pci.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 4232192e10dd..d49b1a082983 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3075,9 +3075,14 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
> >  static void nvme_async_probe(void *data, async_cookie_t cookie)
> >  {
> >  	struct nvme_dev *dev = data;
> > +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> >  
> > +	pci_dev_lock(pdev);
> > +	nvme_reset_ctrl(&dev->ctrl);
> >  	flush_work(&dev->ctrl.reset_work);
> >  	flush_work(&dev->ctrl.scan_work);
> > +	pci_dev_unlock(pdev);
> > +
> >  	nvme_put_ctrl(&dev->ctrl);
> >  }
> 
> When low on memory, async_schedule() falls back to calling the requested
> function directly, so this would deadlock on taking the pci_dev_lock() the
> second time within the probe context.

Good catch, maybe async_schedule() should provide one variation by
returning failure in case of OOM.

> 
> If it is successfully scheduled asynchronously, holding the lock blocks a hot
> removal, which might be the only thing that can unblock the nvme reset_work
> from forward progress.

OK, adding one reset or pci_reset lock may avoid to affect hot removal.

> 
> If you are encountering a nvme_reset_prepare() condition during scanning, that
> might indicate a failure to communicate with the end device. The scan work may
> need the error handling to unblock it.

Not sure I get your point. nvme_reset_prepare() is called from storing
to pci device's reset sysfs attr, so it can come any time, including
scanning.

Thanks,
Ming


