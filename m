Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC46CCD19A
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Nov 2025 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzuMA0HqLv22fL5ouW8cGieDtH/YoU81WKUNJmbycJ0=; b=3gJvsTy8P4/5dW5E7YhBcsCMMo
	jr6zYAlyuJkddr4NB/UCmghLLDxnFGmZU/gZovP8k0/g7iATGmODWIxSaFvGDsU0mDSfoR8mPiPqm
	jiNC8Bm9Wjg5wI9+qnKcrIhEkTH3LwXWn/K2bZjd9FafxVKLlJsUgGJli4Eyv1d2c+T9NtwJMNp+J
	dNVJo1EAK21/vBjBkkIzeLKZ3ZNf7Em6hMK9eSh4gmsXUOBhQQhMH+dAarNE2g9mA71BdgsfKjrHa
	+GXPyAqD6Ra2+B/7Ch/5yd47jvJS242+fBr275iFwnSfiNJhCsX4TV8PgZlpYecHaDArnFeJXefRS
	m5xNHELw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKftK-0000000EsOz-3eie;
	Sun, 16 Nov 2025 16:46:18 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKftD-0000000EsNh-34O5
	for linux-nvme@lists.infradead.org;
	Sun, 16 Nov 2025 16:46:13 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2402524a12.3
        for <linux-nvme@lists.infradead.org>; Sun, 16 Nov 2025 08:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763311569; x=1763916369; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzuMA0HqLv22fL5ouW8cGieDtH/YoU81WKUNJmbycJ0=;
        b=gymHoAc8hPRj0pjLOmc6KTPkpZz92J8S6jfAOOC09DyD6fXvItH2DQxiyzBKuRc4Ch
         l7w3nbC7yOgG7a0IKOtYkGLt/mNF3NGeV02p0V8nBY321UqDKmrcRNX8Ac8oyT/s/6CL
         gWb9ntnbIjIqtnwlxIg+tln7p5XRJJxQ8bAAB3JthepOTu9yLJnD8YZDBCFpEMWZ8HuB
         ELVIx2+gyAaVu+55OFL1rf2GOiL7e62P+XNfEC8O8GMzZrfiS1vmh8omkYfU5F0EXYOV
         aB0b41NQJDbSCDv8uPWLBHiGfZhWMB798/0+QAO10BsIyHLo5fIT2qSNeyfV0Y3cR7a/
         32BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763311569; x=1763916369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzuMA0HqLv22fL5ouW8cGieDtH/YoU81WKUNJmbycJ0=;
        b=jlhrYYxvEUnlAROuMSt4hqHxAGWUtK2SC1G0GvZnvexdOvfWhN4nQ5QxQFrvMDESyS
         QS2rwtGmJANshfd4lmBvrk8mAnj3NyXxXEK60n1tkphJ/W/0IgvhuzMS8Gc164izOzrh
         v18XYVUEbRW3XD8KWvsckv4+jzuWl3Cmrd5S//wiXQ0L1LPQSrCVikm8VPDqW5KDTUWY
         UDHsRlv9Tuq5gd3q5taa/XqaVZAm8gL4BNiefQ5L5HN5xEoJpOblIiNEH+clBg6OHpXo
         2trHJ+q0zVlNbYm+qgkqrln7gkrS1tRG7UWN9BwwYrLVpZ06EB45fGn+V+Sf5nTpp2y1
         l3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4Omg0DPrVcZH9H3Oma1jGy3i5Ut/vgRqCo5Rut+cc47DlEXiu4PTB4lJ8LMqTov3ef0NHNg1uF3i@lists.infradead.org
X-Gm-Message-State: AOJu0YwuLQDiveqVYGPpbETHNi0YkkuYrHb56nK26NI7oKGx2vHerXhL
	DtxxSaaL9YS+v5ZJ/xtqMSWZGhsGob2tpsSkA4+2IjpRA7pwNX09RnOwaOLsVhR++Yw=
X-Gm-Gg: ASbGncsO/3Yz1fcTkLUMX8xlBe1BU6Nh01q4YTsJFYA7NbgP7+nMH9n3VKsVqqTNvT8
	GWA9IDCsh79TEiVNIHpxbNirTLkL3Wjaa0LvvMH8M3BCk7ixuhUkT6OzJNLkgOZF6bb4B7guI83
	lvhrYLQTx53UMnUladgxDC5a5HwKdx3v4KWvR1iPeKIwb0ZzeMaUbscwM2RiZ3YsXWfIuAZXBOo
	8tVjoaVKci+cLpz2Or0qvJQBvQgJ7lZW2FLwODpwD5al1aGAzsqYrbMHT+0GXzfXOvelwfp/fKB
	HVSt4nZCPo1uUAflDsr4nDK28vZcRfUD3WT3boolxJYncX5tx0/fyFPGz7YDoBXVMhnzInFVN4x
	zBPFXnVjMrft2NTjd9pmRjyLBPsqzvDEGYgqQqY5bllUSlrD337J3dSmgHSlJRinigp1Gq3kFvX
	BWShOC5ocbU2cP4aYCQ3Bj/kLDg6E=
X-Google-Smtp-Source: AGHT+IE5rrGbiwByjHLuKq7S9q5r3YznMONfkuzETCp/ON+jIpJvE4l43Yh/uyxNLb5/9bCltvKINQ==
X-Received: by 2002:a05:7022:ff42:b0:11b:c1ab:bdd0 with SMTP id a92af1059eb24-11bc1abbed3mr1532024c88.35.1763311568872;
        Sun, 16 Nov 2025 08:46:08 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::f013])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-11b060885e3sm37082181c88.0.2025.11.16.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 08:46:08 -0800 (PST)
Date: Sun, 16 Nov 2025 08:46:06 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
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
Message-ID: <20251116164606.GA2376676-mkhalfella@purestorage.com>
References: <20251113202320.2530531-1-mkhalfella@purestorage.com>
 <aRcVWtE4fHCe3jjM@fedora>
 <20251114173419.GA2197103-mkhalfella@purestorage.com>
 <aRnqmiFmWAI01zJq@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRnqmiFmWAI01zJq@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_084611_963107_4C213B3F 
X-CRM114-Status: GOOD (  38.56  )
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

On Sun 2025-11-16 23:15:38 +0800, Ming Lei wrote:
> On Fri, Nov 14, 2025 at 09:34:19AM -0800, Mohamed Khalfella wrote:
> > On Fri 2025-11-14 19:41:14 +0800, Ming Lei wrote:
> > > On Thu, Nov 13, 2025 at 12:23:20PM -0800, Mohamed Khalfella wrote:
> > > > blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> > > > tagset, the functions make sure that tagset and queues are marked as
> > > > shared when two or more queues are attached to the same tagset.
> > > > Initially a tagset starts as unshared and when the number of added
> > > > queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> > > > with all the queues attached to it. When the number of attached queues
> > > > drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> > > > the remaining queues as unshared.
> > > > 
> > > > Both functions need to freeze current queues in tagset before setting on
> > > > unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> > > > hold set->tag_list_lock mutex, which makes sense as we do not want
> > > > queues to be added or deleted in the process. This used to work fine
> > > > until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > > > made the nvme driver quiesce tagset instead of quiscing individual
> > > > queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> > > > set->tag_list while holding set->tag_list_lock also.
> > > > 
> > > > This results in deadlock between two threads with these stacktraces:
> > > > 
> > > >   __schedule+0x48e/0xed0
> > > >   schedule+0x5a/0xc0
> > > >   schedule_preempt_disabled+0x11/0x20
> > > >   __mutex_lock.constprop.0+0x3cc/0x760
> > > >   blk_mq_quiesce_tagset+0x26/0xd0
> > > >   nvme_dev_disable_locked+0x77/0x280 [nvme]
> > > >   nvme_timeout+0x268/0x320 [nvme]
> > > >   blk_mq_handle_expired+0x5d/0x90
> > > >   bt_iter+0x7e/0x90
> > > >   blk_mq_queue_tag_busy_iter+0x2b2/0x590
> > > >   ? __blk_mq_complete_request_remote+0x10/0x10
> > > >   ? __blk_mq_complete_request_remote+0x10/0x10
> > > >   blk_mq_timeout_work+0x15b/0x1a0
> > > >   process_one_work+0x133/0x2f0
> > > >   ? mod_delayed_work_on+0x90/0x90
> > > >   worker_thread+0x2ec/0x400
> > > >   ? mod_delayed_work_on+0x90/0x90
> > > >   kthread+0xe2/0x110
> > > >   ? kthread_complete_and_exit+0x20/0x20
> > > >   ret_from_fork+0x2d/0x50
> > > >   ? kthread_complete_and_exit+0x20/0x20
> > > >   ret_from_fork_asm+0x11/0x20
> > > > 
> > > >   __schedule+0x48e/0xed0
> > > >   schedule+0x5a/0xc0
> > > >   blk_mq_freeze_queue_wait+0x62/0x90
> > > >   ? destroy_sched_domains_rcu+0x30/0x30
> > > >   blk_mq_exit_queue+0x151/0x180
> > > >   disk_release+0xe3/0xf0
> > > >   device_release+0x31/0x90
> > > >   kobject_put+0x6d/0x180
> > > >   nvme_scan_ns+0x858/0xc90 [nvme_core]
> > > >   ? nvme_scan_work+0x281/0x560 [nvme_core]
> > > >   nvme_scan_work+0x281/0x560 [nvme_core]
> > > >   process_one_work+0x133/0x2f0
> > > >   ? mod_delayed_work_on+0x90/0x90
> > > >   worker_thread+0x2ec/0x400
> > > >   ? mod_delayed_work_on+0x90/0x90
> > > >   kthread+0xe2/0x110
> > > >   ? kthread_complete_and_exit+0x20/0x20
> > > >   ret_from_fork+0x2d/0x50
> > > >   ? kthread_complete_and_exit+0x20/0x20
> > > >   ret_from_fork_asm+0x11/0x20
> > > 
> > > It is one AB-BA deadlock, lockdep should have complained it, but nvme doesn't
> > > support owned freeze queue.
> > > 
> > > Maybe the following change can avoid it?
> > > 
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index c916176bd9f0..9967c4a7e72d 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -3004,6 +3004,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> > >         bool dead;
> > > 
> > >         mutex_lock(&dev->shutdown_lock);
> > > +       nvme_quiesce_io_queues(&dev->ctrl);
> > >         dead = nvme_pci_ctrl_is_dead(dev);
> > >         if (state == NVME_CTRL_LIVE || state == NVME_CTRL_RESETTING) {
> > >                 if (pci_is_enabled(pdev))
> > > @@ -3016,8 +3017,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> > >                         nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> > >         }
> > > 
> > > -       nvme_quiesce_io_queues(&dev->ctrl);
> > > -
> > >         if (!dead && dev->ctrl.queue_count > 0) {
> > >                 nvme_delete_io_queues(dev);
> > >                 nvme_disable_ctrl(&dev->ctrl, shutdown);
> > > 
> > > 
> > 
> > Interesting. Can you elaborate more on why this diff can help us avoid
> > the problem?
> 
> In nvme_dev_disable(), NS queues are frozen first, then call
> nvme_quiesce_io_queues().
> 
> queue freeze can be thought as one lock, so q->freeze_lock -> tag_set->tag_list_lock
> in timeout code path.
> 
> However, in blk_mq_exit_queue(), the lock order becomes
> tag_set->tag_list_lock -> q->freeze_lock.
> 
> That is why I call it AB-BA lock.
> 
> However, that looks not the reason in your deadlock, so my patch shouldn't
> work here, in which nvme_dev_disable() doesn't provide forward-progress
> because of ->tag_list_lock.
> 
> > 
> > If the thread doing nvme_scan_work() is waiting for queue to be frozen
> > while holding set->tag_list_lock, then nvme_quiesce_io_queues() moved up
> > will cause the deadlock, no?
> 
>  __schedule+0x48e/0xed0
>   schedule+0x5a/0xc0
>   blk_mq_freeze_queue_wait+0x62/0x90
>   ? destroy_sched_domains_rcu+0x30/0x30
>   blk_mq_exit_queue+0x151/0x180
>   disk_release+0xe3/0xf0
>   device_release+0x31/0x90
>   kobject_put+0x6d/0x180
> 
> Here blk_mq_exit_queue() is called from disk release, and the disk is not
> added actually, so question is why blk_mq_freeze_queue_wait() doesn't
> return? Who holds queue usage counter here?  Can you investigate a bit
> and figure out the reason?

The nvme controller has two namespaces. n1 was created with q1 added to
the tagset. n2 was also created with q2 added to the tagset. Now the
tagset is shared because it has two queues on it. Before the disk is
added n2 was found to be duplicate to n1. That means the disk should be
released, as noted above, and q2 should be removed from the tagset.
Because n1 block device is ready to receive IO it is possible for q1
usage counter to be greater than zero.

Back to q2 removal from the tagset. This requires q1 to be frozen before
it can be marked as unshared. blk_mq_freeze_queue_wait() was called for
q1 and it does not return because there is a request issued on the queue.
nvme_timeout() was called for that request in q1.

> 
> For one released NS/disk, no one should grab the queue usage counter,
> right?

Right. The disk is not visible yet.

> 
> 
> Thanks,
> Ming
> 

