Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A740BCCD187
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Oct 2025 08:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q5GeQQ5L7KstxSj3TV0TOKNF3YsTWBqd1rTK/8hDiw8=; b=Hzb8fUQrDSaiP/o5MSkIFLXFc5
	LfpfkyTUujeb19B976PfqrtzQ5bBwbE5XzvxnDwpUrhVanaj4D6b/Ld2tr9l06j/2uYed94KHRxfX
	j/94y1AutrBLLiVj6ZmgChqYK6blS4w/JEzL6MykSTtUN46rPwyu2PpbkX/cu9gjCUcRt8MqO+4r5
	JgSeDpLpibSUcetzbZcmh5ipIWzvo+xr/X9vC9BPyGhwnKUfZgNqNA6cHtdNWaxJs+UkVxcn0PLRI
	BtduknaYH9knKQKpQP4HOGYbmCOL3VhV1zb0quuOnO2Q7SRuGrb6ai4U90hPdfxc5h/hgFOEV893n
	Wqxu6SDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8arE-0000000Fh01-2OU7;
	Tue, 14 Oct 2025 08:58:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8arC-0000000Fgzg-1Db1
	for linux-nvme@lists.infradead.org;
	Tue, 14 Oct 2025 08:58:11 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E7J6gu016580;
	Tue, 14 Oct 2025 08:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q5GeQQ
	5L7KstxSj3TV0TOKNF3YsTWBqd1rTK/8hDiw8=; b=QxQSqiWSjMzuRFGBYn++Ze
	LN8zSKN4v7Cf83U0dndi+282M2500Nn1/gnRq8Tc+sOiStEIUDZdKqKrQc7vLrfr
	TFzjc7pZLwKIuZ7Shc9rHguAo0QUde3CqUpPtKJwOtQx6Mr1xPI2bnSlAt6NTSu6
	5U926cCJa9McxPZZss6zwKrNHtpNnYbS68cOU/PmAarNp/j2bgDo8Wndz2oKzNSR
	SFCh/ltbL86Hl22aoF8dRtTVUBALnBRtD3xJCA+ejbr4PR3FW4xAeFka5YL605ni
	tPyaiSSbt8KLInXBmyl9L/7cuOmqjhXDjJxLWnPsWKW32QYxIlTsmWP9FmAi71kA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnr5dy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 08:58:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59E7oRMN016756;
	Tue, 14 Oct 2025 08:58:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jsyds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 08:58:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59E8w40g28770906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 08:58:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F3058045;
	Tue, 14 Oct 2025 08:58:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6611C58050;
	Tue, 14 Oct 2025 08:58:01 +0000 (GMT)
Received: from [9.109.198.148] (unknown [9.109.198.148])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 08:58:01 +0000 (GMT)
Message-ID: <6049dd46-e841-4446-9d33-09b7072249d6@linux.ibm.com>
Date: Tue, 14 Oct 2025 14:27:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 2/4] nvme-multipath: add support for adaptive I/O
 policy
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, dwagner@suse.de,
        gjoyce@ibm.com
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
 <20251009100608.1699550-3-nilay@linux.ibm.com>
 <24f76fe3-9508-4c05-976b-8be9ec9a4371@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <24f76fe3-9508-4c05-976b-8be9ec9a4371@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68ee109d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8gyeK5pOzyvbsE0He_cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: YTlwmNZCXydG5P4pSXwNaAPfyqfGhhed
X-Proofpoint-ORIG-GUID: YTlwmNZCXydG5P4pSXwNaAPfyqfGhhed
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX3WihmiJ/sk5P
 HvlSH4Bz/9XZIFzGL29cMmDYv2uj9JRVhXtcwoPyFKHKgp7AsiqiW47ELU753lc0/QWL/Jv4wvH
 yCbqyIfXdBawAk4ghvn4IM+TytwSRRjYpe+el/yF45K4TPmJDW8txdPUBiVXpHNrykoS8M/LDgc
 Rx7wOTVjWbfTguEXboNHDOm6aY/GDsF8b+GsY3AFPJjPlRU/GBIf9ZrrQQaauMapp/67h4VY1ym
 bqJrhVXmt3LY1E/f9/2CYKTxfHBdYAKMBz4bDBnkjWcchoOkmCoeTkitfa93c+imr61zW6OzIx3
 L03YUYRa86Q9aEiFMWFVF3roIQM/9vIwO4UXyBgbMkEdrZhEEoT12HLz9cNtO5hgLyS+naHTH3d
 qMRGhuA+qnmmcYbWxhfuTS8JUQZ9fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_015810_453340_0BF2190A 
X-CRM114-Status: GOOD (  51.00  )
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


>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>> index c212fa952c0f..69d2f72d0e86 100644
>> --- a/drivers/nvme/host/ioctl.c
>> +++ b/drivers/nvme/host/ioctl.c
>> @@ -711,7 +711,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
>>           flags |= NVME_IOCTL_PARTITION;
>>         srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, open_for_write ? WRITE : READ);
>>       if (!ns)
>>           goto out_unlock;
>>   @@ -742,7 +742,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>>       int srcu_idx, ret = -EWOULDBLOCK;
>>         srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, open_for_write ? WRITE : READ);
>>       if (!ns)
>>           goto out_unlock;
>>   
> Are we sure that we should account for non-IO commands here, too?
> Thing is, the I/O policy should be just that, directing I/O to the
> various paths.
> But what about commands on the admin queue? Should they be influenced by
> the same policy? And can we even define what a 'read' command is?
> Wouldn't it be better to pass in a third option here (NONE?) to make it
> clear that this is a non-I/O command?
> 
Yeah makes sense to differentiate between read/write and others here.
I think we should be able to differentiate between read/write vs others.
I'd implement this in next patchset.

>> @@ -762,7 +762,8 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>>       struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>>       struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>>       int srcu_idx = srcu_read_lock(&head->srcu);
>> -    struct nvme_ns *ns = nvme_find_path(head);
>> +    struct nvme_ns *ns = nvme_find_path(head,
>> +            ioucmd->file->f_mode & FMODE_WRITE ? WRITE : READ);
>>       int ret = -EINVAL;
>>         if (ns)
> 
> See above. I really think that we should be able to pass in a third
> option for admin commands.
Yep, as mentioned will do this in the next patchset.

> 
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 3da980dc60d9..9ecdaca5e9a0 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -6,6 +6,8 @@
>>   #include <linux/backing-dev.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/blk-mq.h>
>> +#include <linux/math64.h>
>>   #include <trace/events/block.h>
>>   #include "nvme.h"
>>  
> Ouch.
> #include <math64.h>
> always spells disaster :-)

This is included for div_u64(). Well we may replace it with usual division
operator (e.g. dividend / divisor) but that may not work well on 32-bit
architecture. 

>>   +static void nvme_mpath_weight_work(struct work_struct *weight_work)
>> +{
>> +    int cpu, srcu_idx;
>> +    u32 weight;
>> +    struct nvme_ns *ns;
>> +    struct nvme_path_stat *stat;
>> +    struct nvme_path_work *work = container_of(weight_work,
>> +            struct nvme_path_work, weight_work);
>> +    struct nvme_ns_head *head = work->ns->head;
>> +    int rw = work->rw;
>> +    u64 total_score = 0;
>> +
>> +    cpu = get_cpu();
>> +
>> +    srcu_idx = srcu_read_lock(&head->srcu);
>> +    list_for_each_entry_srcu(ns, &head->list, siblings,
>> +            srcu_read_lock_held(&head->srcu)) {
>> +
>> +        stat = &this_cpu_ptr(ns->info)[rw].stat;
>> +        if (!READ_ONCE(stat->slat_ns))
>> +            continue;
>> +        /*
>> +         * Compute the path score as the inverse of smoothed
>> +         * latency, scaled by NSEC_PER_SEC. Floating point
>> +         * math is unavailable in the kernel, so fixed-point
>> +         * scaling is used instead. NSEC_PER_SEC is chosen
>> +         * because valid latencies are always < 1 second; longer
>> +         * latencies are ignored.
>> +         */
>> +        stat->score = div_u64(NSEC_PER_SEC, READ_ONCE(stat->slat_ns));
>> +
>> +        /* Compute total score. */
>> +        total_score += stat->score;
>> +    }
>> +
>> +    if (!total_score)
>> +        goto out;
>> +
>> +    /*
>> +     * After computing the total slatency, we derive per-path weight
>> +     * (normalized to the range 0–100). The weight represents the
>> +     * relative share of I/O the path should receive.
> 
> Why do we use the range 0-100?
> While this is nice for human consumption, it doesn't lend itself to a
> nice computation. Maybe we should select a different scale to allow us
> for more efficient computation (0-128? Maybe?)
Yes we can normalize this to any range. Lets scale it from 0-128 as
you suggested, and it also aligns with power of 2.

>> +
>> +#define NVME_EWMA_SHIFT    3
> 
> And we use this value why?
Oh yeah the reason being in the proposed code we want to assign  ~87.5%
weightage to the existing (smoothed) latency and ~12.5% weightage to the 
new latency. If you see the ewma_update() then you'd realize this 
fact. But yes I'd add a comment above this macro to make the intent
clear.

> 
>> +static inline u64 ewma_update(u64 old, u64 new)
>> +{
>> +    return (old * ((1 << NVME_EWMA_SHIFT) - 1) + new) >> NVME_EWMA_SHIFT;
>> +}
>> +
>> +static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
>> +{
>> +    int cpu;
>> +    unsigned int rw;
>> +    struct nvme_path_info *info;
>> +    struct nvme_path_stat *stat;
>> +    u64 now, latency, slat_ns, avg_lat_ns;
>> +    struct nvme_ns_head *head = ns->head;
>> +
>> +    if (list_is_singular(&head->list))
>> +        return;
>> +
>> +    now = ktime_get_ns();
>> +    latency = now >= rq->io_start_time_ns ? now - rq->io_start_time_ns : 0;
>> +    if (!latency)
>> +        return;
>> +
>> +    /*
>> +     * As completion code path is serialized(i.e. no same completion queue
>> +     * update code could run simultaneously on multiple cpu) we can safely
>> +     * access per cpu nvme path stat here from another cpu (in case the
>> +     * completion cpu is different from submission cpu).
>> +     * The only field which could be accessed simultaneously here is the
>> +     * path ->weight which may be accessed by this function as well as I/O
>> +     * submission path during path selection logic and we protect ->weight
>> +     * using READ_ONCE/WRITE_ONCE. Yes this may not be 100% accurate but
>> +     * we also don't need to be so accurate here as the path credit would
>> +     * be anyways refilled, based on path weight, once path consumes all
>> +     * its credits. And we limit path weight/credit max up to 100. Please
>> +     * also refer nvme_adaptive_path().
>> +     */
>> +    cpu = blk_mq_rq_cpu(rq);
>> +    rw = rq_data_dir(rq);
>> +    info = &per_cpu_ptr(ns->info, cpu)[rw];
>> +    stat = &info->stat;
>> +
> Hmm. While the 'SAME_CONP' attribute should help here, I remain
> sceptical.
> Wouldn't it be possible to look at the hwq map (eg by using something
> like blk_mq_map_queue_type()) to figure out the hw context, and then
> use the first cpu from that mask?
> That way we are guaranteed to always using the same per-cpu ptr.
> Might be overkill, though; but it would be good to have some
> checks in here in case we do run on the wrong CPU.
> 
Okay so I think you propose ensuring that submitting cpu should 
match the cpu on which we're processing completion I/O sample.
Well, that makes sense but here we use blk_mq_rq_cpu() which
yields the submitting cpu for the request and then use submitting cpu 
number to get per-cpu stat using per_cpu_ptr(). As we don't rely
on the current cpu on which completion I/O sample is being processed, I 
think we're all good. Agreed?

>> +    /*
>> +     * If latency > ~1s then ignore this sample to prevent EWMA from being
>> +     * skewed by pathological outliers (multi-second waits, controller
>> +     * timeouts etc.). This keeps path scores representative of normal
>> +     * performance and avoids instability from rare spikes. If such high
>> +     * latency is real, ANA state reporting or keep-alive error counters
>> +     * will mark the path unhealthy and remove it from the head node list,
>> +     * so we safely skip such sample here.
>> +     */
>> +    if (unlikely(latency > NSEC_PER_SEC)) {
>> +        stat->nr_ignored++;
>> +        return;
>> +    }
> 
> I would even go so far as to indicate that EWMA is unusable here.
> Can we issue a warning / debug message here to indicate that the path
> selector is running suboptimal?
> 
We can certainly do that, but as you could see above we're incrementing 
->nr_ignored here, and user could then access this value through 
debugfs, so is that sufficient? Or do you want an explicit WARN or debug
message to be also printed?

>> +
>> +    /*
>> +     * Accumulate latency samples and increment the batch count for each
>> +     * ~15 second interval. When the interval expires, compute the simple
>> +     * average latency over that window, then update the smoothed (EWMA)
>> +     * latency. The path weight is recalculated based on this smoothed
>> +     * latency.
>> +     */
> 
> Why 15 seconds? Can we make this changeable eg via debugfs?
Yes certainly we can make this configurable, BTW should it be
done through a new sysfs attribute instead of debugfs? 

> 
>> +    stat->batch += latency;
>> +    stat->batch_count++;
>> +    stat->nr_samples++;
>> +
>> +    if (now > stat->last_weight_ts &&
>> +            (now - stat->last_weight_ts) >= 15 * NSEC_PER_SEC) {
>> +
> 
> At the very least make this a #define. But ideally one should be able
> to modify that.
> 
Yes I'd define a macro for this 15 seconds interval, and also we'll make
it configurable. I'd implement this in next patchset.

>> +        stat->last_weight_ts = now;
>> +
>> +        /*
>> +         * Find simple average latency for the last epoch (~15 sec
>> +         * interval).
>> +         */
>> +        avg_lat_ns = div_u64(stat->batch, stat->batch_count);
>> +
>> +        /*
>> +         * Calculate smooth/EWMA (Exponentially Weighted Moving Average)
>> +         * latency. EWMA is preferred over simple average latency
>> +         * because it smooths naturally, reduces jitter from sudden
>> +         * spikes, and adapts faster to changing conditions. It also
>> +         * avoids storing historical samples, and works well for both
>> +         * slow and fast I/O rates.
>> +         * Formula:
>> +         * slat_ns = (prev_slat_ns * (WEIGHT - 1) + (latency)) / WEIGHT
>> +         * With WEIGHT = 8, this assigns 7/8 (~87.5 %) weight to the
>> +         * existing latency and 1/8 (~12.5%) weight to the new latency.
>> +         */
> 
> Similar comment to the WEIGHT. While 8 might be a nice choice, there is nothing indicating it's always the right choice.
> Please make it a #define and see if we cannot modify it via debugfs.
> 
Yeah sure, as discussed earlier this value is derived from NVME_EWMA_SHIFT
and I'd make it configurable in the next patchset.

>> +int nvme_alloc_ns_stat(struct nvme_ns *ns)
>> +{
>> +    int rw, cpu;
>> +    struct nvme_path_work *work;
>> +    gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
>> +
>> +    if (!ns->head->disk)
>> +        return 0;
>> +
>> +    ns->info = __alloc_percpu_gfp(2 * sizeof(struct nvme_path_info),
>> +            __alignof__(struct nvme_path_info), gfp);
>> +    if (!ns->info)
>> +        return -ENOMEM;
>> +
>> +    for_each_possible_cpu(cpu) {
>> +        for (rw = 0; rw < 2; rw++) {
>> +            work = &per_cpu_ptr(ns->info, cpu)[rw].work;
>> +            work->ns = ns;
>> +            work->rw = rw;
>> +            INIT_WORK(&work->weight_work, nvme_mpath_weight_work);
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
> 
> The more I think about it the more I like the idea of having a third
> direction (and not just READ and WRITE).
> The latency of I/O commands _will_ be different from the latency of
> admin commands, so the adaptive policy might come to different decisions
> for admin commands.
Yes as I said above, I'd address this in the next patchset. 

>> +static struct nvme_ns *nvme_adaptive_path(struct nvme_ns_head *head,
>> +        unsigned int rw)
>> +{
>> +    struct nvme_ns *ns, *found = NULL;
>> +    struct nvme_path_stat *stat;
>> +    u32 weight;
>> +    int refill = 0;
>> +
>> +    get_cpu();
>> +retry:
>> +    list_for_each_entry_srcu(ns, &head->list, siblings,
>> +            srcu_read_lock_held(&head->srcu)) {
>> +
>> +        if (nvme_path_is_disabled(ns) ||
>> +                !nvme_state_is_live(ns->ana_state))
>> +            continue;
>> +
>> +        stat = &this_cpu_ptr(ns->info)[rw].stat;
>> +
>> +        /*
>> +         * When the head path-list is singular we don't calculate the
>> +         * only path weight for optimization as we don't need to forward
>> +         * I/O to more than one path. The another possibility is whenthe
>> +         * path is newly added, we don't know its weight. So we go round
>> +         * -robin for each such path and forward I/O to it.Once we start
>> +         * getting response for such I/Os, the path weight calculation
>> +         * would kick in and then we start using path credit for
>> +         * forwarding I/O.
>> +         */
>> +        weight = READ_ONCE(stat->weight);
>> +        if (unlikely(!weight)) {
>> +            found = ns;
>> +            goto out;
>> +        }
>> +
>> +        /*
>> +         * To keep path selection logic simple, we don't distinguish
>> +         * between ANA optimized and non-optimized states. The non-
>> +         * optimized path is expected to have a lower weight, and
>> +         * therefore fewer credits. As a result, only a small number of
>> +         * I/Os will be forwarded to paths in the non-optimized state.
>> +         */
>> +        if (stat->credit > 0) {
>> +            --stat->credit;
>> +            found = ns;
>> +            goto out;
>> +        }
>> +    }
>> +
>> +    if (!found && !list_empty(&head->list)) {> +        /*
>> +         * Refill credits and retry.
>> +         */
>> +        list_for_each_entry_srcu(ns, &head->list, siblings,
>> +                srcu_read_lock_held(&head->srcu)) {
>> +            if (nvme_path_is_disabled(ns) ||
>> +                    !nvme_state_is_live(ns->ana_state))
>> +                continue;
>> +
>> +            stat = &this_cpu_ptr(ns->info)[rw].stat;
>> +            weight = READ_ONCE(stat->weight);
>> +            stat->credit = weight;
>> +            refill = 1;
>> +        }
>> +        if (refill)
>> +            goto retry;
>> +    }
> 
> Hmm. Loop within a loop. Not pretty.
> Can't we make do with just one loop?
> After all, if we end up here the credits for this path are use up, and need to be refilled.
> What would happen if we were _just_ refill and retry?
> IE drop the second iteration and just execute the branch
> under the loop?
> 
Yes good pint. I think we should be able to address this
with one loop. I'd fix this in the next patchset. 

>> @@ -581,7 +951,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
>>       int srcu_idx, ret = -EWOULDBLOCK;
>>         srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, READ);
>>       if (ns)
>>           ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
>>       srcu_read_unlock(&head->srcu, srcu_idx);
> 
> See the discussion about the third option and not just 'READ'/'WRITE'.
Yeah, noted!

>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 29430949ce2f..4f9607e9698a 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -194,7 +194,7 @@ static int ns_head_update_nuse(struct nvme_ns_head *head)
>>           return 0;
>>         srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, READ);
>>       if (!ns)
>>           goto out_unlock;
>>  
> Other than that it really looks good.
Thank you:)

--Nilay


