Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8C8CCD19A
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Nov 2025 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jCA0mRluEu7yHcbycOTH07Aepgo2yRyPrsU4Nq7LElI=; b=x3WVCf4F89SPSCNIcOsj/BBWrf
	BWbeE6ocv5n/WMvxpQY9YEMI6MbKqHQKDg2+gX8lzlEy9x7KwtgjmeZuaqminkl1wO40IvFgwBkxy
	rJqt+mBdBZqz3irjZ/I8Y5RIeHTRq5o2BpFDGBGf14TR6Dve8P6FlLymeRgPDGrzBUZNZRU4DFGQJ
	uCwAwVukKfzhaNhNK4exhh2psM+9QMsNlkbyheyp9h1wzr++D7kDu++hNGn96gLyDdDVId2MAFVqH
	t3YeZI66w3HSwVtyZzdsAdSbMTM4jO2eHMpWpuAmVZwRHaD/8U3tIqeNHq+Wy7akuBH4xzjKGmu/F
	TMj34btg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKeU6-0000000EmG2-2UVA;
	Sun, 16 Nov 2025 15:16:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKeTz-0000000Em7o-01Ih
	for linux-nvme@lists.infradead.org;
	Sun, 16 Nov 2025 15:16:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763306159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jCA0mRluEu7yHcbycOTH07Aepgo2yRyPrsU4Nq7LElI=;
	b=cPwzmreRfG9Y0nVUThxyFYCayHz5Spn3XUssb8P2yya3Ddv9F79y1xWMc8YOoUVMk+ftG3
	PTZIG7zULTAAc3zerSXBaedZ6v0apE19N0NS6isyIJH5A4+mjMVqvEHRiznHaXGY1nq0nd
	o3u8SgJapJiTarYY7Wk7P+fYI/7JLuM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-2EVDif7JM261AY32m27aEg-1; Sun,
 16 Nov 2025 10:15:54 -0500
X-MC-Unique: 2EVDif7JM261AY32m27aEg-1
X-Mimecast-MFC-AGG-ID: 2EVDif7JM261AY32m27aEg_1763306153
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D06E18AB312;
	Sun, 16 Nov 2025 15:15:52 +0000 (UTC)
Received: from fedora (unknown [10.72.116.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17E3C1800451;
	Sun, 16 Nov 2025 15:15:43 +0000 (UTC)
Date: Sun, 16 Nov 2025 23:15:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Convert tag_list mutex to rwsemaphore to avoid
 deadlock
Message-ID: <aRnqmiFmWAI01zJq@fedora>
References: <20251113202320.2530531-1-mkhalfella@purestorage.com>
 <aRcVWtE4fHCe3jjM@fedora>
 <20251114173419.GA2197103-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114173419.GA2197103-mkhalfella@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_071603_311976_ABF5D25A 
X-CRM114-Status: GOOD (  29.45  )
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

On Fri, Nov 14, 2025 at 09:34:19AM -0800, Mohamed Khalfella wrote:
> On Fri 2025-11-14 19:41:14 +0800, Ming Lei wrote:
> > On Thu, Nov 13, 2025 at 12:23:20PM -0800, Mohamed Khalfella wrote:
> > > blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> > > tagset, the functions make sure that tagset and queues are marked as
> > > shared when two or more queues are attached to the same tagset.
> > > Initially a tagset starts as unshared and when the number of added
> > > queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> > > with all the queues attached to it. When the number of attached queues
> > > drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> > > the remaining queues as unshared.
> > > 
> > > Both functions need to freeze current queues in tagset before setting on
> > > unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> > > hold set->tag_list_lock mutex, which makes sense as we do not want
> > > queues to be added or deleted in the process. This used to work fine
> > > until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > > made the nvme driver quiesce tagset instead of quiscing individual
> > > queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> > > set->tag_list while holding set->tag_list_lock also.
> > > 
> > > This results in deadlock between two threads with these stacktraces:
> > > 
> > >   __schedule+0x48e/0xed0
> > >   schedule+0x5a/0xc0
> > >   schedule_preempt_disabled+0x11/0x20
> > >   __mutex_lock.constprop.0+0x3cc/0x760
> > >   blk_mq_quiesce_tagset+0x26/0xd0
> > >   nvme_dev_disable_locked+0x77/0x280 [nvme]
> > >   nvme_timeout+0x268/0x320 [nvme]
> > >   blk_mq_handle_expired+0x5d/0x90
> > >   bt_iter+0x7e/0x90
> > >   blk_mq_queue_tag_busy_iter+0x2b2/0x590
> > >   ? __blk_mq_complete_request_remote+0x10/0x10
> > >   ? __blk_mq_complete_request_remote+0x10/0x10
> > >   blk_mq_timeout_work+0x15b/0x1a0
> > >   process_one_work+0x133/0x2f0
> > >   ? mod_delayed_work_on+0x90/0x90
> > >   worker_thread+0x2ec/0x400
> > >   ? mod_delayed_work_on+0x90/0x90
> > >   kthread+0xe2/0x110
> > >   ? kthread_complete_and_exit+0x20/0x20
> > >   ret_from_fork+0x2d/0x50
> > >   ? kthread_complete_and_exit+0x20/0x20
> > >   ret_from_fork_asm+0x11/0x20
> > > 
> > >   __schedule+0x48e/0xed0
> > >   schedule+0x5a/0xc0
> > >   blk_mq_freeze_queue_wait+0x62/0x90
> > >   ? destroy_sched_domains_rcu+0x30/0x30
> > >   blk_mq_exit_queue+0x151/0x180
> > >   disk_release+0xe3/0xf0
> > >   device_release+0x31/0x90
> > >   kobject_put+0x6d/0x180
> > >   nvme_scan_ns+0x858/0xc90 [nvme_core]
> > >   ? nvme_scan_work+0x281/0x560 [nvme_core]
> > >   nvme_scan_work+0x281/0x560 [nvme_core]
> > >   process_one_work+0x133/0x2f0
> > >   ? mod_delayed_work_on+0x90/0x90
> > >   worker_thread+0x2ec/0x400
> > >   ? mod_delayed_work_on+0x90/0x90
> > >   kthread+0xe2/0x110
> > >   ? kthread_complete_and_exit+0x20/0x20
> > >   ret_from_fork+0x2d/0x50
> > >   ? kthread_complete_and_exit+0x20/0x20
> > >   ret_from_fork_asm+0x11/0x20
> > 
> > It is one AB-BA deadlock, lockdep should have complained it, but nvme doesn't
> > support owned freeze queue.
> > 
> > Maybe the following change can avoid it?
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index c916176bd9f0..9967c4a7e72d 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3004,6 +3004,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >         bool dead;
> > 
> >         mutex_lock(&dev->shutdown_lock);
> > +       nvme_quiesce_io_queues(&dev->ctrl);
> >         dead = nvme_pci_ctrl_is_dead(dev);
> >         if (state == NVME_CTRL_LIVE || state == NVME_CTRL_RESETTING) {
> >                 if (pci_is_enabled(pdev))
> > @@ -3016,8 +3017,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >                         nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> >         }
> > 
> > -       nvme_quiesce_io_queues(&dev->ctrl);
> > -
> >         if (!dead && dev->ctrl.queue_count > 0) {
> >                 nvme_delete_io_queues(dev);
> >                 nvme_disable_ctrl(&dev->ctrl, shutdown);
> > 
> > 
> 
> Interesting. Can you elaborate more on why this diff can help us avoid
> the problem?

In nvme_dev_disable(), NS queues are frozen first, then call
nvme_quiesce_io_queues().

queue freeze can be thought as one lock, so q->freeze_lock -> tag_set->tag_list_lock
in timeout code path.

However, in blk_mq_exit_queue(), the lock order becomes
tag_set->tag_list_lock -> q->freeze_lock.

That is why I call it AB-BA lock.

However, that looks not the reason in your deadlock, so my patch shouldn't
work here, in which nvme_dev_disable() doesn't provide forward-progress
because of ->tag_list_lock.

> 
> If the thread doing nvme_scan_work() is waiting for queue to be frozen
> while holding set->tag_list_lock, then nvme_quiesce_io_queues() moved up
> will cause the deadlock, no?

 __schedule+0x48e/0xed0
  schedule+0x5a/0xc0
  blk_mq_freeze_queue_wait+0x62/0x90
  ? destroy_sched_domains_rcu+0x30/0x30
  blk_mq_exit_queue+0x151/0x180
  disk_release+0xe3/0xf0
  device_release+0x31/0x90
  kobject_put+0x6d/0x180

Here blk_mq_exit_queue() is called from disk release, and the disk is not
added actually, so question is why blk_mq_freeze_queue_wait() doesn't
return? Who holds queue usage counter here?  Can you investigate a bit
and figure out the reason?

For one released NS/disk, no one should grab the queue usage counter,
right?


Thanks,
Ming


