Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB684CEBF8D
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 02:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tOwAePC/NPw7hDfXIpdlCbSHG9S1qqf21zBz7vtSHX8=; b=lxWw97L+EiB9OewHikX/0F7/NX
	apigP9Ey1u0zZVwSBe+rb0LQ9JOr7KAul/vJKIoKipQpFrfKdyBdic2lAB/hn4l6DRx7I6R9WvaSw
	yTRQsQp8/uO/SEpxzJ0aSidreA4nnmNqSNEYcWIjoBLrIzI4F8SmHZGkeVPoxvlVEjbdGp3u4iVtx
	dyssIjdoS7KtobIJAJ7irEB+HPNjlezTgBfaI2VfS7WWYuipM33YBOrjrlx4LrQIO53x1KHrKzV7d
	fPIz+kcErBYL7kEI/Nyk2e0wjQ+jDN2leeUqZvpYwDtAlzOO8434PA2iVSi9HkfGa6TNWvLTXykuf
	f++k+ivg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLBOT-0000000HDcR-0U2S;
	Tue, 18 Nov 2025 02:24:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLBOQ-0000000HDbE-2wRI
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 02:24:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763432668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOwAePC/NPw7hDfXIpdlCbSHG9S1qqf21zBz7vtSHX8=;
	b=i8ed5xbqA2K9keih+dknsCieULQe8PYRaqWDbKvtJdzf8juOvSrqOoKAQjlBde5Bi2qtD6
	iUJXvAjFRnSevGbNDdYgq45HBwuEDQqupXsq1wnXqSvs1hWyEFhef9/dYOP3kOMyZ10PIK
	QxrXrqJYzI/enyeyRUvjU5kABN/rPtI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-muTkbpTiPO-71GGnn0Y9fA-1; Mon, 17 Nov 2025 21:24:24 -0500
X-MC-Unique: muTkbpTiPO-71GGnn0Y9fA-1
X-Mimecast-MFC-AGG-ID: muTkbpTiPO-71GGnn0Y9fA_1763432664
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88238449415so269147066d6.2
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 18:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432663; x=1764037463;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOwAePC/NPw7hDfXIpdlCbSHG9S1qqf21zBz7vtSHX8=;
        b=U1Mp6pkH8DRDb+twfnRIPXeNdwDFRnCSIQRlEZgQ0Ptbnk0FW9nUEgEVbaw/SOTu80
         AfxEhpMT5Wr0fS1eS7NGK+bVSRB6nof/st/3WFNaDWD2zLzO1Yd8rGKO1ec3Kg09TXR/
         p6N4fWHnPPBS0lHjrAzmzQyxCvjhaGRNYcbUnwiHIyHqvvEaAYPvajqp3YrogF2gubiL
         UNcJmz4uNmDU7eMMOz++Zn9evz/UsIl0ayMXQEirlqYNEYuBS76WFPCejv2YFnYe1LSS
         FlEfgulZtjBK0C0kB5UlSEjvGmIEbnS+W51DQUyFF+vLQNT6rVwPMAeBR89uBv2MoJ4R
         zn0g==
X-Forwarded-Encrypted: i=1; AJvYcCVBtN72OB6T3WD25Plqxfhl9u0UuvWNapU1Motfp0GM1fpaqAOqRQZVQuyzfKBhJrITdXf09W7bkaOI@lists.infradead.org
X-Gm-Message-State: AOJu0Yzr9KRecKQkIMQ3p11SXSw3NaYxr0o7M0FD7TTwutUcY/0+HUNY
	7bJKjx88vKL+NqwkIjXc6aZT7+JIAZRv5GL/lLqmlk0Ang2Nh9fUDyoE5XB1JrwrCMf0Wqr/XmS
	sh4DPE1eP3YF57ZnzOx28HqASa0w7bD6G/naP1w6q2uuixLXc8UgBRqJK8w3N6tBndhP9
X-Gm-Gg: ASbGncvLjhiMGxbbFCjfvqKMI94J2Qrr/3jR+H6tXBQiK60ucAWuIvTEqOihmd3BBoV
	WHraHt24B903dpM1jJdLed36nVTTghUWlR1Hfjqx4OWNlMcUR42CM7o/rxP03GIJXpCCiW6PuPd
	ZW/Dwwy0jc+LWxqStFM/f3+4sQ6Hha7+vtJqIWvzcfvXTXQH+ZMVqFXCmcuTQxwSRt+RMt7Gd/4
	yJbvSmxIQfZaGdDMlGelb7HvmmTa6D/DUWrCDocsvt3gVWbmmQTDisSUAYcECmIxTLxU1GjOXLd
	8yKX7jhJXCTEL1N1LYv+ar9WzEf+DJV1SlZOTecDcpakr6YlP90G6iwKQutqkrAsARiKRNY2Ysh
	A2cVb8vNReXOKCDUO1pnYN3aoWEjXSPtoxbrEPhtr2C4+KA==
X-Received: by 2002:a05:6214:268b:b0:880:2de3:eef3 with SMTP id 6a1803df08f44-882926b1e19mr236224726d6.32.1763432663658;
        Mon, 17 Nov 2025 18:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb7GLCy7ZCBeNDHvzfJNZiFnbDKqJIiNykFezhBonArB/ScdDKtqFSn50+jhEGKW0NwimkHQ==
X-Received: by 2002:a05:6214:268b:b0:880:2de3:eef3 with SMTP id 6a1803df08f44-882926b1e19mr236224426d6.32.1763432663252;
        Mon, 17 Nov 2025 18:24:23 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828630693bsm104340286d6.14.2025.11.17.18.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 18:24:22 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5db3bb06-0bf2-4ba3-b765-c217acda1b0c@redhat.com>
Date: Mon, 17 Nov 2025 21:24:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
To: Hillf Danton <hdanton@sina.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 Waiman Long <llong@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251118013442.9414-1-hdanton@sina.com>
In-Reply-To: <20251118013442.9414-1-hdanton@sina.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JlMvn4E7lufrtZ-NYWkVU7BmzvkBW1po9jb29iIe9r0_1763432664
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_182430_846347_7EFA5BF5 
X-CRM114-Status: GOOD (  27.96  )
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

On 11/17/25 8:34 PM, Hillf Danton wrote:
> On Mon, 17 Nov 2025 12:23:53 -0800 Mohamed Khalfella wrote:
>> blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
>> tagset, the functions make sure that tagset and queues are marked as
>> shared when two or more queues are attached to the same tagset.
>> Initially a tagset starts as unshared and when the number of added
>> queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
>> with all the queues attached to it. When the number of attached queues
>> drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
>> the remaining queues as unshared.
>>
>> Both functions need to freeze current queues in tagset before setting on
>> unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
>> hold set->tag_list_lock mutex, which makes sense as we do not want
>> queues to be added or deleted in the process. This used to work fine
>> until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
>> made the nvme driver quiesce tagset instead of quiscing individual
>> queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
>> set->tag_list while holding set->tag_list_lock also.
>>
>> This results in deadlock between two threads with these stacktraces:
>>
>>    __schedule+0x48e/0xed0
>>    schedule+0x5a/0xc0
>>    schedule_preempt_disabled+0x11/0x20
>>    __mutex_lock.constprop.0+0x3cc/0x760
>>    blk_mq_quiesce_tagset+0x26/0xd0
>>    nvme_dev_disable_locked+0x77/0x280 [nvme]
>>    nvme_timeout+0x268/0x320 [nvme]
>>    blk_mq_handle_expired+0x5d/0x90
>>    bt_iter+0x7e/0x90
>>    blk_mq_queue_tag_busy_iter+0x2b2/0x590
>>    ? __blk_mq_complete_request_remote+0x10/0x10
>>    ? __blk_mq_complete_request_remote+0x10/0x10
>>    blk_mq_timeout_work+0x15b/0x1a0
>>    process_one_work+0x133/0x2f0
>>    ? mod_delayed_work_on+0x90/0x90
>>    worker_thread+0x2ec/0x400
>>    ? mod_delayed_work_on+0x90/0x90
>>    kthread+0xe2/0x110
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork+0x2d/0x50
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork_asm+0x11/0x20
>>
>>    __schedule+0x48e/0xed0
>>    schedule+0x5a/0xc0
>>    blk_mq_freeze_queue_wait+0x62/0x90
>>    ? destroy_sched_domains_rcu+0x30/0x30
>>    blk_mq_exit_queue+0x151/0x180
>>    disk_release+0xe3/0xf0
>>    device_release+0x31/0x90
>>    kobject_put+0x6d/0x180
>>    nvme_scan_ns+0x858/0xc90 [nvme_core]
>>    ? nvme_scan_work+0x281/0x560 [nvme_core]
>>    nvme_scan_work+0x281/0x560 [nvme_core]
>>    process_one_work+0x133/0x2f0
>>    ? mod_delayed_work_on+0x90/0x90
>>    worker_thread+0x2ec/0x400
>>    ? mod_delayed_work_on+0x90/0x90
>>    kthread+0xe2/0x110
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork+0x2d/0x50
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork_asm+0x11/0x20
>>
>> The top stacktrace is showing nvme_timeout() called to handle nvme
>> command timeout. timeout handler is trying to disable the controller and
>> as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
>> to call queue callback handlers. The thread is stuck waiting for
>> set->tag_list_lock as it tires to walk the queues in set->tag_list.
>>
>> The lock is held by the second thread in the bottom stack which is
>> waiting for one of queues to be frozen. The queue usage counter will
>> drop to zero after nvme_timeout() finishes, and this will not happen
>> because the thread will wait for this mutex forever.
>>
>> Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
>> avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
>> semaphore for read since this is enough to guarantee no queues will be
>> added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
>> semaphore for write while updating set->tag_list and downgrade it to
>> read while freezing the queues. It should be safe to update set->flags
>> and hctx->flags while holding the semaphore for read since the queues
>> are already frozen.
>>
>> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>> ---
>>   block/blk-mq-sysfs.c   | 10 ++---
>>   block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
>>   include/linux/blk-mq.h |  4 +-
>>   3 files changed, 58 insertions(+), 51 deletions(-)
>>
>> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
>> index 58ec293373c6..f474781654fb 100644
>> --- a/block/blk-mq-sysfs.c
>> +++ b/block/blk-mq-sysfs.c
>> @@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>>   
>>   	kobject_uevent(q->mq_kobj, KOBJ_ADD);
>>   
>> -	mutex_lock(&q->tag_set->tag_list_lock);
>> +	down_read(&q->tag_set->tag_list_rwsem);
>>   	queue_for_each_hw_ctx(q, hctx, i) {
>>   		ret = blk_mq_register_hctx(hctx);
>>   		if (ret)
>>   			goto out_unreg;
>>   	}
>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>> +	up_read(&q->tag_set->tag_list_rwsem);
>>   	return 0;
>>   
>>   out_unreg:
>> @@ -244,7 +244,7 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>>   		if (j < i)
>>   			blk_mq_unregister_hctx(hctx);
>>   	}
>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>> +	up_read(&q->tag_set->tag_list_rwsem);
>>   
>>   	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>>   	kobject_del(q->mq_kobj);
>> @@ -257,10 +257,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
>>   	struct blk_mq_hw_ctx *hctx;
>>   	unsigned long i;
>>   
>> -	mutex_lock(&q->tag_set->tag_list_lock);
>> +	down_read(&q->tag_set->tag_list_rwsem);
>>   	queue_for_each_hw_ctx(q, hctx, i)
>>   		blk_mq_unregister_hctx(hctx);
>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>> +	up_read(&q->tag_set->tag_list_rwsem);
>>   
>>   	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>>   	kobject_del(q->mq_kobj);
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index d626d32f6e57..9211d32ce820 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>>   {
>>   	struct request_queue *q;
>>   
>> -	mutex_lock(&set->tag_list_lock);
>> +	down_read(&set->tag_list_rwsem);
>>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>   		if (!blk_queue_skip_tagset_quiesce(q))
>>   			blk_mq_quiesce_queue_nowait(q);
>>   	}
>> -	mutex_unlock(&set->tag_list_lock);
>> +	up_read(&set->tag_list_rwsem);
>>   
>>   	blk_mq_wait_quiesce_done(set);
>>   }
>> @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>>   {
>>   	struct request_queue *q;
>>   
>> -	mutex_lock(&set->tag_list_lock);
>> +	down_read(&set->tag_list_rwsem);
>>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>   		if (!blk_queue_skip_tagset_quiesce(q))
>>   			blk_mq_unquiesce_queue(q);
>>   	}
>> -	mutex_unlock(&set->tag_list_lock);
>> +	up_read(&set->tag_list_rwsem);
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
>>   
>> @@ -4274,56 +4274,63 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
>>   	}
>>   }
>>   
>> -static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
>> -					 bool shared)
>> -{
>> -	struct request_queue *q;
>> -	unsigned int memflags;
>> -
>> -	lockdep_assert_held(&set->tag_list_lock);
>> -
>> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> -		memflags = blk_mq_freeze_queue(q);
>> -		queue_set_hctx_shared(q, shared);
>> -		blk_mq_unfreeze_queue(q, memflags);
>> -	}
>> -}
>> -
>>   static void blk_mq_del_queue_tag_set(struct request_queue *q)
>>   {
>>   	struct blk_mq_tag_set *set = q->tag_set;
>> +	struct request_queue *firstq;
>> +	unsigned int memflags;
>>   
>> -	mutex_lock(&set->tag_list_lock);
>> +	down_write(&set->tag_list_rwsem);
>>   	list_del(&q->tag_set_list);
>> -	if (list_is_singular(&set->tag_list)) {
>> -		/* just transitioned to unshared */
>> -		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>> -		/* update existing queue */
>> -		blk_mq_update_tag_set_shared(set, false);
>> +	if (!list_is_singular(&set->tag_list)) {
>> +		up_write(&set->tag_list_rwsem);
>> +		goto out;
>>   	}
>> -	mutex_unlock(&set->tag_list_lock);
>> +
>> +	/*
>> +	 * Transitioning the remaining firstq to unshared.
>> +	 * Also, downgrade the semaphore to avoid deadlock
>> +	 * with blk_mq_quiesce_tagset() while waiting for
>> +	 * firstq to be frozen.
>> +	 */
>> +	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>> +	downgrade_write(&set->tag_list_rwsem);
> If the first lock waiter is for write, it could ruin your downgrade trick.

That is true. The downgrade will wake up all the waiting readers at the 
front of the wait queue, but if there is one or more writers in the mix. 
The wakeup will stop when the first writer is hit and all the readers 
after that will not be woken up.

We can theoretically provide a downgrade variant that wakes up all the 
readers if it is a useful feature.

Cheers,
Longman



