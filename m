Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705A606D833
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o2xaU5/u;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dEuygkRT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gmJYyuE0d206Uf4JO6Zp/OnAX/GO+m+J470bxKNY9dc=; b=o2xaU5/uBFx+gM
	t7ddii4xCIx3oiYVNENLnKuKgHXAMFvz6JipSTZ68LgbzVEHhoUk8z/XiyeOWfmAD5jTwcIpNZDOH
	aI0lsxdMuHFwK3GPyI4JgmkpirIFKY8OmhlEqgrvxKv4S8qylHeTW15OsAGEKmphw3NXWXmE20dHF
	dCBzkW49GVO1Z2J4YdiQvsVW3l5FdwbG2wnPSMZ0/FIRRlvuVJnmi8G7DiGFtjlP47FAWidKSRgtL
	Nua2tLvK0crk2x5y6QrH7oBI6FDReSMRJbL/Ep45290RwhXofm1HMtrpsFD3rlE5slvS6UNBN1nTB
	lY6OakRcCXHFOXC8gMcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHVq-0000000C1nd-2Fmi;
	Fri, 06 Nov 2026 10:49:38 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHVn-0000000C1n0-2hJo
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:49:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793962173; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gmJYyuE0d206Uf4JO6Zp/OnAX/GO+m+J470bxKNY9dc=;
	b=dEuygkRTNQirUvr8yIyC4XGkkt+eE79xAOOkR9lLIYqeiE/b5Y9YIeg8PHZZzJ2Tvrwqd6sTeF2dEodaOlv67XiirrCh55uTXECTsm6Bel6YQVvCbwN/mKAvDt1zPS8q8Rguspb733mARgl15UQ7csVWYa0L0jFkBcatrdQSv70=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEBVoLP_1793962171;
Received: from 30.178.83.72(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEBVoLP_1793962171 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 18:49:32 +0800
Message-ID: <1d7cb80b-9981-4bed-b22a-a033821cbfaa@linux.alibaba.com>
Date: Fri, 6 Nov 2026 18:49:30 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] nvme-fc: fix iterator over rport->ctrl_list in
 nvme_fc_match_disconn_ls()
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-3-kanie@linux.alibaba.com>
 <3fdebf18-946c-445e-a1d4-207c3b543558@suse.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <3fdebf18-946c-445e-a1d4-207c3b543558@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_024936_219218_23FC095F 
X-CRM114-Status: GOOD (  26.85  )
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
X-Spam-Status: No, score=-24.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/6 15:38, Hannes Reinecke 写道:
> On 11/6/26 2:58 AM, Guixin Liu wrote:
>> Commit b71cbcf7d170e ("nvme-fc: don't hold rport lock when putting ctrl")
>> switched the loop to list_for_each_entry_safe() to allow dropping the
>> rport lock for the nvme_fc_ctrl_put() of a non-matching controller.
>> But the safe iterator only protects the current entry within one
>> iteration: the next entry is cached before the body runs, and while
>> the lock is dropped that entry can run through its own final put into
>> nvme_fc_ctrl_free(), which removes it from the list and frees it.
>> The next iteration then dereferences freed memory.
>>
>> The safe variant is not needed here at all. The reference the loop
>> takes on the current entry pins it on the list until the iteration
>> moves on, so a plain list_for_each_entry() tolerates the lock drop:
>> while the lock is held the current entry cannot be unlinked, and once
>> the lock is dropped the cached ->next of the pinned entry still points
>> at a valid list member or the head.
>>
>> Switch back to the plain iterator.
>>
>> Fixes: b71cbcf7d170e ("nvme-fc: don't hold rport lock when putting ctrl")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>
>> ---
>>
>> Reproduced under KASAN in a VM through fcloop with three or more
>> controllers on one remote port, a tbkas force-reconnect racing
>> concurrent controller disconnects.  The lock-drop window was widened
>> with a test-only mdelay(200) inserted at the same place in both the
>> buggy and the fixed version so the iterator is the only variable; the
>> stock microsecond window did not trigger in 400 iterations of the
>> same workload.
>>
>>    BUG: KASAN: slab-use-after-free in nvme_fc_match_disconn_ls
>>    Read of size 8 by task kworker
>>    Workqueue: events nvme_fc_handle_ls_rqst_work
>>    Call Trace:
>>     nvme_fc_match_disconn_ls
>>     nvme_fc_ls_disconnect_assoc
>>     nvme_fc_handle_ls_rqst_work
>>     process_one_work
>>
>> The object was allocated by nvme_fc_alloc_ctrl() on connect and freed
>> by nvme_free_ctrl() on the concurrent teardown of the cached next
>> entry.  With the plain iterator the identical amplified sequence
>> reports nothing and survives; the read hits the pinned current entry,
>> which cannot be freed while the loop holds its reference.
>> ---
>>   drivers/nvme/host/fc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 0b9ff50d26ff..edf192055618 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -1470,14 +1470,14 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
>>   {
>>       struct fcnvme_ls_disconnect_assoc_rqst *rqst =
>>                       &lsop->rqstbuf->rq_dis_assoc;
>> -    struct nvme_fc_ctrl *ctrl, *tmp, *ret = NULL;
>> +    struct nvme_fc_ctrl *ctrl, *ret = NULL;
>>       struct nvmefc_ls_rcv_op *oldls = NULL;
>>       u64 association_id = be64_to_cpu(rqst->associd.association_id);
>>       unsigned long flags;
>>         spin_lock_irqsave(&rport->lock, flags);
>>   -    list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
>> +    list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
>>           if (!nvme_fc_ctrl_get(ctrl))
>>               continue;
>>           spin_lock(&ctrl->lock);
>
> Not sure here. The implication of the function is that the any controller might've been deleted during each loop iteration
> (disconnect might be triggered from both sides, either host
> _or_ controller).
> So while it's true that a controller might not get deleted while
> a reference is held, that other process might drop a reference
> to the controller while the first process is executing the loop.
> Then the call to 'nvme_fc_ctrl_put()' at the end of the loop
> will be the last reference, the controller gets deleted,
> and the ->next element becomes invalid causing the loop
> to crash.
You are right, Hannes, the issue still exists.
>
> So, no.
>
> And the issue you've described should've caused the
> nvme_fc_ctrl_get() at the start of the loop to return
> 'false'; why didn't it trigger here?
The UAF happens earlier, inside the "for" loop,
list_for_each_entry_safe() expands to "pos = n, n = list_next_entry(n)",
so at that point it already dereferences the next pointer of that ctrl
that has been freed. That why KASAN reports "Read of size 8 by task kworker"
in nvme_fc_match_disconn_ls().

By the time execution reaches nvmet_fc_ctrl_get(), the memory state is
event less clear.

I will change a v2 fix, thanks.

Best Regards,
Guixin Liu
>  
>
> Cheers,
>
> Hannes


