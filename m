Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEB1D29FB0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZNwwr56flO1xS1S9sF1L+dtFjYocKmny67IwW4Ohtk=; b=e2k3J3gnUdNuOpOKN8nCZnlvz2
	+toQRnaKG3Vf+sRC4SCSxIjXL1V9XXscUWCQQQiH+2ty+1oKt9UxeLeoOWhrDi6P7c4TH9ySgN4JT
	pFqmQJNqDJGLu7G7kjzAKjM5r+VDt/6KNV8U/2b7/YwQbuCYkKL6ryuL4KKSoHnuSJkLE13EWJ+gv
	o6AFCj4lpSEJOwGUNNKZrFPfPeC4DI2DQ02xsynLfYwwuA1z7fG0d8R1dQQxOpLAe1b4BXyfmbo1k
	PCeFBXEpq5bHlWZbMtPR/gHTXCQSJb1OnLDtxRtcC78mGb21qVZ9p3gdGp3tWKHrEWF6N98bEGoky
	fAQGBU0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vREba-00000008TWN-0G6J;
	Thu, 04 Dec 2025 19:03:06 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vREbX-00000008TVw-3xrU
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 19:03:05 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-b728a43e410so213829966b.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 11:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764874982; x=1765479782; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZNwwr56flO1xS1S9sF1L+dtFjYocKmny67IwW4Ohtk=;
        b=DwZPxANwNfwt6b21NhIvfpZrr1GCMBnxsDg8rTejgSIENWWcttSodlKn53crQWILaQ
         B/6LJlbHlDn+bQBqzoOOY8mm+B+wTY292ANu2otSb9h1nQwZIH/y52RZS8GKqV8IDl9R
         TUz2wQBLAsp7v0D4RW7+5Y/l8u23OzvcRwj78z3fdde0auAZ98qGiVTljMu+HFjrWeOv
         6wzpaJdlHoXIEhdr8NN1Pu7+D6f3BbgQAKuuis2jqxyTxv3y/FkNBCPPPnfOiUYKEaRR
         9O3GCGKMJL50S4yYLHUKbExRZ/e22UuDqUQBkQtS/A2KQiS1/HYet7SetLpsr8yrkaeR
         rHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764874982; x=1765479782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZNwwr56flO1xS1S9sF1L+dtFjYocKmny67IwW4Ohtk=;
        b=u0idRzppnG7YrrKDxJxiMpB1ys03vODxSMCEnP2ltXYkf5s5DK1C6tJnbM0lioy5gG
         x5CLjhljlU99Wb+HO6Q0OOwdHAVsYFErCXhQTVy7+m5YHnXHZJiwPizBKsytOdsptleH
         UZ7CSzspa7UcBHQvmWaBo+mcFHiyfIspIKr9I0ZmuDR3jkhRxLK7Jp5JIEcjIpPh4zyq
         XpwQ2OzNEhHLdTP+mx/qdSWU4OeEptGrCmNEfvRVoa25G3pMrXS5i4j5KvtkvH7XzyFi
         7fqLIo88eal1YwtNsss/4oUb9rl5ySGnf3G1rJPdn0rz+6tK1DCI+gfCcJ4OG12X+nSW
         pepA==
X-Forwarded-Encrypted: i=1; AJvYcCXKh72g+gFqFflmnakz9T0f64K+WDwkllI+qHi+QIW+FXoGaY4h8oXynzMsCQhy3U4rPC/+dKYnkyUE@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/UiJdA2TV97nirPNNO+4vI5WSUI1bmBaiIFLYll/8C+4Q5QCF
	bjug1bpkC8uqK39RAQCP/1W14UNw4Mmo1U3gXGOPhHNwcJTF1b1MwxdIRbCHbDbYmwI=
X-Gm-Gg: ASbGnctOo92QdBL10jhZUWS33HMR2yesw5micGhAVJum977JK6/PQUB5gdjgJL/eFN0
	Q+fveAF2PCW4eSeM5j7EeKp6Zn4kGjeI94HYZLPRxel/MpMwJ73FRCp/H1xnTupar9kIO7RQl0s
	lSEW2UToUCLm/7vy8JlrYd35v9DjR0oiSXbTfr5NugF3CgEVWYDXeZdww0W+QznjPxsKyCunNx0
	1VNDNmaPnRLBX7ylogRADuUHEm+JZxv/M2NZRKjy2lt13pr4U8Kgo81bOnFUo5tyYmLyAL5O59s
	+TlZR/oRTOBuYDgPlW1h4szvof2Ru+eJx43LXBLSHplrnOkz7FHMEpzdIdEr+MNPEmpImJsnw9e
	2TQ/HQg4oh0WwcSB8ydDpCZxc0M/fNN3zzIKL95+tYWxQ+VAmq2UGHIAuHbZdcvzUzv5gzr0Z/b
	tdoaE5prOkynDvcvpvlWF9kG30IjeTgJpIq9JjwONNzg==
X-Google-Smtp-Source: AGHT+IH26241l6Q/yokZ7U8z1pSwtQVJnt6+RwJRUNGc30R9za5E0rovz0FeljZNndRz6VFmAa7/zA==
X-Received: by 2002:a17:907:3cc2:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b79dc73cce5mr759963766b.32.1764874981679;
        Thu, 04 Dec 2025 11:03:01 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a640c23a62f3a-b79f449ba82sm195018266b.22.2025.12.04.11.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 11:03:01 -0800 (PST)
Date: Thu, 4 Dec 2025 11:02:58 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <20251204190258.GA337106-mkhalfella@purestorage.com>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204181212.1484066-2-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_110304_024133_AC17641F 
X-CRM114-Status: GOOD (  30.88  )
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

On Thu 2025-12-04 10:11:53 -0800, Mohamed Khalfella wrote:
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
>   __schedule+0x48e/0xed0
>   schedule+0x5a/0xc0
>   schedule_preempt_disabled+0x11/0x20
>   __mutex_lock.constprop.0+0x3cc/0x760
>   blk_mq_quiesce_tagset+0x26/0xd0
>   nvme_dev_disable_locked+0x77/0x280 [nvme]
>   nvme_timeout+0x268/0x320 [nvme]
>   blk_mq_handle_expired+0x5d/0x90
>   bt_iter+0x7e/0x90
>   blk_mq_queue_tag_busy_iter+0x2b2/0x590
>   ? __blk_mq_complete_request_remote+0x10/0x10
>   ? __blk_mq_complete_request_remote+0x10/0x10
>   blk_mq_timeout_work+0x15b/0x1a0
>   process_one_work+0x133/0x2f0
>   ? mod_delayed_work_on+0x90/0x90
>   worker_thread+0x2ec/0x400
>   ? mod_delayed_work_on+0x90/0x90
>   kthread+0xe2/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x2d/0x50
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork_asm+0x11/0x20
> 
>   __schedule+0x48e/0xed0
>   schedule+0x5a/0xc0
>   blk_mq_freeze_queue_wait+0x62/0x90
>   ? destroy_sched_domains_rcu+0x30/0x30
>   blk_mq_exit_queue+0x151/0x180
>   disk_release+0xe3/0xf0
>   device_release+0x31/0x90
>   kobject_put+0x6d/0x180
>   nvme_scan_ns+0x858/0xc90 [nvme_core]
>   ? nvme_scan_work+0x281/0x560 [nvme_core]
>   nvme_scan_work+0x281/0x560 [nvme_core]
>   process_one_work+0x133/0x2f0
>   ? mod_delayed_work_on+0x90/0x90
>   worker_thread+0x2ec/0x400
>   ? mod_delayed_work_on+0x90/0x90
>   kthread+0xe2/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x2d/0x50
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork_asm+0x11/0x20
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
> Given that [un]quescing queue is an operation that does not need to
> sleep, update blk_mq_[un]quiesce_tagset() to use RCU instead of taking
> set->tag_list_lock. Also update blk_mq_{add,del}_queue_tag_set() to use
> RCU safe list operations. This should help avoid deadlock seen above.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")

Oops, this should be v3 and I also missed Fixes: tag above.

> ---
>  block/blk-mq.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d626d32f6e57..ceb176ac154b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>  {
>  	struct request_queue *q;
>  
> -	mutex_lock(&set->tag_list_lock);
> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
>  		if (!blk_queue_skip_tagset_quiesce(q))
>  			blk_mq_quiesce_queue_nowait(q);
>  	}
> -	mutex_unlock(&set->tag_list_lock);
> +	rcu_read_unlock();
>  
>  	blk_mq_wait_quiesce_done(set);
>  }
> @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>  {
>  	struct request_queue *q;
>  
> -	mutex_lock(&set->tag_list_lock);
> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
>  		if (!blk_queue_skip_tagset_quiesce(q))
>  			blk_mq_unquiesce_queue(q);
>  	}
> -	mutex_unlock(&set->tag_list_lock);
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
>  
> @@ -4294,7 +4294,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  	struct blk_mq_tag_set *set = q->tag_set;
>  
>  	mutex_lock(&set->tag_list_lock);
> -	list_del(&q->tag_set_list);
> +	list_del_rcu(&q->tag_set_list);
>  	if (list_is_singular(&set->tag_list)) {
>  		/* just transitioned to unshared */
>  		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> @@ -4302,6 +4302,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  		blk_mq_update_tag_set_shared(set, false);
>  	}
>  	mutex_unlock(&set->tag_list_lock);
> +
> +	synchronize_rcu();
>  	INIT_LIST_HEAD(&q->tag_set_list);
>  }
>  
> @@ -4321,7 +4323,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  	}
>  	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
>  		queue_set_hctx_shared(q, true);
> -	list_add_tail(&q->tag_set_list, &set->tag_list);
> +	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
>  
>  	mutex_unlock(&set->tag_list_lock);
>  }
> -- 
> 2.51.2
> 

