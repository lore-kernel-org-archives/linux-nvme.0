Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8054CFD318
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WppdyCSciz9HWrs/hR0oDV7k3a6Trk+vQz3os79KrFw=; b=B24CxjlZPlKRFOo3zp+L1jZxgk
	RlSQ4WEwba/hZnW6eiPRyv8J37FE3QpGJa8vVebYOcAKsZ81DE2YcDa9aSuyBG6XjA+j/PmoSp5oP
	0wAqY9S2rq3uP1ddTgf99bHmenFXw0455yen48vI5Z6ib8z7ASycBGsgIZV8OIKczG1zTCO2TvZ6G
	GMUPeipkQefCw51R9YrVl6+a1Az/nzVQ/ZNf8jIlUwttFtvGhBlAcSihYmKYp6FceLXwPkc5XVKKC
	IM2v084cC9eUHVVLXV1K1G91Mo0go6hL2icK1drgEWm+cFm2a+/JVpvoRo7aRO9XViGMgKHvqEPzk
	Z0lp+etA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNaZt-0000000C7Q1-18Se;
	Mon, 24 Nov 2025 17:42:17 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNaZq-0000000C7PV-2geE
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 17:42:16 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-bc4b952cc9dso4184184a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 09:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764006133; x=1764610933; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WppdyCSciz9HWrs/hR0oDV7k3a6Trk+vQz3os79KrFw=;
        b=c2OHATqgehSTIARCIIQGJbjLgLeCOJNnuKH1NtuZfLbpjBENNtCniDOwai54ThVhw5
         FvTeW1OP+ndzJZ+5t9javMkQ0HcVKTShEfaaOWw5ONnlUN8oVd1VL37+GhFhGkMZuojr
         l+Cgj9IO3kxHpVd/flwu04TqFbEEld1mByS1NeWO2YimVO0Z63e7yYr+Jmbdbuu7V4qZ
         aKEaAuSPxNxJPjEGriMgZT0ZeAQHzmXL0HjY9/ItCx5wtC6JhKQc2if+eWEb8eLVTqLV
         UpvW8Fdaoa+JrJwWvb4mseH96r7NuyiCUP0m7l7rl2S7+svTmQ5lOwR/MTcB15GaFgjw
         EJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006133; x=1764610933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WppdyCSciz9HWrs/hR0oDV7k3a6Trk+vQz3os79KrFw=;
        b=gJo4dlpuNfdcTafA33DqpDpCa1WWwFmAaSOoGF2pj29ObLE3cdxp1jYOi+1ZQc+m9q
         /cbXtqU+rW1TUI1S1/Lf6tIGnBjUmA2Ly6bC+31OPUOsVSUc/YrWMJORdLJWT+k6Em41
         9ElbmJNP9Is0q6TXNloYUb6kuLVQL8YU9XAdt/58OUW9wmwNVNI6rNtsLYl0RbwqVpUw
         K69ZiMsqpHL9D9rr023Uizc0w4i/JUevYl5YQNSkcFALuflFNXSMU/mjTshMW94Nv3/x
         SQ3uh6zUS4NEzzS8ze/iwE3VRdqWkwtexsDeBKMZsrWmSlSVf9oiZV7NQnX26LdZCALA
         zgeA==
X-Forwarded-Encrypted: i=1; AJvYcCVVH+IpEpxRPFxuNRe8E49Tb3JhYANTZVctk2dVlnDKe66eTNdcbTUAeVNhgoyz1WQkCuNIeVzoVfpR@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7oTeXkbZFhfTvGITJQUuRLoPUnpgj4IJZkVIvLuF5/qkU7uJR
	zLMaEkMEcw9f/b/JhfrhyrTfaVTrVE8IIKVo4lAQrRi6yhiwAreCiDYHiyc1AfnKZt7kiCMNxum
	fnZZ+
X-Gm-Gg: ASbGncupBnngt1309cFLhdQaz7RN/ch4ALeXUmRq6kxGM+I1S1tZsqa6ww7i6E/10h0
	CrYAQss8Z0rhejZ9uPrRyRhYcjNkKChgiF3ek+744xv5ZLPbNiwG005YlJA8duE4xrdaDRTAgaf
	x3BRMvNmwonVJk5TlJxyqe5EQK83pp+QR2zHfgeHCypekF1WFOGJd6V4Vw5wE2JUqUNRHXOy2/4
	LByVOP9NeOY5drL3uQMzsuNy62IQcuIsmSeaK+neJJNtSMt55hF/8RfW7l1ruknT++So4QNBLWS
	a8eQP8xR7/1Y+9jc/2hvQcOKWR5HLnYSWNj32paYwUFeYz9auixu5eCzfujC1J00iWdpxSMo7x0
	+XKjt9UDolKnIA4GYxzDsm0z/uiyFgij6757WVb5qRVW6X8CStbG5cMt1XDw3hUa8UvEF9UeMO9
	KV3rzIkvEENO/92LxuJL4FXPhrjspwPXE=
X-Google-Smtp-Source: AGHT+IG5QYOBjAVVFMK45Nvn6OfeThSH9HuJ61Oz7/6lURBggYPzYHBApxq+nzxrdnDicnCGqIRYGA==
X-Received: by 2002:a05:7300:320b:b0:2a4:5028:3433 with SMTP id 5a478bee46e88-2a719fb6c72mr8386858eec.34.1764006133064;
        Mon, 24 Nov 2025 09:42:13 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2a6fc3d0bb6sm75866424eec.2.2025.11.24.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 09:42:12 -0800 (PST)
Date: Mon, 24 Nov 2025 09:42:11 -0800
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
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
Message-ID: <20251124174211.GQ337106-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
 <aSPYT6JuQLCE3E7K@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSPYT6JuQLCE3E7K@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_094214_745746_AB163FBA 
X-CRM114-Status: GOOD (  40.80  )
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

On Mon 2025-11-24 12:00:15 +0800, Ming Lei wrote:
> On Mon, Nov 17, 2025 at 12:23:53PM -0800, Mohamed Khalfella wrote:
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
> > 
> > The top stacktrace is showing nvme_timeout() called to handle nvme
> > command timeout. timeout handler is trying to disable the controller and
> > as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> > to call queue callback handlers. The thread is stuck waiting for
> > set->tag_list_lock as it tires to walk the queues in set->tag_list.
> > 
> > The lock is held by the second thread in the bottom stack which is
> > waiting for one of queues to be frozen. The queue usage counter will
> > drop to zero after nvme_timeout() finishes, and this will not happen
> > because the thread will wait for this mutex forever.
> > 
> > Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
> > avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
> > semaphore for read since this is enough to guarantee no queues will be
> > added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
> > semaphore for write while updating set->tag_list and downgrade it to
> > read while freezing the queues. It should be safe to update set->flags
> > and hctx->flags while holding the semaphore for read since the queues
> > are already frozen.
> > 
> > Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 

Sorry, I was supposed to reply to this thread eariler. The concern
raised about potential deadlock in set->tag_list_rwsem caused by writer
blocking readers makes this approach buggy. The way I understood it is
that rw_semaphore have this writer starvation prevention mechanism.
If a writer is waiting for the semaphore to be available then readers
that come after the waiting writer will not be able to take the semphore.
Even if it is available for reader. If we rely on the readers to do
something to make the semaphore available for the waiting writer then
this is a deadlock. This change relies on the reader to cancel inflight
requests so that queue usage counter drops to zero and queue is fully
frozen. Only then semphore will be available for the waiting writer.
This results in a deadlock between three threads.

To put it in another way blk_mq_del_queue_tag_set() downgrades the
semaphore and waits for the queue to be frozen. If another call to
blk_mq_del_queue_tag_set() happens from another thread, before
blk_mq_quiesce_tagset() comes in, it will cause a deadlock. The second
call to blk_mq_del_queue_tag_set() is a writer and it will wait
until the semaphore is available. blk_mq_quiesce_tagset() is a reader
that comes after a waiting writer. Eventhough the semaphore is available
for readers blk_mq_quiesce_tagset() will not be able to take it because
of the writer starvation prevention mechanism. The first thread that is
waiting for queue to be frozen in blk_mq_del_queue_tag_set() will not be
able to make progress because of inflight requests. The second writer
thread waiting for the semphore on blk_mq_del_queue_tag_set() will not
be able to make progress because the semaphore is not availble. The
thread calling blk_mq_quiesce_tagset() will not be able to make progress
because it is blocked behind the writer (second thread).

Commit 4e893ca81170 ("nvme_core: scan namespaces asynchronously") makes
this scenario more likely to happen. If a controller has a namespace
that is duplicate three times then it is possible to hit this deadlock.

I was thinking about use RCU to protect set->tag_list but never had a
chance to write the code and test it. I hope I will find time in the coming
few days.

Thanks,
Mohamed Khalfella

