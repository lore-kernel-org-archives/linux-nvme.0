Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889D6C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HdrKvVpzoK2/io6dzoi9dKxwlHJ6zEY7Dwf6tEzdqM4=; b=JU2AWKnLyVU2/RG9qOXgd71gJb
	1rmvxzO2z7AAzr1hqq/Ea2e+zIgEEDP9C/14qIB2hckCireKhnWfINETZi6vldPpoKd399s/Od5tU
	ZEVfBDyZDf4Lef/T7eQe0RIQU0+s92kG73Lr6VNOWNR1rXCbryb1v4/hhdnkm28jVRdoZ4B/RzzA9
	tTD5qip4whpNrnTIhrHI/hLN6AMEdBzn8PxnX4mIPUNT+N5DUSEnyxbcl/YbzNg0ROqZiPMOQmRgz
	Y+qgVpAWdHRJTf8gyzu/Qf7+zVTPP8CN40W9Co05Py4b3lgHtuQoYBa0My7CCDne91rF5zxYVaKiU
	WnlfM77w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQnia-00000003paB-2K39;
	Mon, 08 Jul 2024 12:43:44 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQniV-00000003pYG-105m
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 12:43:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13DDC1F442;
	Mon,  8 Jul 2024 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720442615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdrKvVpzoK2/io6dzoi9dKxwlHJ6zEY7Dwf6tEzdqM4=;
	b=zXlkvFkDOBVRF14VtHueSMz2dGjG68hkQRwu1dccoMRNZawQ4xaydd9zftV33YU/NRo7sK
	TVqAKw3p5ifOqY6herIIh8otpxtrHfqIylL4YYBeuL5rK1fyqGZzYE5bZ8I70evoZ1XppE
	nzPi+9F8mdBMAtKka5dKjLEgtdiUbwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720442615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdrKvVpzoK2/io6dzoi9dKxwlHJ6zEY7Dwf6tEzdqM4=;
	b=eYTyBDZy1ybjKm47nPnrREZ0wnstNzUnwZGaQIvd0VmNvIcsTm0/ZWxk720XvTc+j34IO3
	bUR4LmEQzNk9ubDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720442615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdrKvVpzoK2/io6dzoi9dKxwlHJ6zEY7Dwf6tEzdqM4=;
	b=zXlkvFkDOBVRF14VtHueSMz2dGjG68hkQRwu1dccoMRNZawQ4xaydd9zftV33YU/NRo7sK
	TVqAKw3p5ifOqY6herIIh8otpxtrHfqIylL4YYBeuL5rK1fyqGZzYE5bZ8I70evoZ1XppE
	nzPi+9F8mdBMAtKka5dKjLEgtdiUbwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720442615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdrKvVpzoK2/io6dzoi9dKxwlHJ6zEY7Dwf6tEzdqM4=;
	b=eYTyBDZy1ybjKm47nPnrREZ0wnstNzUnwZGaQIvd0VmNvIcsTm0/ZWxk720XvTc+j34IO3
	bUR4LmEQzNk9ubDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAFE81396E;
	Mon,  8 Jul 2024 12:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QN+FN/bei2aUcAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Jul 2024 12:43:34 +0000
Message-ID: <072f0e6b-8827-4b04-a374-0cfe228bd9d4@suse.de>
Date: Mon, 8 Jul 2024 14:43:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-tcp: align I/O cpu with blk-mq mapping
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-3-hare@kernel.org>
 <a089cc30-fe38-46fe-b953-83a8ada222fd@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a089cc30-fe38-46fe-b953-83a8ada222fd@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_054339_458310_318C87B5 
X-CRM114-Status: GOOD (  31.60  )
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

On 7/8/24 14:08, Sagi Grimberg wrote:
> 
> 
> On 08/07/2024 10:10, Hannes Reinecke wrote:
>> We should align the 'io_cpu' setting with the blk-mq
>> cpu mapping to ensure that we're not bouncing threads
>> when doing I/O. To avoid cpu contention this patch also
>> adds an atomic counter for the number of queues on each
>> cpu to distribute the load across all CPUs in the blk-mq cpu set.
>> Additionally we should always set the 'io_cpu' value, as
>> in the WQ_UNBOUND case it'll be treated as a hint anyway.
>>
>> Performance comparison:
>>                 baseline rx/tx    blk-mq align
>> 4k seq write:  449MiB/s 480MiB/s 524MiB/s
>> 4k rand write: 410MiB/s 481MiB/s 524MiB/s
>> 4k seq read:   478MiB/s 481MiB/s 566MiB/s
>> 4k rand read:  547MiB/s 480MiB/s 511MiB/s
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 65 +++++++++++++++++++++++++++++++----------
>>   1 file changed, 49 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index f621d3ba89b2..a5c42a7b4bee 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -26,6 +26,8 @@
>>   struct nvme_tcp_queue;
>> +static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
>> +
>>   /* Define the socket priority to use for connections were it is 
>> desirable
>>    * that the NIC consider performing optimized packet processing or 
>> filtering.
>>    * A non-zero value being sufficient to indicate general 
>> consideration of any
>> @@ -1578,20 +1580,42 @@ static bool nvme_tcp_poll_queue(struct 
>> nvme_tcp_queue *queue)
>>   static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>>   {
>>       struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>> -    int qid = nvme_tcp_queue_id(queue);
>> -    int n = 0;
>> -
>> -    if (nvme_tcp_default_queue(queue))
>> -        n = qid - 1;
>> -    else if (nvme_tcp_read_queue(queue))
>> -        n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] - 1;
>> -    else if (nvme_tcp_poll_queue(queue))
>> +    struct blk_mq_tag_set *set = &ctrl->tag_set;
>> +    int qid = nvme_tcp_queue_id(queue) - 1;
> 
> umm, its not the qid, why change it? I mean it looks harmless, but
> I don't see why.
> 
>> +    unsigned int *mq_map = NULL;;
>> +    int n = 0, cpu, io_cpu, min_queues = WORK_CPU_UNBOUND;
> 
> min_queues initialization looks very very weird. I can't even parse it.
> besides, why is it declared in this scope?
> 
Because it's evaluated in the loop, with the value carried over across
loop iterations.
WORK_CPU_UNBOUND is the init value, to detect if it had been set at all.

>> +
>> +    if (nvme_tcp_default_queue(queue)) {
>> +        mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
>> +        n = qid;
>> +    } else if (nvme_tcp_read_queue(queue)) {
>> +        mq_map = set->map[HCTX_TYPE_READ].mq_map;
>> +        n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT];
>> +    } else if (nvme_tcp_poll_queue(queue)) {
>> +        mq_map = set->map[HCTX_TYPE_POLL].mq_map;
>>           n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
>> -                ctrl->io_queues[HCTX_TYPE_READ] - 1;
>> -    if (wq_unbound)
>> -        queue->io_cpu = WORK_CPU_UNBOUND;
>> -    else
>> -        queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, 
>> false);
>> +                ctrl->io_queues[HCTX_TYPE_READ];
>> +    }
>> +
>> +    if (WARN_ON(!mq_map))
>> +        return;
>> +    for_each_online_cpu(cpu) {
>> +        int num_queues;
>> +
>> +        if (mq_map[cpu] != qid)
>> +            continue;
>> +        num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
>> +        if (num_queues < min_queues) {
>> +            min_queues = num_queues;
>> +            io_cpu = cpu;
>> +        }
>> +    }
>> +    if (io_cpu != queue->io_cpu) {
>> +        queue->io_cpu = io_cpu;
>> +        atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
>> +    }
> 
> Why is that conditioned ? why not always assign and inc the counter?
> 
Because we're having the conditional

if (mq_map[cpu] != qid)

above, so technically we might not find the correct mapping.
Might be worthwhile doing a WARN_ON() here, but it might trigger
with CPU hotplug...

>> +    dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
>> +        qid, queue->io_cpu);
>>   }
>>   static void nvme_tcp_tls_done(void *data, int status, key_serial_t 
>> pskid)
>> @@ -1735,7 +1759,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl 
>> *nctrl, int qid,
>>       queue->sock->sk->sk_allocation = GFP_ATOMIC;
>>       queue->sock->sk->sk_use_task_frag = false;
>> -    nvme_tcp_set_queue_io_cpu(queue);
>> +    queue->io_cpu = WORK_CPU_UNBOUND;
>>       queue->request = NULL;
>>       queue->data_remaining = 0;
>>       queue->ddgst_remaining = 0;
>> @@ -1847,6 +1871,10 @@ static void __nvme_tcp_stop_queue(struct 
>> nvme_tcp_queue *queue)
>>       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>>       nvme_tcp_restore_sock_ops(queue);
>>       cancel_work_sync(&queue->io_work);
>> +    if (queue->io_cpu != WORK_CPU_UNBOUND) {
>> +        atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
>> +        queue->io_cpu = WORK_CPU_UNBOUND;
>> +    }
> 
> Does anything change if we still set the io_cpu in wq_unbound case?
> If not, I think we should always do it and simplify the code.
> 
See above. WORK_CPU_UNBOUND means that we failed to find the cpu
in the mq_map. Yes, I know, unlikely, but not impossible.

>>   }
>>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
>> @@ -1891,9 +1919,10 @@ static int nvme_tcp_start_queue(struct 
>> nvme_ctrl *nctrl, int idx)
>>       nvme_tcp_init_recv_ctx(queue);
>>       nvme_tcp_setup_sock_ops(queue);
>> -    if (idx)
>> +    if (idx) {
>> +        nvme_tcp_set_queue_io_cpu(queue);
>>           ret = nvmf_connect_io_queue(nctrl, idx);
>> -    else
>> +    } else
>>           ret = nvmf_connect_admin_queue(nctrl);
>>       if (!ret) {
>> @@ -2920,6 +2949,7 @@ static struct nvmf_transport_ops 
>> nvme_tcp_transport = {
>>   static int __init nvme_tcp_init_module(void)
>>   {
>>       unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
>> +    int cpu;
>>       BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
>>       BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
>> @@ -2937,6 +2967,9 @@ static int __init nvme_tcp_init_module(void)
>>       if (!nvme_tcp_wq)
>>           return -ENOMEM;
>> +    for_each_possible_cpu(cpu)
>> +        atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
>> +
> 
> Why?

Don't we need to initialize the atomic counters?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


