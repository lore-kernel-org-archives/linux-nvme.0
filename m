Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB64CCCD19A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 05:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sZLeg1UrT3oGXBniJ/X/nMk1xNmDZWHjakADmKPx5fs=; b=WgTdDZSiWCNA42RNDtwW/GDTnS
	SS4Fz5eqGxluR23d02YWhCqn1AvWxmXZfBn+lNaqsZyd5WroWPx9c0sSCksdzKf88gFDEvkLT5oMK
	Z7CfPouqQMWz9CmzByaTqjpRXJJz9m7M7uM7XwGvM8u65JyrKX45SjIRkxgGYKfCzjTOpMds7Bn2y
	vt0XrZC4oYUJSxwLr1sQ3GX6wTEJoDWJCgR2fAn8lzlTqDKSMVHxMUDjTH8MX+Nkh1r0SSQpHxxjz
	UefU+Wcch8tRUOL8UpH8sfAsK0QWEFsL+vCUOZLocmCAJGoe0lsfhdadcdhZdPlgGAhx8XAaQtHEc
	Qj5Aemwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLDrd-0000000HOcJ-2wMY;
	Tue, 18 Nov 2025 05:02:49 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLDrb-0000000HOa1-2Rxz
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 05:02:49 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so3991770b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 21:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763442166; x=1764046966; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZLeg1UrT3oGXBniJ/X/nMk1xNmDZWHjakADmKPx5fs=;
        b=MIyvf54GOYyk/IEGcqmTKgcsRR67gWvGJpvIKVqrtyMUCtz7F7Q+YKmhohr8q/D8mz
         +gtE+G+Ub0blILNCBg32P8BcrxG/KoXpUlhXd8A1azEwoM1SqyncxlHzGhFqzoBExWVy
         y5taZvEH7PDrjqc6TM6/sSzlz3eVUhQMuYAvwF1DuiCpCYLLJvuHvk7sq/E1oJnH+jMa
         06Y+9BCL8wQWBtVyEHP1xB04P4RC8DGKHYmUAqC9rDwy/KTGzyc3MEB8EJMNDz1dphho
         Iq8NHxxWgaRfeU0jH75hJFQVX35jBpqs7jCcq3cwB1+Oz8dy4l7k3TB5b5gN+qxYcTxF
         qYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763442166; x=1764046966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZLeg1UrT3oGXBniJ/X/nMk1xNmDZWHjakADmKPx5fs=;
        b=pyCcg9hmSR2HfQsc/TThQNmn4gFiNK+1vcrRpvhHSQ032sHe3Y1kZDIurh/yrBzHbq
         ZaC6d9H4CR8LQyHBUCvk+2HeJXi1TgwEcWlvJ84ilswSaJPHEnjz2QhWyx3/Pn4jxa0l
         zoSQn4tSO+HWsAwxprlLRMYJCNJZl4WOfeUhdPE0AuScxKNyEpQEF7xRePCddWF/7Lwh
         T9GCaKX5QzYBZI0ogtgH1nDHbfm+MKu4BvovCo/+lve73Gh0jhgQ5xzmzfxvHPyO6Px8
         XjsvlMlj49PQU0xKmzP7MZLsxd3dA4MwISOh8hgtenxJxOzTSNbyCDufMqNoGiAsR+QS
         Rhng==
X-Forwarded-Encrypted: i=1; AJvYcCXXeu+OCXpva+VzoOVTr3XKy+0+g8zV4j0n4kv/vzzyAgtiVrm7lFgapoyp4C5QBYUEggCRCGkKUTjr@lists.infradead.org
X-Gm-Message-State: AOJu0YxnzypxfeRjP64blyB7/HExwNBuMAQ0TwiBDvmYKrBdwMeDGeoT
	qMwFF6yuVUfgpH4WFrDTISX/9fFdRGRKc/JTL6bJMcCXPDsQOCuwMkYAyzauKBGJQpY=
X-Gm-Gg: ASbGnctumZgQ2JA1Y+Lj5WyvvztE5ycuxu4EOcH+sCqQ6cXLucA0wqPGCY4+08VErQq
	UcN44vX79wXvidPyWlWRMAFDR2OFi6GrgMVJLEwscYt9MRthCmpqLMWE4QPd19GIEpEsUblPaPj
	8xsS5MEned0Gtj0ORAoWY98gPtKYiKTEDsT3MdIsdrQ71IWcWCMb8f13hakH4V1tXJjQDRHunZo
	ygDIuZKSlgSsFflg6VHRo8k0jOtuDLiXifcEJcQwgrZ+HpEySihpwT1h9iu6+KakPZS0VF9X5NJ
	7Uet+02mwiOKa02h5AKCb+YAbZTyLCqtl/k2lvh9bimb0c7uPIQonA4EJlu+3zc8enucpTSygqE
	qRkgFUItQ9Df5YMGULsIgOwqURsUFQJ71UXOMr2RYKDwHavpnybnBJ7hSVgmuiPdqwOMQnFku30
	NKTLQ3x1d66LN78fPwu0bXqpiYeFdUOaFc8uYHAw==
X-Google-Smtp-Source: AGHT+IEKz2zAu0COZ9piLE7CVuURgs4ydAh3u0MHz+pE4EFjMm2CcEy/xVRziqqREQekd8VarMNcvA==
X-Received: by 2002:a05:6a00:8c1:b0:7b9:7f18:c716 with SMTP id d2e1a72fcca58-7ba39bb1928mr15947667b3a.1.1763442166066;
        Mon, 17 Nov 2025 21:02:46 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::f013])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-7b92714df0esm15034310b3a.37.2025.11.17.21.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 21:02:45 -0800 (PST)
Date: Mon, 17 Nov 2025 21:02:43 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Waiman Long <llong@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, Hillf Danton <hdanton@sina.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
Message-ID: <20251118050243.GC2376676-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251118013442.9414-1-hdanton@sina.com>
 <5db3bb06-0bf2-4ba3-b765-c217acda1b0c@redhat.com>
 <aRvjQ6QluONcObXD@fedora>
 <8b07bdd3-5779-4fe4-be05-a8c8efc89f9d@redhat.com>
 <aRvv9-FZ2Q95phNg@fedora>
 <702d904c-2d9a-42b4-95b3-0fa43d91e673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <702d904c-2d9a-42b4-95b3-0fa43d91e673@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_210247_690510_DBDC8F82 
X-CRM114-Status: GOOD (  54.83  )
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

On Mon 2025-11-17 23:35:56 -0500, Waiman Long wrote:
>    On 11/17/25 11:03 PM, Ming Lei wrote:
> 
> On Mon, Nov 17, 2025 at 10:42:04PM -0500, Waiman Long wrote:
> 
> On 11/17/25 10:08 PM, Ming Lei wrote:
> 
> On Mon, Nov 17, 2025 at 09:24:21PM -0500, Waiman Long wrote:
> 
> On 11/17/25 8:34 PM, Hillf Danton wrote:
> 
> On Mon, 17 Nov 2025 12:23:53 -0800 Mohamed Khalfella wrote:
> 
> blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> tagset, the functions make sure that tagset and queues are marked as
> shared when two or more queues are attached to the same tagset.
> Initially a tagset starts as unshared and when the number of added
> queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> with all the queues attached to it. When the number of attached queues
> drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> the remaining queues as unshared.
> 
> Both functions need to freeze current queues in tagset before setting on
> unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> hold set->tag_list_lock mutex, which makes sense as we do not want
> queues to be added or deleted in the process. This used to work fine
> until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> made the nvme driver quiesce tagset instead of quiscing individual
> queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> set->tag_list while holding set->tag_list_lock also.
> 
> This results in deadlock between two threads with these stacktraces:
> 
>     __schedule+0x48e/0xed0
>     schedule+0x5a/0xc0
>     schedule_preempt_disabled+0x11/0x20
>     __mutex_lock.constprop.0+0x3cc/0x760
>     blk_mq_quiesce_tagset+0x26/0xd0
>     nvme_dev_disable_locked+0x77/0x280 [nvme]
>     nvme_timeout+0x268/0x320 [nvme]
>     blk_mq_handle_expired+0x5d/0x90
>     bt_iter+0x7e/0x90
>     blk_mq_queue_tag_busy_iter+0x2b2/0x590
>     ? __blk_mq_complete_request_remote+0x10/0x10
>     ? __blk_mq_complete_request_remote+0x10/0x10
>     blk_mq_timeout_work+0x15b/0x1a0
>     process_one_work+0x133/0x2f0
>     ? mod_delayed_work_on+0x90/0x90
>     worker_thread+0x2ec/0x400
>     ? mod_delayed_work_on+0x90/0x90
>     kthread+0xe2/0x110
>     ? kthread_complete_and_exit+0x20/0x20
>     ret_from_fork+0x2d/0x50
>     ? kthread_complete_and_exit+0x20/0x20
>     ret_from_fork_asm+0x11/0x20
> 
>     __schedule+0x48e/0xed0
>     schedule+0x5a/0xc0
>     blk_mq_freeze_queue_wait+0x62/0x90
>     ? destroy_sched_domains_rcu+0x30/0x30
>     blk_mq_exit_queue+0x151/0x180
>     disk_release+0xe3/0xf0
>     device_release+0x31/0x90
>     kobject_put+0x6d/0x180
>     nvme_scan_ns+0x858/0xc90 [nvme_core]
>     ? nvme_scan_work+0x281/0x560 [nvme_core]
>     nvme_scan_work+0x281/0x560 [nvme_core]
>     process_one_work+0x133/0x2f0
>     ? mod_delayed_work_on+0x90/0x90
>     worker_thread+0x2ec/0x400
>     ? mod_delayed_work_on+0x90/0x90
>     kthread+0xe2/0x110
>     ? kthread_complete_and_exit+0x20/0x20
>     ret_from_fork+0x2d/0x50
>     ? kthread_complete_and_exit+0x20/0x20
>     ret_from_fork_asm+0x11/0x20
> 
> The top stacktrace is showing nvme_timeout() called to handle nvme
> command timeout. timeout handler is trying to disable the controller and
> as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> to call queue callback handlers. The thread is stuck waiting for
> set->tag_list_lock as it tires to walk the queues in set->tag_list.
> 
> The lock is held by the second thread in the bottom stack which is
> waiting for one of queues to be frozen. The queue usage counter will
> drop to zero after nvme_timeout() finishes, and this will not happen
> because the thread will wait for this mutex forever.
> 
> Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
> avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
> semaphore for read since this is enough to guarantee no queues will be
> added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
> semaphore for write while updating set->tag_list and downgrade it to
> read while freezing the queues. It should be safe to update set->flags
> and hctx->flags while holding the semaphore for read since the queues
> are already frozen.
> 
> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> Signed-off-by: Mohamed Khalfella [1]<mkhalfella@purestorage.com>
> ---
>    block/blk-mq-sysfs.c   | 10 ++---
>    block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
>    include/linux/blk-mq.h |  4 +-
>    3 files changed, 58 insertions(+), 51 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 58ec293373c6..f474781654fb 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>         kobject_uevent(q->mq_kobj, KOBJ_ADD);
> -       mutex_lock(&q->tag_set->tag_list_lock);
> +       down_read(&q->tag_set->tag_list_rwsem);
>         queue_for_each_hw_ctx(q, hctx, i) {
>                 ret = blk_mq_register_hctx(hctx);
>                 if (ret)
>                         goto out_unreg;
>         }
> -       mutex_unlock(&q->tag_set->tag_list_lock);
> +       up_read(&q->tag_set->tag_list_rwsem);
>         return 0;
>    out_unreg:
> @@ -244,7 +244,7 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>                 if (j < i)
>                         blk_mq_unregister_hctx(hctx);
>         }
> -       mutex_unlock(&q->tag_set->tag_list_lock);
> +       up_read(&q->tag_set->tag_list_rwsem);
>         kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>         kobject_del(q->mq_kobj);
> @@ -257,10 +257,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
>         struct blk_mq_hw_ctx *hctx;
>         unsigned long i;
> -       mutex_lock(&q->tag_set->tag_list_lock);
> +       down_read(&q->tag_set->tag_list_rwsem);
>         queue_for_each_hw_ctx(q, hctx, i)
>                 blk_mq_unregister_hctx(hctx);
> -       mutex_unlock(&q->tag_set->tag_list_lock);
> +       up_read(&q->tag_set->tag_list_rwsem);
>         kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>         kobject_del(q->mq_kobj);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d626d32f6e57..9211d32ce820 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>    {
>         struct request_queue *q;
> -       mutex_lock(&set->tag_list_lock);
> +       down_read(&set->tag_list_rwsem);
>         list_for_each_entry(q, &set->tag_list, tag_set_list) {
>                 if (!blk_queue_skip_tagset_quiesce(q))
>                         blk_mq_quiesce_queue_nowait(q);
>         }
> -       mutex_unlock(&set->tag_list_lock);
> +       up_read(&set->tag_list_rwsem);
>         blk_mq_wait_quiesce_done(set);
>    }
> @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>    {
>         struct request_queue *q;
> -       mutex_lock(&set->tag_list_lock);
> +       down_read(&set->tag_list_rwsem);
>         list_for_each_entry(q, &set->tag_list, tag_set_list) {
>                 if (!blk_queue_skip_tagset_quiesce(q))
>                         blk_mq_unquiesce_queue(q);
>         }
> -       mutex_unlock(&set->tag_list_lock);
> +       up_read(&set->tag_list_rwsem);
>    }
>    EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
> @@ -4274,56 +4274,63 @@ static void queue_set_hctx_shared(struct request_queue *
> q, bool shared)
>         }
>    }
> -static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
> -                                        bool shared)
> -{
> -       struct request_queue *q;
> -       unsigned int memflags;
> -
> -       lockdep_assert_held(&set->tag_list_lock);
> -
> -       list_for_each_entry(q, &set->tag_list, tag_set_list) {
> -               memflags = blk_mq_freeze_queue(q);
> -               queue_set_hctx_shared(q, shared);
> -               blk_mq_unfreeze_queue(q, memflags);
> -       }
> -}
> -
>    static void blk_mq_del_queue_tag_set(struct request_queue *q)
>    {
>         struct blk_mq_tag_set *set = q->tag_set;
> +       struct request_queue *firstq;
> +       unsigned int memflags;
> -       mutex_lock(&set->tag_list_lock);
> +       down_write(&set->tag_list_rwsem);
>         list_del(&q->tag_set_list);
> -       if (list_is_singular(&set->tag_list)) {
> -               /* just transitioned to unshared */
> -               set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> -               /* update existing queue */
> -               blk_mq_update_tag_set_shared(set, false);
> +       if (!list_is_singular(&set->tag_list)) {
> +               up_write(&set->tag_list_rwsem);
> +               goto out;
>         }
> -       mutex_unlock(&set->tag_list_lock);
> +
> +       /*
> +        * Transitioning the remaining firstq to unshared.
> +        * Also, downgrade the semaphore to avoid deadlock
> +        * with blk_mq_quiesce_tagset() while waiting for
> +        * firstq to be frozen.
> +        */
> +       set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> +       downgrade_write(&set->tag_list_rwsem);
> 
> If the first lock waiter is for write, it could ruin your downgrade trick.
> 
> If the 1st waiter is for WEITE, rwsem_mark_wake() simply returns and grants
> read lock to this caller, meantime wakes up nothing.
> 
> That is exactly what this use case expects, so can you explain in detail why
> `it could ruin your downgrade trick`?
> 
> 
> That is true. The downgrade will wake up all the waiting readers at the
> front of the wait queue, but if there is one or more writers in the mix. The
> wakeup will stop when the first writer is hit and all the readers after that
> will not be woken up.
> 
> So waiters for WRITE won't be waken up by downgrade_write() if I understand corr
> ectly,
> and rwsem_downgrade_wake() documents this behavior too.
> 
> 
> We can theoretically provide a downgrade variant that wakes up all the
> readers if it is a useful feature.
> 
> The following up_read() in this code block will wake up the waiter for
> WRITE, which finally wakes up other waiters for READ, then I am confused
> what is the problem with this usage?
> 
> I am just referring to the fact that not all the readers may be woken up. So
> if the deadlock is caused by one of those readers that is not woken up, it
> can be a problem. I haven't analyzed the deadlock scenario in detail to see
> if that is really the case. It is up to you and others who are more familiar
> with this code base to figure this out.
> 
> Follows the code base, which isn't special compared with other
> downgrade_write() usages:
> 
> blk_mq_del_queue_tag_set()/blk_mq_add_queue_tag_set():
> 
>         down_write(&set->tag_list_rwsem);
>         ...
>         downgrade_write(&set->tag_list_rwsem);
>         ...
>         up_read(&set->tag_list_rwsem);
> 
> All others are readers:
> 
>         down_read(&set->tag_list_rwsem);
>         ...
>         up_read(&set->tag_list_rwsem);
> 
> 
> You mentioned reader may not be waken up in case of r/w mixed waiters, but I
> don't see it is possible.
> 
>    I don't know if concurrent calls to blk_mq_del_queue_tag_set() is
>    possible or not. There is also the blk_mq_update_nr_hw_queues()
>    function that will acquire the write lock.
> 

Assuming blk_mq_del_queue_tag_set(), blk_mq_add_queue_tag_set() and
other readers run in parallel? Are we talking about potential starvation
here? 

If yes, is this reader starvation or writer starvation? 

