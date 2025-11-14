Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB75CCE8D5F
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cxEoFbzQwfAmuQdYnQsCZazVU2iXkrM1iusny5D0ajU=; b=A0RyTLIyyXh7F+VmD5qHqYw/rQ
	1HZye16qn2okKMtDrVGI1CsC2eSNTqh00WDWd4fQrbcVyXN2Wcvrn9J3KRqYAMbilcSJvMDBmviYs
	/9JZ65SCrXQK9GXxds81htykOK9n2mQDgP7DmejbmBeXpKahg03y6yiqaqajMgwqGNWOjHYroU1Kq
	KajR5N8eWRdk7j+HFOWn4CJNSQ0NtOqt2aVJ8tYNoFm6GbssjeDO9lTUkYQpyAvirwxaovXd5Dlhe
	aXwQpVZaTTT47RXtPbCmC85HRPeQzTdH6rs9llBM/VSrhLEIPsjBqN68/fqG2lm0x9SzIVz14KAXg
	pS05UGtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxgn-0000000Cr7f-2Kl8;
	Fri, 14 Nov 2025 17:34:25 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxgk-0000000Cr6l-0xMY
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 17:34:23 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so1554581b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 14 Nov 2025 09:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763141661; x=1763746461; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxEoFbzQwfAmuQdYnQsCZazVU2iXkrM1iusny5D0ajU=;
        b=PeNu/fQ48Zpl6HIEikQOZoGOEWMCn8xfq7uphFDK9OxiUx601EePWsCLRoDSXawXzL
         cSyGPeI8ZZjk1eqDukDVDIEfWxT4phh+GK0XuuyXpAAwSRTOk2AcHyrYZJIoYgCVcJVH
         AiapKJe+s0xr6m+U8ayR8H6Bgh4vrCXFCjJy/epxL8fOIaQkRg7qLh2M+vSeJdlA+1+2
         6r0BUW8qBfQXCSQmvOGd2z7inok2lGxDu8+OeovXKDrzkaX5pFdx0ZqGA2okc+uE3dd2
         3sKjIQmLuKd48sqRhaakwpvyB3k8Rpwkjwm3EhScBUGOieE2pIZntWedvAzOmovts7Xl
         RGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763141661; x=1763746461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxEoFbzQwfAmuQdYnQsCZazVU2iXkrM1iusny5D0ajU=;
        b=BJVLs1/KJO0Kpdax8r+fxGDT7cJTR+lp9tWWftqfpTYlAJa2J4IFgHaWpirxBKeA7N
         +RtyAbHmcJeVHO8x3YzxKeHzChUPZkxQt11lGEU+pFyHiHZjOUa1QJ0j0F4kDgU1OHjS
         dhOfv9Qz+Upim6Ef42jM1onTZuMNy2B18wFGbcKwgrTB/0lX06w4t4q8jcd0jdf8uB1D
         rLp4Z8jMg/fsVhyRP8fsLVl5N6hhB5FT6vVgzFyDOjBN1I+tm/1QclK+P//QZncRbgG7
         vwGFOUwpKlOZzDaLVPnpNsiPQKFHyNg8TTXQgTDRVM5bVqT86X529NhsJ1JP+hs9RVOj
         0gvg==
X-Forwarded-Encrypted: i=1; AJvYcCXU3wqb4wE4Cit12a/vYs2l3ruK2h2ZF20JLkjL4VrQY1+fmljiNm4j9L5dJKOKEZBmLhNLjuiSlYqU@lists.infradead.org
X-Gm-Message-State: AOJu0YyeK8ECsAycwUNTTqW6kSoy9CtyNtk7LFvyjAJGj2dUqejx+OeA
	2b4bEQZnwKCDm6crLyUIrfpXyrP5S2MLsuH/G6jHoumNy+ICmNuVzSAmYm4LTE3HnOo=
X-Gm-Gg: ASbGncvWhh4jKPI6T6rOkHerqF1Xp4WPKOXBP60RUtJV9OnaNVNEF7x5L0bzMADqqgo
	SxAQv/rJZD8qsA6GcZ1q8ffQ7K54KqCM/5Jdn9rvvFHp/gExfOxtbnkU8bpQ5gwCQKRCt3Yd8bb
	AZ45EEMwPKB/evCcbcthtKcZylHoVJ+UnO1OO/KeHRBBcbK/8Dl2R24Zi3f2xrCyGPodkaNDJwM
	I+iBnBbR5eQceJvg8MK/ahTa3R2q79Ssfm5SEcQ9ktygMfEVUNpLAE3sC1rqIV0odPOQHcvkyi4
	PHTs2zdNYEtiAgJ3mbumEMzilKwYJYvrpZFBjV4Vbef+6XFW2RvkvSz0weu6EHITHhYiVRCAxTZ
	NqpUNM0PWpVXnI2A4Km331EkeScro4TKXgDJZyhi5wnB9J6PT+a+ayj4eLY9UEzS2F6pzp5lh63
	7Knhel8z5pwJDf4fc/TGmHlSfwM88D4uxtv4ClLzIyXg==
X-Google-Smtp-Source: AGHT+IHDaJWCuyrcAQ7bh/F0PTreqc48q+/8A87q7fLc4R6puX9/rJVN4MbbzRVHyhCNNkpaJDzXLQ==
X-Received: by 2002:a05:7022:619e:b0:11b:38c:5370 with SMTP id a92af1059eb24-11b411ff1c3mr1214091c88.20.1763141660782;
        Fri, 14 Nov 2025 09:34:20 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-11b06088604sm12363461c88.7.2025.11.14.09.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:34:20 -0800 (PST)
Date: Fri, 14 Nov 2025 09:34:19 -0800
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
Message-ID: <20251114173419.GA2197103-mkhalfella@purestorage.com>
References: <20251113202320.2530531-1-mkhalfella@purestorage.com>
 <aRcVWtE4fHCe3jjM@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRcVWtE4fHCe3jjM@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_093422_316988_E6096DB9 
X-CRM114-Status: GOOD (  26.57  )
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

On Fri 2025-11-14 19:41:14 +0800, Ming Lei wrote:
> On Thu, Nov 13, 2025 at 12:23:20PM -0800, Mohamed Khalfella wrote:
> > blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> > tagset, the functions make sure that tagset and queues are marked as
> > shared when two or more queues are attached to the same tagset.
> > Initially a tagset starts as unshared and when the number of added
> > queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> > with all the queues attached to it. When the number of attached queues
> > drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> > the remaining queues as unshared.
> > 
> > Both functions need to freeze current queues in tagset before setting on
> > unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> > hold set->tag_list_lock mutex, which makes sense as we do not want
> > queues to be added or deleted in the process. This used to work fine
> > until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > made the nvme driver quiesce tagset instead of quiscing individual
> > queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> > set->tag_list while holding set->tag_list_lock also.
> > 
> > This results in deadlock between two threads with these stacktraces:
> > 
> >   __schedule+0x48e/0xed0
> >   schedule+0x5a/0xc0
> >   schedule_preempt_disabled+0x11/0x20
> >   __mutex_lock.constprop.0+0x3cc/0x760
> >   blk_mq_quiesce_tagset+0x26/0xd0
> >   nvme_dev_disable_locked+0x77/0x280 [nvme]
> >   nvme_timeout+0x268/0x320 [nvme]
> >   blk_mq_handle_expired+0x5d/0x90
> >   bt_iter+0x7e/0x90
> >   blk_mq_queue_tag_busy_iter+0x2b2/0x590
> >   ? __blk_mq_complete_request_remote+0x10/0x10
> >   ? __blk_mq_complete_request_remote+0x10/0x10
> >   blk_mq_timeout_work+0x15b/0x1a0
> >   process_one_work+0x133/0x2f0
> >   ? mod_delayed_work_on+0x90/0x90
> >   worker_thread+0x2ec/0x400
> >   ? mod_delayed_work_on+0x90/0x90
> >   kthread+0xe2/0x110
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork+0x2d/0x50
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork_asm+0x11/0x20
> > 
> >   __schedule+0x48e/0xed0
> >   schedule+0x5a/0xc0
> >   blk_mq_freeze_queue_wait+0x62/0x90
> >   ? destroy_sched_domains_rcu+0x30/0x30
> >   blk_mq_exit_queue+0x151/0x180
> >   disk_release+0xe3/0xf0
> >   device_release+0x31/0x90
> >   kobject_put+0x6d/0x180
> >   nvme_scan_ns+0x858/0xc90 [nvme_core]
> >   ? nvme_scan_work+0x281/0x560 [nvme_core]
> >   nvme_scan_work+0x281/0x560 [nvme_core]
> >   process_one_work+0x133/0x2f0
> >   ? mod_delayed_work_on+0x90/0x90
> >   worker_thread+0x2ec/0x400
> >   ? mod_delayed_work_on+0x90/0x90
> >   kthread+0xe2/0x110
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork+0x2d/0x50
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork_asm+0x11/0x20
> 
> It is one AB-BA deadlock, lockdep should have complained it, but nvme doesn't
> support owned freeze queue.
> 
> Maybe the following change can avoid it?
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c916176bd9f0..9967c4a7e72d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3004,6 +3004,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>         bool dead;
> 
>         mutex_lock(&dev->shutdown_lock);
> +       nvme_quiesce_io_queues(&dev->ctrl);
>         dead = nvme_pci_ctrl_is_dead(dev);
>         if (state == NVME_CTRL_LIVE || state == NVME_CTRL_RESETTING) {
>                 if (pci_is_enabled(pdev))
> @@ -3016,8 +3017,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>                         nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
>         }
> 
> -       nvme_quiesce_io_queues(&dev->ctrl);
> -
>         if (!dead && dev->ctrl.queue_count > 0) {
>                 nvme_delete_io_queues(dev);
>                 nvme_disable_ctrl(&dev->ctrl, shutdown);
> 
> 

Interesting. Can you elaborate more on why this diff can help us avoid
the problem?

If the thread doing nvme_scan_work() is waiting for queue to be frozen
while holding set->tag_list_lock, then nvme_quiesce_io_queues() moved up
will cause the deadlock, no?

