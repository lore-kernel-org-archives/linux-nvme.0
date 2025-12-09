Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA31ED3B98C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rz2s4/XACP16CBGrl75sJvoaK4RRP2zE8Z8SxMQdAxE=; b=MxfKqEI1jn9ZjZr70xcgXu6TuJ
	V8qWTTaGjv9B/hcZKfOsKuunZ931OE+8u7yX8YcGkJKla68mX2vuLUOumMCXwV1F2OOFaRN0eb/+P
	02Pgl6eT4DcdI8y4MAb8+B3MuNEnWnc7h69LKTY0ZthH5CM1qYLYecmdEhheKms3Iy4ILUi+2A0Tm
	LUwldliyFowOpDLdIHu/0Ddx9s8lwke9nogJNLEfB5hNi1h2VXJ+AmhgqrkKJrCM6+qM1rbWUgswe
	7uDtQ2psLIh5r2CIaID2Ep+9GEN8G5e5vPLLSSUce8aIrWTomdqEYyLAkxWZI0docFtowBMTu1EeE
	2QyDBV4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT1q3-0000000EcI7-0yFM;
	Tue, 09 Dec 2025 17:49:27 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT1q0-0000000EcHl-0dxZ
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 17:49:25 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7b80fed1505so6183349b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 Dec 2025 09:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765302563; x=1765907363; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rz2s4/XACP16CBGrl75sJvoaK4RRP2zE8Z8SxMQdAxE=;
        b=bwAn1Sqj0AtrnCQooZsoqT66mAswkdGVA8tB3lgs5Tlm2xPBDE03YCuydrRsE6FBTD
         mhYSe1bKGsbDS4Vi9wazZXtwMS4HVwLSSG1X2vsxPDVph0/vRwlWYYvtCqX1ASZKDeRB
         OAkbZO0s9svQJofnO3JhihhqQqquluYANzgnrYlZaBcolRr8kasl60FKg3iwzw4EjSDo
         6oTeD2MJAg7BnvLDX+aS17TWSjlz27zG4CU6RTYUbbWDk93ZObGzNM2flsvZmW14hZTZ
         mMnEij7FtZdmwcv1FQkuHfgnNy4IlrxQk2j//+GcNxTNFkf9wfV02NbhE1jNrHNyxAbj
         pK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765302563; x=1765907363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rz2s4/XACP16CBGrl75sJvoaK4RRP2zE8Z8SxMQdAxE=;
        b=XomTaWJeGugNqXCN3KdwQaW3/y/ia8o4ZO+QtKu3pTLhuCl8eLp5sfo8ncj70y/yey
         eRAHuZITzM0ESAL3qXJGYZrltExyzcWBO7sQk7IwSiDI/gqbvJkCVd51FFXThwTVn7Ub
         g5k8lEpzW0ROf8cvhMddAZShHEXtmQPOQD/3Jxv57OTapGX2zk2Py8fmcY8kwTDuWH7n
         ikIweN/6LNqYD8pFU9EiQQmnyoP4UT+5zQeZ5Ka2tOQ7tAzSp77m2pBrbsPdfUCiOsOj
         a4OX+aKmYSv5i30ZZ+yvZlvUVHQNhh69BxluKEcNfbH74BBSxAis2gLDFLoTIaS5q3YS
         v6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU7OEgwigUTYS+65S+vjLAdjDWPmiYBrldMHTc3JXujISNq7CP3al/62oWQvWIuZt3JhDYrshz+lork@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5BIW3ohxeMaSq7Ziu0gn3RcgMchoXG7M2TNRYtjnup24OVp3W
	Mtek0Q4vGP891SsLB9TsAa+DuQKblJ35aBsJdwdEj/IWhmql+lbohWWIXjl3rToVEwo=
X-Gm-Gg: ASbGncs5lyFZjusXNfwFAsfbyNszjSo/uS8sfa+nP5N87C+oFzjclgWjMFZuaFL+M7X
	k5hUw4jE2cjmwf9aaGkiMFd8HkYQcEPqhT+zTgK/9dNbjgPuwpbnvTCaVRNeJDAAIHqLeYIlXUl
	Sl2A9T67zf2mMMrYd+37m6Fh74NsWdXRx7qZbeCi3oV8yNkYzk23hg3AIU190UghWwkOYT8Qfph
	54N9NW5zDkEjl3z5IEKw+FYtblo+ZDOCZTBvc32iffug9EAfgyW83WhvsMjjoQhCpLnx7hrKwD0
	VXUCA8lq6r9dVtrGMKkwB6pAC66GeRu4ChLgDtDAS5C06voijcIcdheI5ZrA3yB2de6bzF9U0WK
	34DlF3vQo0458pKe5F7dhX8YL+PK0duAgCRKBO1/nTYxiDR5lVxm+JfpxrsK9h57qLjvnvAkqhJ
	AdVirY0FjCnxxvpUoIt5J5SKXPTwQQKCZMDmOc6n11dA==
X-Google-Smtp-Source: AGHT+IGis1f6KspkvOM2VBXvQEdi5glaA2doxCZeF0Ob2aKVUNq/AVWKalRTwQc42pJMi4xLulDIzA==
X-Received: by 2002:a05:7022:f8c:b0:11b:9386:825d with SMTP id a92af1059eb24-11e032c9b59mr10189100c88.42.1765302562406;
        Tue, 09 Dec 2025 09:49:22 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-11df7573508sm52718771c88.3.2025.12.09.09.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:49:22 -0800 (PST)
Date: Tue, 9 Dec 2025 09:49:20 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>,
	Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <20251209174920.GF337106-mkhalfella@purestorage.com>
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
 <20251205211738.1872244-2-mkhalfella@purestorage.com>
 <eb03af5f-6371-4e3b-acfc-9c3d75403d18@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb03af5f-6371-4e3b-acfc-9c3d75403d18@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_094924_207201_AEA9364F 
X-CRM114-Status: GOOD (  38.64  )
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

On Tue 2025-12-09 08:30:23 +0100, Hannes Reinecke wrote:
> On 12/5/25 22:17, Mohamed Khalfella wrote:
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
> >    __schedule+0x47c/0xbb0
> >    ? timerqueue_add+0x66/0xb0
> >    schedule+0x1c/0xa0
> >    schedule_preempt_disabled+0xa/0x10
> >    __mutex_lock.constprop.0+0x271/0x600
> >    blk_mq_quiesce_tagset+0x25/0xc0
> >    nvme_dev_disable+0x9c/0x250
> >    nvme_timeout+0x1fc/0x520
> >    blk_mq_handle_expired+0x5c/0x90
> >    bt_iter+0x7e/0x90
> >    blk_mq_queue_tag_busy_iter+0x27e/0x550
> >    ? __blk_mq_complete_request_remote+0x10/0x10
> >    ? __blk_mq_complete_request_remote+0x10/0x10
> >    ? __call_rcu_common.constprop.0+0x1c0/0x210
> >    blk_mq_timeout_work+0x12d/0x170
> >    process_one_work+0x12e/0x2d0
> >    worker_thread+0x288/0x3a0
> >    ? rescuer_thread+0x480/0x480
> >    kthread+0xb8/0xe0
> >    ? kthread_park+0x80/0x80
> >    ret_from_fork+0x2d/0x50
> >    ? kthread_park+0x80/0x80
> >    ret_from_fork_asm+0x11/0x20
> > 
> >    __schedule+0x47c/0xbb0
> >    ? xas_find+0x161/0x1a0
> >    schedule+0x1c/0xa0
> >    blk_mq_freeze_queue_wait+0x3d/0x70
> >    ? destroy_sched_domains_rcu+0x30/0x30
> >    blk_mq_update_tag_set_shared+0x44/0x80
> >    blk_mq_exit_queue+0x141/0x150
> >    del_gendisk+0x25a/0x2d0
> >    nvme_ns_remove+0xc9/0x170
> >    nvme_remove_namespaces+0xc7/0x100
> >    nvme_remove+0x62/0x150
> >    pci_device_remove+0x23/0x60
> >    device_release_driver_internal+0x159/0x200
> >    unbind_store+0x99/0xa0
> >    kernfs_fop_write_iter+0x112/0x1e0
> >    vfs_write+0x2b1/0x3d0
> >    ksys_write+0x4e/0xb0
> >    do_syscall_64+0x5b/0x160
> >    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > 
> > The top stacktrace is showing nvme_timeout() called to handle nvme
> > command timeout. timeout handler is trying to disable the controller and
> > as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> > to call queue callback handlers. The thread is stuck waiting for
> > set->tag_list_lock as it tries to walk the queues in set->tag_list.
> > 
> > The lock is held by the second thread in the bottom stack which is
> > waiting for one of queues to be frozen. The queue usage counter will
> > drop to zero after nvme_timeout() finishes, and this will not happen
> > because the thread will wait for this mutex forever.
> > 
> > Given that [un]quiescing queue is an operation that does not need to
> > sleep, update blk_mq_[un]quiesce_tagset() to use RCU instead of taking
> > set->tag_list_lock, update blk_mq_{add,del}_queue_tag_set() to use RCU
> > safe list operations. Also, delete INIT_LIST_HEAD(&q->tag_set_list)
> > in blk_mq_del_queue_tag_set() because we can not re-initialize it while
> > the list is being traversed under RCU. The deleted queue will not be
> > added/deleted to/from a tagset and it will be freed in blk_free_queue()
> > after the end of RCU grace period.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > ---
> >   block/blk-mq.c | 17 ++++++++---------
> >   1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index d626d32f6e57..05db3d20783f 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
> >   {
> >   	struct request_queue *q;
> >   
> > -	mutex_lock(&set->tag_list_lock);
> > -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
> >   		if (!blk_queue_skip_tagset_quiesce(q))
> >   			blk_mq_quiesce_queue_nowait(q);
> >   	}
> > -	mutex_unlock(&set->tag_list_lock);
> > +	rcu_read_unlock();
> >   
> >   	blk_mq_wait_quiesce_done(set);
> >   }
> > @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
> >   {
> >   	struct request_queue *q;
> >   
> > -	mutex_lock(&set->tag_list_lock);
> > -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
> >   		if (!blk_queue_skip_tagset_quiesce(q))
> >   			blk_mq_unquiesce_queue(q);
> >   	}
> > -	mutex_unlock(&set->tag_list_lock);
> > +	rcu_read_unlock();
> >   }
> >   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
> >   
> > @@ -4294,7 +4294,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
> >   	struct blk_mq_tag_set *set = q->tag_set;
> >   
> >   	mutex_lock(&set->tag_list_lock);
> > -	list_del(&q->tag_set_list);
> > +	list_del_rcu(&q->tag_set_list);
> >   	if (list_is_singular(&set->tag_list)) {
> >   		/* just transitioned to unshared */
> >   		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> > @@ -4302,7 +4302,6 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
> >   		blk_mq_update_tag_set_shared(set, false);
> >   	}
> >   	mutex_unlock(&set->tag_list_lock);
> > -	INIT_LIST_HEAD(&q->tag_set_list);
> >   }
> >   
> I'm ever so sceptical whether we can remove the INIT_LIST_HEAD() here.
> If we can it was pointless to begin with, but I somehow doubt that.
> Do you have a rationale for that (except from the fact that you
> are moving to RCU, and hence the 'q' pointer might not be valid then).
> 
I think it was pointless to begin with. 'q' is on its way to be freed.
q->tag_set_list is not going to be used again.

