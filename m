Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038B4CCF2D3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 11:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LgnfQ8wTBplOdukELUJAbNGTXtmsm4PBQs4E3Txr/1U=; b=oZHGQKl7u5vTEMtRnoHmaAYEgW
	h2zlqfKDYETdKujg3n3PgJAzSLUAkRf8a/r2I7rHBjDnoCrhFFbIY7MC1SwGKcyloCYTNwobuGK7W
	rZbcDDw8xjeVpIGBaxiO7N9HLOi3S0uh3h2QJorxaVu+tTWyXBqmm6W5nTbdtj4GPhHF5qS7sidjp
	FhLCZqbD36Xca5LX8nhPXS7qAUT1t0Dsnlnpe/DrsAbHhn9llKltghp+BIP9CCd8DKp96BOlvxiiu
	csRwE7W/kfBVlqTPC4/HHEZa53Uk/M1yxiq4t791dZFBdCpXXhz1lk7EhUFH8ZVvy6IMx3kSPakGh
	m7kBSItQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIlJ7-00000007GWq-3i3e;
	Mon, 19 Oct 2026 11:13:33 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIlJ4-00000007GWR-2y59
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 11:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792408407; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LgnfQ8wTBplOdukELUJAbNGTXtmsm4PBQs4E3Txr/1U=;
	b=K35Z9mjlFcRW6zySyej+M0mEpHVnP3Z1GFGRla0Stjd1xNgiIDNzqD4EQtouZNmeE6nYmDbH1VDpPAOhV881oWahF+xxj65jZUpepNDVdC2203SfbaVqmeJ5bhnqGZdBttXixmKr5bgIJ/cT9D3C4eKk6JUZK6VFXpdDUjooI+w=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XD68rJ0_1792408402;
Received: from 30.178.69.0(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD68rJ0_1792408402 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 19:13:23 +0800
Message-ID: <acd6eee9-dadb-48e3-9a9d-232a268472d8@linux.alibaba.com>
Date: Mon, 19 Oct 2026 19:13:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme: document the service-time iopolicy sysfs
 attributes
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261019075607.808947-1-kanie@linux.alibaba.com>
 <20261019075607.808947-4-kanie@linux.alibaba.com>
 <sashiko-outbox-176783@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-176783@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_041331_071920_212D61A0 
X-CRM114-Status: GOOD (  28.13  )
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



在 2026/10/19 16:13, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] nvme-multipath: nvme_failover_req() clears rq bytes before in_flight_size sub
> - [High] nvme-multipath: in_flight_size underflow in nvme_mpath_end_request()
> - [Low] nvme: missing service-time in sysfs-nvme iopolicy ABI documentation
> --
>
> commit 5acf4057a11f40dc3e2cd32f04002286c4084ff4
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvme: document the service-time iopolicy sysfs attributes
>
> This commit documents the new in_flight_bytes and relative_throughput sysfs
> attributes added for the service-time NVMe multipath I/O policy in
> Documentation/ABI/stable/sysfs-nvme.
>
>> diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
>> index a2f5d0710db40..adaf292c8c67b 100644
>> --- a/Documentation/ABI/stable/sysfs-nvme
>> +++ b/Documentation/ABI/stable/sysfs-nvme
>> @@ -326,6 +326,28 @@ Description:
>>  		currently selected path. Returns empty if iopolicy is not
>>  		"numa". Requires CONFIG_NVME_MULTIPATH.
>>  
>> +What:		/sys/block/nvmeXcYnZ/in_flight_bytes
>> +What:		/sys/block/nvmeXcYnZ/relative_throughput
>> +Date:		October 2026
>> +KernelVersion:	7.5
>> +Contact:	Guixin Liu <kanie@linux.alibaba.com>
>> +Description:
>> +		in_flight_bytes: Shows the number of bytes currently in
>> +		flight on this path's controller. Returns empty if
>> +		iopolicy is not "service-time".
>> +		Requires CONFIG_NVME_MULTIPATH.
> [Severity: High]
> Can ns->ctrl->in_flight_size permanently leak in-flight bytes when a
> request fails over in nvme_failover_req()?
>
> In commit 211891d7cca0 ("nvme-multipath: implement service-time iopolicy"),
> nvme_mpath_start_request() adds blk_rq_bytes(rq) to ns->ctrl->in_flight_size
> and sets NVME_MPATH_CNT_ACTIVE_BYTES:
>
> drivers/nvme/host/multipath.c:nvme_mpath_start_request() {
> 	...
> 	} else if (iopolicy == NVME_IOPOLICY_ST &&
> 		   !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE_BYTES)) {
> 		atomic64_add(blk_rq_bytes(rq), &ns->ctrl->in_flight_size);
> 		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE_BYTES;
> 	}
> }
>
> When a request fails over (for example, on NVME_SC_ANA_TRANSITION,
> NVME_SC_HOST_PATH_ERROR, or a dying queue), __nvme_complete_rq() calls
> nvme_failover_req(), which steals the bios from req before calling
> nvme_end_req():
>
> drivers/nvme/host/multipath.c:nvme_failover_req() {
> 	...
> 	blk_steal_bios(&ns->head->requeue_list, req);
> 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>
> 	nvme_req(req)->status = 0;
> 	nvme_end_req(req);
> }
>
> Because blk_steal_bios() clears rq->__data_len:
>
> block/blk-mq.c:blk_steal_bios() {
> 	...
> 	rq->__data_len = 0;
> }
>
> by the time nvme_end_req() -> __nvme_end_req() -> nvme_mpath_end_request()
> runs:
>
> drivers/nvme/host/multipath.c:nvme_mpath_end_request() {
> 	...
> 	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE_BYTES) {
> 		atomic64_sub(blk_rq_bytes(rq), &ns->ctrl->in_flight_size);
> 		nvme_req(rq)->flags &= ~NVME_MPATH_CNT_ACTIVE_BYTES;
> 	}
> }
>
> blk_rq_bytes(rq) is 0, so the failed-over request's bytes are never
> subtracted from ns->ctrl->in_flight_size. When failover occurs without a
> controller reset, does ns->ctrl->in_flight_size remain permanently
> inflated, skewing nvme_st_compare_load() and the in_flight_bytes sysfs
> attribute?
Right, fixed in v3.
>
> [Severity: High]
> Also in nvme_mpath_end_request(), can ns->ctrl->in_flight_size underflow
> to a negative value if a requeued request completes after a controller
> reset?
>
> When a request started under NVME_IOPOLICY_ST is requeued via
> nvme_retry_req() -> blk_mq_requeue_request() (or via BLK_STS_RESOURCE after
> nvme_start_request() in nvme_rdma_queue_rq() or nvme_fc_start_fcp_op()),
> the request returns to MQ_RQ_IDLE while retaining RQF_DONTPREP and
> NVME_MPATH_CNT_ACTIVE_BYTES.
>
> If a controller reset occurs before that request is re-dispatched,
> nvme_mpath_init_identify() resets ctrl->in_flight_size to 0:
>
> drivers/nvme/host/multipath.c:nvme_mpath_init_identify() {
> 	...
> 	/* initialize this in the identify path to cover controller resets */
> 	atomic_set(&ctrl->nr_active, 0);
> 	atomic64_set(&ctrl->in_flight_size, 0);
> }
>
> When the request is later re-dispatched, nvme_setup_cmd() skips
> nvme_clear_nvme_request() because RQF_DONTPREP is set, and
> nvme_mpath_start_request() skips atomic64_add() because
> NVME_MPATH_CNT_ACTIVE_BYTES is already set. When the request finishes,
> nvme_mpath_end_request() unconditionally subtracts blk_rq_bytes(rq) from
> ns->ctrl->in_flight_size (unlike nr_active, which uses
> atomic_dec_if_positive()), driving ctrl->in_flight_size negative.
>
> In nvme_st_compare_load(), the negative s64 is then assigned to unsigned
> size_t:
>
> drivers/nvme/host/multipath.c:nvme_st_compare_load() {
> 	size_t sz1, sz2, st1, st2;
> 	unsigned int tp1 = ns1->ctrl->relative_throughput;
> 	unsigned int tp2 = ns2->ctrl->relative_throughput;
>
> 	sz1 = atomic64_read(&ns1->ctrl->in_flight_size);
> 	sz2 = atomic64_read(&ns2->ctrl->in_flight_size);
>
> Would this wrap sz1 or sz2 to near SIZE_MAX, causing
> nvme_service_time_path() to avoid that controller's path while reporting a
> negative value in in_flight_bytes?
Yes, fixed in v3.
>> +
>> +		relative_throughput: Shows or sets the relative
>> +		throughput weight of this path, which the "service-time"
>> +		iopolicy uses to estimate the path service time as
>> +		in_flight_bytes / relative_throughput. The value is an
>> +		integer in the range 0-100 and defaults to 1; assign
>> +		higher values to faster paths. A path with a value of 0
>> +		is only selected when no path with a positive value is
>> +		available. Reading returns empty if iopolicy is not
>> +		"service-time"; writing is accepted regardless of the
>> +		active policy. Requires CONFIG_NVME_MULTIPATH.
>> +
>>  What:		/sys/block/nvmeXnY/delayed_removal_secs
>>  Date:		May 2025
>>  KernelVersion:	6.16
> [Severity: Low]
> In the same file (Documentation/ABI/stable/sysfs-nvme), the entry for
> /sys/class/nvme-subsystem/nvme-subsysX/iopolicy still lists only the three
> previous policies:
>
> What:		/sys/class/nvme-subsystem/nvme-subsysX/iopolicy
> ...
> Description:
> 		Shows or sets the multipath I/O path selection policy for
> 		this subsystem. Accepted values: "numa", "round-robin",
> 		"queue-depth". Changing the policy clears all current path
> 		selections. Only available when CONFIG_NVME_MULTIPATH is
> 		enabled.
>
> Should "service-time" also be added to the accepted values for
> /sys/class/nvme-subsystem/nvme-subsysX/iopolicy?
>
> هایی
Sure, changed in v3.


