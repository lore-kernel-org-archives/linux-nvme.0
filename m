Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69B4D1CDC6
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 04:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0nbVlvCnhTFfBFfYizweUOs3ZcBOdqLEtYuSExW8Bpk=; b=dQQRvuGdvolnnvNc8C/lPwh3Z1
	JONAxBokBK/b1XTE2fCa2jpsI9s9hCCAGWtl1gkrOkTl3x4VXRrYZbiIbwzaEEE1yPTEcuri8/+ed
	kwJ8ZKdgQnOdUHSQs3mkBeun48j2ddc6LCGq3vCm2wYu1cIva6Gg85VvYBs4BmQoyfN2bGmP9mxKz
	xaKtckVSuVYrkPfvSp0RSDTeGLtdgrnCFms5lV0N8C67tqOkir3qPlwV94BvraLAmnJVlVgxaU0pX
	r4EUJIsRxkp8b62An0sAI4TTHiPam+2qEIS6Vw0Lan02rNInItjIiaDzA1Mkp5j4Zwfsm/8FTwO6p
	jLyiguIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSoxx-0000000DnIK-3ckQ;
	Tue, 09 Dec 2025 04:04:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSoxu-0000000DnHy-0Ta4
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 04:04:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765253079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0nbVlvCnhTFfBFfYizweUOs3ZcBOdqLEtYuSExW8Bpk=;
	b=doqhGbvg4Z3CYIR1b8eDKGYaXO5MvnWFUZja4y3O+GWzG/ZSGySAWLHU+d+bZZLV9qS9eH
	Mpvv3JBXHyDdPCWw1pa3hl6FXIt0/txvwduM9qsz4vkO7T0ZMABNOAORpjWpF8wII+jeTc
	gL/R4kACIogditFTCvDG2RUuuTabqJs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-Un38cTO2P-6ZqPGHjICTLA-1; Mon,
 08 Dec 2025 23:04:34 -0500
X-MC-Unique: Un38cTO2P-6ZqPGHjICTLA-1
X-Mimecast-MFC-AGG-ID: Un38cTO2P-6ZqPGHjICTLA_1765253072
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90FE11800637;
	Tue,  9 Dec 2025 04:04:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.98])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5ACE3180044F;
	Tue,  9 Dec 2025 04:04:22 +0000 (UTC)
Date: Tue, 9 Dec 2025 12:04:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Waiman Long <llong@redhat.com>,
	Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <aTefwg_T2CTcl6vw@fedora>
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
 <20251205211738.1872244-2-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205211738.1872244-2-mkhalfella@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_200442_224048_715614DA 
X-CRM114-Status: GOOD (  23.70  )
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

On Fri, Dec 05, 2025 at 01:17:02PM -0800, Mohamed Khalfella wrote:
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
>   __schedule+0x47c/0xbb0
>   ? timerqueue_add+0x66/0xb0
>   schedule+0x1c/0xa0
>   schedule_preempt_disabled+0xa/0x10
>   __mutex_lock.constprop.0+0x271/0x600
>   blk_mq_quiesce_tagset+0x25/0xc0
>   nvme_dev_disable+0x9c/0x250
>   nvme_timeout+0x1fc/0x520
>   blk_mq_handle_expired+0x5c/0x90
>   bt_iter+0x7e/0x90
>   blk_mq_queue_tag_busy_iter+0x27e/0x550
>   ? __blk_mq_complete_request_remote+0x10/0x10
>   ? __blk_mq_complete_request_remote+0x10/0x10
>   ? __call_rcu_common.constprop.0+0x1c0/0x210
>   blk_mq_timeout_work+0x12d/0x170
>   process_one_work+0x12e/0x2d0
>   worker_thread+0x288/0x3a0
>   ? rescuer_thread+0x480/0x480
>   kthread+0xb8/0xe0
>   ? kthread_park+0x80/0x80
>   ret_from_fork+0x2d/0x50
>   ? kthread_park+0x80/0x80
>   ret_from_fork_asm+0x11/0x20
> 
>   __schedule+0x47c/0xbb0
>   ? xas_find+0x161/0x1a0
>   schedule+0x1c/0xa0
>   blk_mq_freeze_queue_wait+0x3d/0x70
>   ? destroy_sched_domains_rcu+0x30/0x30
>   blk_mq_update_tag_set_shared+0x44/0x80
>   blk_mq_exit_queue+0x141/0x150
>   del_gendisk+0x25a/0x2d0
>   nvme_ns_remove+0xc9/0x170
>   nvme_remove_namespaces+0xc7/0x100
>   nvme_remove+0x62/0x150
>   pci_device_remove+0x23/0x60
>   device_release_driver_internal+0x159/0x200
>   unbind_store+0x99/0xa0
>   kernfs_fop_write_iter+0x112/0x1e0
>   vfs_write+0x2b1/0x3d0
>   ksys_write+0x4e/0xb0
>   do_syscall_64+0x5b/0x160
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> The top stacktrace is showing nvme_timeout() called to handle nvme
> command timeout. timeout handler is trying to disable the controller and
> as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> to call queue callback handlers. The thread is stuck waiting for
> set->tag_list_lock as it tries to walk the queues in set->tag_list.
> 
> The lock is held by the second thread in the bottom stack which is
> waiting for one of queues to be frozen. The queue usage counter will
> drop to zero after nvme_timeout() finishes, and this will not happen
> because the thread will wait for this mutex forever.
> 
> Given that [un]quiescing queue is an operation that does not need to
> sleep, update blk_mq_[un]quiesce_tagset() to use RCU instead of taking
> set->tag_list_lock, update blk_mq_{add,del}_queue_tag_set() to use RCU
> safe list operations. Also, delete INIT_LIST_HEAD(&q->tag_set_list)
> in blk_mq_del_queue_tag_set() because we can not re-initialize it while
> the list is being traversed under RCU. The deleted queue will not be
> added/deleted to/from a tagset and it will be freed in blk_free_queue()
> after the end of RCU grace period.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


