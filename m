Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F68606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gRKq/QeJ;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AUwg25pg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UIK6awfsUUnEirWM+pML4r2uF2D7CC1jg4s4UcHucsY=; b=gRKq/QeJyNLRgP
	5jdNJw+bpFmegTRdVlMWUNN1TDWk/skvKuV3tfohjB89/JvXw9gpbnqASA1txMgPSb+QBdeUumLNZ
	vsdOPVwzGxy4lgslTAKWoHvlmqNuU93IzVpRb0Wa42N+XXYJF9Vv/ckoIU3jR9AfefR8DdD0UbFvu
	M05ksGtB/tqcQC84VWB6JK+yTUWZB5CsCPunudP7tiFxTDm1dDEDWs74a1CGc4gbZpKRuFQNWra7w
	RNkRtvwhePC8NgTcyLF0Rwv9ZvcuM0PpNI6Hu8APK7gNmPPvMq3u9Rx5cRkHmSLEnPpfY5ZjnDUbK
	2haAGNd2j+N+xKaX154g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLbHO-00000003t2W-2RSQ;
	Tue, 27 Oct 2026 07:07:30 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLbHK-00000003t29-1zKI
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 07:07:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793084840; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UIK6awfsUUnEirWM+pML4r2uF2D7CC1jg4s4UcHucsY=;
	b=AUwg25pgjuTDq04VIjJPD8rN/B4Oj7n1qzs8T4Nlurn85pOBgU2n+LFyj/owgNUZkoSwS09uTnEW3w5CZWZ9FMDOCYCvlyyK2IDBQZxI/YnoeQNH/x8EOV+VCWvKHNEoZ2FNj0oQlxw7LDUpFRlZHrBbkLDkUzXaoocoX2ceXiY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDd1mTG_1793084838;
Received: from 30.178.69.81(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDd1mTG_1793084838 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 15:07:19 +0800
Message-ID: <d9bfad39-8f3d-4c26-a3e6-f0b268fc0b4f@linux.alibaba.com>
Date: Tue, 27 Oct 2026 15:07:16 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Validate the queue state under the queue lock
 in the address attribute
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261026105532.3688128-1-kanie@linux.alibaba.com>
 <fd85a538-14c0-4186-80d6-e755b190530c@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <fd85a538-14c0-4186-80d6-e755b190530c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_000727_289305_9F0E97D3 
X-CRM114-Status: GOOD (  20.04  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-25.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/27 00:09, Nilay Shroff 写道:
> On 10/26/26 4:25 PM, Guixin Liu wrote:
>> Reading the "address" sysfs attribute calls kernel_getsockname() on the
>> admin queue socket, which can race with the queue teardown during
>> connection error recovery: a reader can observe NVME_TCP_Q_LIVE set,
>> then block on the queue lock while nvme_tcp_free_queue() releases the
>> socket and clears queue->sock without holding the lock.  Once the
>> reader acquires the lock it dereferences the NULL socket pointer.
>>
>> Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
>> error recovery") had the queue liveness check inside the lock.
>> Commit 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock
>> and destroy") moved it back out because the lock itself is destroyed
>> in nvme_tcp_free_queue(), so a reader arriving late trips
>> mutex_destroy().
>>
>> Check the queue liveness inside the queue lock, and clear queue->sock
>> under the same lock.  The teardown clears NVME_TCP_Q_LIVE under the
>> lock well before the socket is released, so a reader either sees the
>> bit cleared or a socket that cannot be released while it holds the
>> lock.  To also close the lock lifetime race, the queue locks are now
>> owned by the controller: they are initialized with the queue array and
>> only destroyed when the controller is freed, which cannot happen while
>> a sysfs attribute read is still in progress.
>>
>> Fixes: 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock and destroy")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/host/tcp.c | 43 ++++++++++++++++++++++++++++-------------
>>   1 file changed, 30 insertions(+), 13 deletions(-)
>>
>
> [...]
>
>> @@ -2627,6 +2632,7 @@ static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
>>   static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
>>   {
>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>> +    int i;
>>         if (list_empty_careful(&ctrl->list))
>>           goto free_ctrl;
>> @@ -2637,6 +2643,8 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
>>         nvmf_free_options(nctrl->opts);
>>   free_ctrl:
>> +    for (i = 0; i < ctrl->ctrl.queue_count; i++)
>> +        mutex_destroy(&ctrl->queues[i].queue_lock);
>
> What if in case ctrl->ctrl.queue_count changes during the lifetime
> of connection? I think in case num of queues changes during reconnect
> then ctrl.queue_count would not represent the initial value of the
> num of queues. 
Good catch, but this is not a bug, the queue_count will only be turn down,
so will not destroy an uninitialized mutex, and undestroyed mutex doesn't
cause any memory leak.

But, any way, I will send a v2 to fix this, use nctrl->opts->nr_io_queues +
nctrl->opts->nr_write_queues + nctrl->opts->nr_poll_queues + 1 to find the
initial queue_count to destroy all initialized mutex.

Best Regards,
Guixin Liu
>
> Thanks,
> --Nilay


