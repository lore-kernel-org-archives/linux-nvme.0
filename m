Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE279606A7D9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Q9uXUTRg;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OEqnDP3T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=P4EkYqFvVS7EzpdviyY1qXcungpNT5l3HVz3FhdyQO8=; b=Q9uXUTRgInF4GP
	QKEd5ADoSeetyYgVWdbVJv4HErOiqE8ZlQ9gab1z8XuseUqH3xiqo2EOUHq0jaVQQiH96dOzzMOat
	vVr/Jzz6Dr7HpkGz2gnCEn8oqXCAIjatk53efgTW6e/V09LtZGDaHDBIjrTg28hmB5HLlJ8mRxwEi
	6zvuO6FMiaIM7f2W+3b9uSjFx8s0UDqH3hDxKbnTHeR7R50I4mt4/r5XI3XGJ1EbBIfxmNq/q9kba
	RBnLOpylX8Ynqa2YJ2ggTZlRvJ58jnuV0oblpJ8FR/NLb+VbcKgWD8HNh9l6/GF6Vd/TFNPmA7+qq
	O2uGBqR9tRpWXooBI8uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLfaC-00000004VUX-2Hr9;
	Tue, 27 Oct 2026 11:43:12 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLfaA-00000004VTn-05ro
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 11:43:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793101385; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P4EkYqFvVS7EzpdviyY1qXcungpNT5l3HVz3FhdyQO8=;
	b=OEqnDP3TVwWSJ2lbGJPeaXy2+l9lle17OPSU2Gm03mqyBDqGXGgTR0YvrN0QFOtxBJXhRYVbm6Afx+vgT4Sif+lJ9QK8yHcEsdpV1qNDpzF275nnApaA07r3HuzZD7mZ87ltxfJeoVO/FkRADAClb5XF/1EjObTydBkTNsCGo8M=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDdg1Yf_1793101384;
Received: from 30.178.69.81(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDdg1Yf_1793101384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 19:43:05 +0800
Message-ID: <96e210f2-d421-4789-9b81-379060937c0d@linux.alibaba.com>
Date: Tue, 27 Oct 2026 19:43:03 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: Validate the queue state under the queue
 lock in the address attribute
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261027073725.2292265-1-kanie@linux.alibaba.com>
 <7e73b7e7-190d-4c81-af7f-aac1c0233931@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <7e73b7e7-190d-4c81-af7f-aac1c0233931@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_044310_728609_FCF6AF11 
X-CRM114-Status: GOOD (  17.45  )
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



在 2026/10/27 19:12, Nilay Shroff 写道:
> On 10/27/26 1:07 PM, Guixin Liu wrote:
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
>> a sysfs attribute read is still in progress.  The opts-derived queue
>> count is used for both initialization and destruction, as reconnects
>> may shrink ctrl->queue_count.
>>
>> Fixes: 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock and destroy")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/host/tcp.c | 46 +++++++++++++++++++++++++++++------------
>>   1 file changed, 33 insertions(+), 13 deletions(-)
>>
> [...]
>> @@ -2627,6 +2632,10 @@ static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
>>   static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
>>   {
>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>> +    /* the same count used to size and initialize the queue array */
>> +    unsigned int nr_queues = nctrl->opts->nr_io_queues +
>> +        nctrl->opts->nr_write_queues + nctrl->opts->nr_poll_queues + 1;
>
> This looks good. However, since the same expression is used to calculate
> nr_queues during both controller allocation and freeing, would it make
> sense to define a macro for it and reuse it in both places?
Sure, changed in v3.

Best Regards,
Guixin Liu
>
> Thanks,
> --Nilay


