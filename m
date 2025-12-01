Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E69CFD376
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 01:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+vgIz0qJJ73Up1nOgLOtul9RSr+hF+oAG6PTtmAavvk=; b=UJ/7DBRH5Fy8my5O9LrdLWKalX
	52dzjV6XDuJJOZoJz/x1aZfCT9/0dg0AuEFWkWMCWGFnQvBfzqzuy1BHxZCDtObxqFKgERn8g/Vo4
	scRbGcOX1e7SxSB4ZLAgerGlEKyXNCzjTBxUqM9WDhEuVTG9oqw8uK/M8MSf1+MNfQ7oXIe6nwtXm
	csR+d9ETRGc4n7Wc0jorUuJRfkPkug4GrWoxAqHybELxzD1YqrBniU5tR52FriSWxytFU7EusFWQL
	yvld/5Y4sNEG7BRuUqFJoGJNeupNvuExxxoTg9eT3JXXeV/yhDTT4iQtW+YPJHvEla77bPHkykKFJ
	Zp3isrHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPsqU-00000002lPf-28Yr;
	Mon, 01 Dec 2025 01:36:54 +0000
Received: from smtp153-168.sina.com.cn ([61.135.153.168])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPsqO-00000002lOJ-43GH
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 01:36:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1764553009;
	bh=+vgIz0qJJ73Up1nOgLOtul9RSr+hF+oAG6PTtmAavvk=;
	h=From:Subject:Date:Message-ID;
	b=KMJyr/uLTuXoHTx2Z2Ff3L6tHHbzS4+WuaWRCVRj9aiNtjH40r0ge90oD+OzX6Xku
	 3NzzYq+gqg5Om3NLot1bI8+/r8csZBRZ4YlATXX6zRemdUj4yM1rOFoX5h0D4VaOdR
	 R4xjpUfZ/NKvwoYOkfAVmV/pGxC62eolkFShR5ag=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.33) with ESMTP
	id 692CF12200003BBF; Mon, 1 Dec 2025 09:36:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8601056685003
X-SMAIL-UIID: 6E223F8DF3E641E4A6AC076475F05C0C-20251201-093636-1
From: Hillf Danton <hdanton@sina.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to avoid deadlock
Date: Mon,  1 Dec 2025 09:36:23 +0800
Message-ID: <20251201013625.9583-1-hdanton@sina.com>
In-Reply-To: <20251124174211.GQ337106-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com> <20251117202414.4071380-2-mkhalfella@purestorage.com> <aSPYT6JuQLCE3E7K@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_173649_740496_8EBD5F63 
X-CRM114-Status: GOOD (  42.30  )
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

On Mon, 24 Nov 2025 09:42:11 -0800 Mohamed Khalfella wrote:
> On Mon 2025-11-24 12:00:15 +0800, Ming Lei wrote:
> > On Mon, Nov 17, 2025 at 12:23:53PM -0800, Mohamed Khalfella wrote:
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
> > > 
> > > The top stacktrace is showing nvme_timeout() called to handle nvme
> > > command timeout. timeout handler is trying to disable the controller and
> > > as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> > > to call queue callback handlers. The thread is stuck waiting for
> > > set->tag_list_lock as it tires to walk the queues in set->tag_list.
> > > 
> > > The lock is held by the second thread in the bottom stack which is
> > > waiting for one of queues to be frozen. The queue usage counter will
> > > drop to zero after nvme_timeout() finishes, and this will not happen
> > > because the thread will wait for this mutex forever.
> > > 
> > > Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
> > > avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
> > > semaphore for read since this is enough to guarantee no queues will be
> > > added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
> > > semaphore for write while updating set->tag_list and downgrade it to
> > > read while freezing the queues. It should be safe to update set->flags
> > > and hctx->flags while holding the semaphore for read since the queues
> > > are already frozen.
> > > 
> > > Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > 
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > 
> 
> Sorry, I was supposed to reply to this thread eariler. The concern
> raised about potential deadlock in set->tag_list_rwsem caused by writer
> blocking readers makes this approach buggy. The way I understood it is
> that rw_semaphore have this writer starvation prevention mechanism.
> If a writer is waiting for the semaphore to be available then readers
> that come after the waiting writer will not be able to take the semphore.
> Even if it is available for reader. If we rely on the readers to do
> something to make the semaphore available for the waiting writer then
> this is a deadlock. This change relies on the reader to cancel inflight
> requests so that queue usage counter drops to zero and queue is fully
> frozen. Only then semphore will be available for the waiting writer.
> This results in a deadlock between three threads.
> 
Sounds like you know more about rwsem than the reviewer now.

> To put it in another way blk_mq_del_queue_tag_set() downgrades the
> semaphore and waits for the queue to be frozen. If another call to
> blk_mq_del_queue_tag_set() happens from another thread, before
> blk_mq_quiesce_tagset() comes in, it will cause a deadlock. The second
> call to blk_mq_del_queue_tag_set() is a writer and it will wait
> until the semaphore is available. blk_mq_quiesce_tagset() is a reader
> that comes after a waiting writer. Eventhough the semaphore is available
> for readers blk_mq_quiesce_tagset() will not be able to take it because
> of the writer starvation prevention mechanism. The first thread that is
> waiting for queue to be frozen in blk_mq_del_queue_tag_set() will not be
> able to make progress because of inflight requests. The second writer
> thread waiting for the semphore on blk_mq_del_queue_tag_set() will not
> be able to make progress because the semaphore is not availble. The
> thread calling blk_mq_quiesce_tagset() will not be able to make progress
> because it is blocked behind the writer (second thread).
> 
> Commit 4e893ca81170 ("nvme_core: scan namespaces asynchronously") makes
> this scenario more likely to happen. If a controller has a namespace
> that is duplicate three times then it is possible to hit this deadlock.
> 
> I was thinking about use RCU to protect set->tag_list but never had a
> chance to write the code and test it. I hope I will find time in the coming
> few days.
> 
Break a leg.

	Hillf

> Thanks,
> Mohamed Khalfella

