Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ED3C64990
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ARtKWOU6JoXyrCimmv2bJ1C0utKQS4VCLvBusx9V14o=; b=au86KDiRDZ0Lux4YavDOtorsaf
	j7tZhaom7U5H2pyxTf5btDUZ/MXK6b5UsWPO+bqx9VeiSzNRBWpPYF4W+EW3lbfBFSH68m7mVSluG
	hhLYIuP11qWmtz0jY2LfGC1QBRizYxo+Q4K3GnAC2kmVrt+zsJ5XVR/OVZtqxYdeAKZg0rH+ZQX3a
	ZnUtBiuq2O0pXN7qYt+ZWi4YuGhgsrd7s5QEMqPjLbTIFwD+5VQ3Zn+pXbhV2tFcS6z3JUQ61syCc
	NCy+HcYrnxSy4H0wi7gH6fnkHxIH8wk6Mo/FzElbo0E92PVcI6dxNBwU0gCKN2KDU7rPlJsomSy3z
	V4TtfYiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRDds-00FCpD-PG; Thu, 25 Aug 2022 14:15:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRDdo-00FClt-NE
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 14:15:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661436927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ARtKWOU6JoXyrCimmv2bJ1C0utKQS4VCLvBusx9V14o=;
	b=iaYRHIvI1Xbsk4XRi1CSaw1xbjmpUqw56delnD6mAv/CkriCu5SN4QzvRjlESLDsTFArV8
	AsabgFk3HjLPP10N/3cb0F4/pnyjBmyfndH4rEyrbmLzgcjCpbjIaKMxWomTZpITfsmXTp
	/A1q4+DoUaLmHA5FmUzymD8Vy7qzREM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-fkkY4AkYN-ySTkgU7xJWRQ-1; Thu, 25 Aug 2022 10:15:16 -0400
X-MC-Unique: fkkY4AkYN-ySTkgU7xJWRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D4D31C08975;
	Thu, 25 Aug 2022 14:15:16 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 64ABD40D282E;
	Thu, 25 Aug 2022 14:15:08 +0000 (UTC)
Date: Thu, 25 Aug 2022 22:15:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-pci: don't wait freeze during resetting
Message-ID: <YweD7HkrNeiivHZO@T590>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-3-ming.lei@redhat.com>
 <fcd5d4c6-b803-db9f-a00c-abfe7365f364@huawei.com>
 <YwdeRgU4YsZEGz8J@T590>
 <Ywd8VLKPmDS7QmBu@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <Ywd8VLKPmDS7QmBu@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_071528_850719_F690917E 
X-CRM114-Status: GOOD (  28.64  )
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

On Thu, Aug 25, 2022 at 07:42:44AM -0600, Keith Busch wrote:
> On Thu, Aug 25, 2022 at 07:34:30PM +0800, Ming Lei wrote:
> > On Thu, Aug 25, 2022 at 06:05:30PM +0800, Chao Leng wrote:
> > > 
> > > 
> > > On 2022/8/21 16:47, Ming Lei wrote:
> > > > First it isn't necessary to call nvme_wait_freeze in nvme_reset_work().
> > > > If tagset isn't allocated, there can't be any inflight IOs; otherwise
> > > > blk_mq_update_nr_hw_queues can freeze & wait queues.
> > > > 
> > > > Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
> > > > while requests are in progress"), it is fine to unfreeze queue without
> > > > draining inflight IOs.
> > > > 
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >   drivers/nvme/host/pci.c | 1 -
> > > >   1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > index 3a1c37f32f30..91b2903fcc24 100644
> > > > --- a/drivers/nvme/host/pci.c
> > > > +++ b/drivers/nvme/host/pci.c
> > > > @@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
> > > >   		nvme_free_tagset(dev);
> > > >   	} else {
> > > >   		nvme_start_queues(&dev->ctrl);
> > > > -		nvme_wait_freeze(&dev->ctrl);
> > > It is not safe.
> > > nvme_dev_add may call blk_mq_update_nr_hw_queues, blk_mq_update_nr_hw_queues
> > > require the state is frozen.
> > 
> > blk_mq_update_nr_hw_queues() calls blk_freeze_queue() for every queue in
> > this tagset, so it needn't nvme's freeze wait.
> 
> Right, the blk-mq realloc should be fine, and it's really a very uncommon event
> that nvme needs to realloc the tag set.
> 
> I'm trying to remember why I added the wait freeze here in the first place, and
> I don't recall a good reason for it. I think I had a controller that always
> timed out IO, and the resets would just continue indefinitely. Waiting for
> freeze within a reset causes the next IO timeout to trigger a driver detach.
> That doesn't sound like a good idea, though, since it tears down the admin
> queue too.

The wait becomes not necessary since commit bdd6316094e0 ("block: Allow unfreezing
of a queue while requests are in progress").


Thanks,
Ming


