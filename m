Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FC8CED240
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 03:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2XxW3/cdpIpT5nG4CxK606QnZknlkTscj3Js3IBq6x4=; b=oewKZ9N18V3RPRbdezYRvmRbj3
	yUDOp5Eq6e25/wbCDlb3xDTEHxZ1MxLqgaZkpZF8lIi32C7Vdx21Sj4iYg2sF6SCbUV0tb9R9qDR2
	by7HkturnG+cIL08Zx2VhSwvxtXq7GH1Rna0Lllmf1fee+syp831LqTwkPNWKgM4n9gP7lYog4SXE
	0hb7nc79xyIUrxY06jmvxT1YS8JukhthApgZA3hhIclHYypkYs+wd3QmNyCgo41tBVYDTSNstb/SB
	TFPKt0tM8I37XjVZWChXbHRLEEGb2FKutnRUaZWN/Tg6vNfPbj4WaZBrQVOX1psznvCfZ+ZmvL+n7
	EFZoH4/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLCbd-0000000HJfr-3s3Z;
	Tue, 18 Nov 2025 03:42:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLCbb-0000000HJfT-056M
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 03:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763437329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XxW3/cdpIpT5nG4CxK606QnZknlkTscj3Js3IBq6x4=;
	b=KRhwTefh4auFPzYgZ5HO7PfguQwMo/wr/e7JLu2wDUeVO4Cilf5iRHxM2v2AMTsObNiKB5
	L7RBEfuA+tjTZ6jjcZSryY+80PS1M+vlfc7OW5KRoV3+iYiQZ3g4ePvEP1LKry+MR32Wg2
	u8xBXx/Fb6wFg2iYPxeiGoxKFcndZP4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-f16sh_01P9Sagu8ZR1P0sQ-1; Mon, 17 Nov 2025 22:42:07 -0500
X-MC-Unique: f16sh_01P9Sagu8ZR1P0sQ-1
X-Mimecast-MFC-AGG-ID: f16sh_01P9Sagu8ZR1P0sQ_1763437327
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-882380beb27so48323426d6.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 19:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763437327; x=1764042127;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XxW3/cdpIpT5nG4CxK606QnZknlkTscj3Js3IBq6x4=;
        b=DnNibm0A7rtyzikUEA6CN8C/TrudymNjV3koSXPGBM1CP2dgqMBwaOpT/R5uMUzSbe
         2hJQDtwb4OtoWLDMUItWn296MhTocWbFf2/B3UYTtF4qQoECXtc5c2xs1+irY3AV4anV
         BNNwes1kIZbmIZasgrCzHwOlcd8FTqhoJq5hK8B7kakKuxJFFMgrUKuJxtbBJO3sja7q
         l4LdyrN3ZnEuDwV+PlcxyIBqSetnzoGznHLtgTdY9Y7sp/QrzQHYFPjHrBm6KkH4jXya
         rXpEnKI6k6dHNemeUR6JFgLFIXeXSPlkODz9QgBd5vYqG+gywVPmjNC+gnF2n9iP1vq6
         74JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/gRkCyiI/nj1Jl4Yc3LZAetDLEfFVNZhATcAoStN8+WrjqAB/HMOUe1JONF4QMgYxsxcgwhjjnaUt@lists.infradead.org
X-Gm-Message-State: AOJu0YzO8Q6y6PMKjMulIQBzv4XK7/qBYWzJovdmnYiIFDCg5XWOJAYG
	hx9N8EBEI3n0nqWeWWOk62SxFR4G+8JmVm2jZRSpMvo/IiVQ0LVmdwqEmqLM8f/3Ed89d2QHQCn
	g+QP6npSL7sC8ThXES0dC8g5et+SIUZO56SKppAsliSlpTPA0SrSFem2wZnfAgLFzEd/j
X-Gm-Gg: ASbGncuoOcmEORFc/boAfRJ48jcUXFRmK9qifa9nfh37w9uNd9Cb+TG/dBvz1WnBCcr
	/pYKHU5MJEEkOdsXYWCFoBFrWXttSr9l60sysR84diJ3724Mv4UcLqBwb8/472MmTZmTUALoEuA
	vso1S76RbPk1bszT4IKMOef5bOu0wvlXSLzmVG9+hZZU9t4IMgWKtpP3ziV8Zc970skU1/W35LB
	v5Q4sxQhOCCLmW/p6aBn4Ut00D8ONIDEB7u7XH16NdQbfX2TyB9JBpL0/mmLy7c8NST3Vpjc1gh
	HGReiJa0FGwYL9UFa9eJDulmRZ1I1pYK0fv/8BD3tiHGU+ld2hR+luv9FJiX3MZBRRdoPKxc1Xu
	hB3E2hCDZ04R35JsOZNl3K4f8kcxWdx+s8semLa6oNZLONA==
X-Received: by 2002:a05:6214:da4:b0:880:460a:96d0 with SMTP id 6a1803df08f44-882926d4d81mr193131496d6.54.1763437327146;
        Mon, 17 Nov 2025 19:42:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvF2cpzlrcyundtwxPYaOVNm6InJJZmhHeI5ssiKbAedeez6kqVgsutwGj45j+Bi+1EqeTZA==
X-Received: by 2002:a05:6214:da4:b0:880:460a:96d0 with SMTP id 6a1803df08f44-882926d4d81mr193131406d6.54.1763437326732;
        Mon, 17 Nov 2025 19:42:06 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828631454csm105583056d6.18.2025.11.17.19.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 19:42:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8b07bdd3-5779-4fe4-be05-a8c8efc89f9d@redhat.com>
Date: Mon, 17 Nov 2025 22:42:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
To: Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>, Jens Axboe
 <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251118013442.9414-1-hdanton@sina.com>
 <5db3bb06-0bf2-4ba3-b765-c217acda1b0c@redhat.com> <aRvjQ6QluONcObXD@fedora>
In-Reply-To: <aRvjQ6QluONcObXD@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8BzXk5Jnl-9Uo909z5HkheSxd3C6ohwmeAyxXBTtIK4_1763437327
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_194211_237110_3D51C8AF 
X-CRM114-Status: GOOD (  33.09  )
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

On 11/17/25 10:08 PM, Ming Lei wrote:
> On Mon, Nov 17, 2025 at 09:24:21PM -0500, Waiman Long wrote:
>> On 11/17/25 8:34 PM, Hillf Danton wrote:
>>> On Mon, 17 Nov 2025 12:23:53 -0800 Mohamed Khalfella wrote:
>>>> blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
>>>> tagset, the functions make sure that tagset and queues are marked as
>>>> shared when two or more queues are attached to the same tagset.
>>>> Initially a tagset starts as unshared and when the number of added
>>>> queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
>>>> with all the queues attached to it. When the number of attached queues
>>>> drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
>>>> the remaining queues as unshared.
>>>>
>>>> Both functions need to freeze current queues in tagset before setting on
>>>> unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
>>>> hold set->tag_list_lock mutex, which makes sense as we do not want
>>>> queues to be added or deleted in the process. This used to work fine
>>>> until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
>>>> made the nvme driver quiesce tagset instead of quiscing individual
>>>> queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
>>>> set->tag_list while holding set->tag_list_lock also.
>>>>
>>>> This results in deadlock between two threads with these stacktraces:
>>>>
>>>>     __schedule+0x48e/0xed0
>>>>     schedule+0x5a/0xc0
>>>>     schedule_preempt_disabled+0x11/0x20
>>>>     __mutex_lock.constprop.0+0x3cc/0x760
>>>>     blk_mq_quiesce_tagset+0x26/0xd0
>>>>     nvme_dev_disable_locked+0x77/0x280 [nvme]
>>>>     nvme_timeout+0x268/0x320 [nvme]
>>>>     blk_mq_handle_expired+0x5d/0x90
>>>>     bt_iter+0x7e/0x90
>>>>     blk_mq_queue_tag_busy_iter+0x2b2/0x590
>>>>     ? __blk_mq_complete_request_remote+0x10/0x10
>>>>     ? __blk_mq_complete_request_remote+0x10/0x10
>>>>     blk_mq_timeout_work+0x15b/0x1a0
>>>>     process_one_work+0x133/0x2f0
>>>>     ? mod_delayed_work_on+0x90/0x90
>>>>     worker_thread+0x2ec/0x400
>>>>     ? mod_delayed_work_on+0x90/0x90
>>>>     kthread+0xe2/0x110
>>>>     ? kthread_complete_and_exit+0x20/0x20
>>>>     ret_from_fork+0x2d/0x50
>>>>     ? kthread_complete_and_exit+0x20/0x20
>>>>     ret_from_fork_asm+0x11/0x20
>>>>
>>>>     __schedule+0x48e/0xed0
>>>>     schedule+0x5a/0xc0
>>>>     blk_mq_freeze_queue_wait+0x62/0x90
>>>>     ? destroy_sched_domains_rcu+0x30/0x30
>>>>     blk_mq_exit_queue+0x151/0x180
>>>>     disk_release+0xe3/0xf0
>>>>     device_release+0x31/0x90
>>>>     kobject_put+0x6d/0x180
>>>>     nvme_scan_ns+0x858/0xc90 [nvme_core]
>>>>     ? nvme_scan_work+0x281/0x560 [nvme_core]
>>>>     nvme_scan_work+0x281/0x560 [nvme_core]
>>>>     process_one_work+0x133/0x2f0
>>>>     ? mod_delayed_work_on+0x90/0x90
>>>>     worker_thread+0x2ec/0x400
>>>>     ? mod_delayed_work_on+0x90/0x90
>>>>     kthread+0xe2/0x110
>>>>     ? kthread_complete_and_exit+0x20/0x20
>>>>     ret_from_fork+0x2d/0x50
>>>>     ? kthread_complete_and_exit+0x20/0x20
>>>>     ret_from_fork_asm+0x11/0x20
>>>>
>>>> The top stacktrace is showing nvme_timeout() called to handle nvme
>>>> command timeout. timeout handler is trying to disable the controller and
>>>> as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
>>>> to call queue callback handlers. The thread is stuck waiting for
>>>> set->tag_list_lock as it tires to walk the queues in set->tag_list.
>>>>
>>>> The lock is held by the second thread in the bottom stack which is
>>>> waiting for one of queues to be frozen. The queue usage counter will
>>>> drop to zero after nvme_timeout() finishes, and this will not happen
>>>> because the thread will wait for this mutex forever.
>>>>
>>>> Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
>>>> avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
>>>> semaphore for read since this is enough to guarantee no queues will be
>>>> added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
>>>> semaphore for write while updating set->tag_list and downgrade it to
>>>> read while freezing the queues. It should be safe to update set->flags
>>>> and hctx->flags while holding the semaphore for read since the queues
>>>> are already frozen.
>>>>
>>>> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
>>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>>> ---
>>>>    block/blk-mq-sysfs.c   | 10 ++---
>>>>    block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
>>>>    include/linux/blk-mq.h |  4 +-
>>>>    3 files changed, 58 insertions(+), 51 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
>>>> index 58ec293373c6..f474781654fb 100644
>>>> --- a/block/blk-mq-sysfs.c
>>>> +++ b/block/blk-mq-sysfs.c
>>>> @@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>>>>    	kobject_uevent(q->mq_kobj, KOBJ_ADD);
>>>> -	mutex_lock(&q->tag_set->tag_list_lock);
>>>> +	down_read(&q->tag_set->tag_list_rwsem);
>>>>    	queue_for_each_hw_ctx(q, hctx, i) {
>>>>    		ret = blk_mq_register_hctx(hctx);
>>>>    		if (ret)
>>>>    			goto out_unreg;
>>>>    	}
>>>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>>>> +	up_read(&q->tag_set->tag_list_rwsem);
>>>>    	return 0;
>>>>    out_unreg:
>>>> @@ -244,7 +244,7 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>>>>    		if (j < i)
>>>>    			blk_mq_unregister_hctx(hctx);
>>>>    	}
>>>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>>>> +	up_read(&q->tag_set->tag_list_rwsem);
>>>>    	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>>>>    	kobject_del(q->mq_kobj);
>>>> @@ -257,10 +257,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
>>>>    	struct blk_mq_hw_ctx *hctx;
>>>>    	unsigned long i;
>>>> -	mutex_lock(&q->tag_set->tag_list_lock);
>>>> +	down_read(&q->tag_set->tag_list_rwsem);
>>>>    	queue_for_each_hw_ctx(q, hctx, i)
>>>>    		blk_mq_unregister_hctx(hctx);
>>>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>>>> +	up_read(&q->tag_set->tag_list_rwsem);
>>>>    	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>>>>    	kobject_del(q->mq_kobj);
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index d626d32f6e57..9211d32ce820 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>>>>    {
>>>>    	struct request_queue *q;
>>>> -	mutex_lock(&set->tag_list_lock);
>>>> +	down_read(&set->tag_list_rwsem);
>>>>    	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>>    		if (!blk_queue_skip_tagset_quiesce(q))
>>>>    			blk_mq_quiesce_queue_nowait(q);
>>>>    	}
>>>> -	mutex_unlock(&set->tag_list_lock);
>>>> +	up_read(&set->tag_list_rwsem);
>>>>    	blk_mq_wait_quiesce_done(set);
>>>>    }
>>>> @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>>>>    {
>>>>    	struct request_queue *q;
>>>> -	mutex_lock(&set->tag_list_lock);
>>>> +	down_read(&set->tag_list_rwsem);
>>>>    	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>>    		if (!blk_queue_skip_tagset_quiesce(q))
>>>>    			blk_mq_unquiesce_queue(q);
>>>>    	}
>>>> -	mutex_unlock(&set->tag_list_lock);
>>>> +	up_read(&set->tag_list_rwsem);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
>>>> @@ -4274,56 +4274,63 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
>>>>    	}
>>>>    }
>>>> -static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
>>>> -					 bool shared)
>>>> -{
>>>> -	struct request_queue *q;
>>>> -	unsigned int memflags;
>>>> -
>>>> -	lockdep_assert_held(&set->tag_list_lock);
>>>> -
>>>> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>> -		memflags = blk_mq_freeze_queue(q);
>>>> -		queue_set_hctx_shared(q, shared);
>>>> -		blk_mq_unfreeze_queue(q, memflags);
>>>> -	}
>>>> -}
>>>> -
>>>>    static void blk_mq_del_queue_tag_set(struct request_queue *q)
>>>>    {
>>>>    	struct blk_mq_tag_set *set = q->tag_set;
>>>> +	struct request_queue *firstq;
>>>> +	unsigned int memflags;
>>>> -	mutex_lock(&set->tag_list_lock);
>>>> +	down_write(&set->tag_list_rwsem);
>>>>    	list_del(&q->tag_set_list);
>>>> -	if (list_is_singular(&set->tag_list)) {
>>>> -		/* just transitioned to unshared */
>>>> -		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>>>> -		/* update existing queue */
>>>> -		blk_mq_update_tag_set_shared(set, false);
>>>> +	if (!list_is_singular(&set->tag_list)) {
>>>> +		up_write(&set->tag_list_rwsem);
>>>> +		goto out;
>>>>    	}
>>>> -	mutex_unlock(&set->tag_list_lock);
>>>> +
>>>> +	/*
>>>> +	 * Transitioning the remaining firstq to unshared.
>>>> +	 * Also, downgrade the semaphore to avoid deadlock
>>>> +	 * with blk_mq_quiesce_tagset() while waiting for
>>>> +	 * firstq to be frozen.
>>>> +	 */
>>>> +	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>>>> +	downgrade_write(&set->tag_list_rwsem);
>>> If the first lock waiter is for write, it could ruin your downgrade trick.
> If the 1st waiter is for WEITE, rwsem_mark_wake() simply returns and grants
> read lock to this caller, meantime wakes up nothing.
>
> That is exactly what this use case expects, so can you explain in detail why
> `it could ruin your downgrade trick`?
>
>> That is true. The downgrade will wake up all the waiting readers at the
>> front of the wait queue, but if there is one or more writers in the mix. The
>> wakeup will stop when the first writer is hit and all the readers after that
>> will not be woken up.
> So waiters for WRITE won't be waken up by downgrade_write() if I understand correctly,
> and rwsem_downgrade_wake() documents this behavior too.
>
>> We can theoretically provide a downgrade variant that wakes up all the
>> readers if it is a useful feature.
> The following up_read() in this code block will wake up the waiter for
> WRITE, which finally wakes up other waiters for READ, then I am confused
> what is the problem with this usage?

I am just referring to the fact that not all the readers may be woken 
up. So if the deadlock is caused by one of those readers that is not 
woken up, it can be a problem. I haven't analyzed the deadlock scenario 
in detail to see if that is really the case. It is up to you and others 
who are more familiar with this code base to figure this out.

Cheers,
Longman


