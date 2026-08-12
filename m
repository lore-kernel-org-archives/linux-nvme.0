Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E2BC5AD5A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m2D298tNGcaC46Jg2sSqJ8w/YvkyuN8UZRnmSjUJj4U=; b=rzqeGNmRy1mpzdkieYqyw66jDt
	0wNAVQk1TOeYG9A5fSTp63R3hbOlkLJrYRiLY7Waz59tXjnGhC9h12q8IAwSiP+8ikqgk8CX47A6D
	CLPuzOYJaaRS0nK8LqivNX/DN/z3y+JyK5/aod7K5k+qDWvVkuxMwKW5THuqPkcU4fYYEaCk7LZjO
	fqk2CHl/v19/Gg1edhM+rITzen4MjdLlGJOtDuMxza0qvQ83hU6XJA4V3fwOzXF6p7nLhMcUcVHuH
	fL0Ic9kPrhDbvKksmD7Wr4JBzZ7NnaIWkXTRPS3tE/8eW48xrQnYNGd7kVSLJ5ZDv1618X09ZyHGV
	j9wTqpJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu3ob-0000000Fbkq-3Q6t;
	Wed, 12 Aug 2026 07:55:57 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu3oY-0000000Fbk7-0wwJ
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 07:55:55 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62eU52631845;
	Wed, 12 Aug 2026 07:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m2D298
	tNGcaC46Jg2sSqJ8w/YvkyuN8UZRnmSjUJj4U=; b=tkGQ2RnBpuJZAxWfHMwo+3
	IgSZkVdt3sT5cOH7U9T17OaTJOO0AppaSTknZXh5CENqTIdx5+yqHAkopasT/MF+
	Kt5Uo2g0J6MzGA7E3/mmewpwI+7KCHzHseXd7w6KpcHMqTTXH/s/486CV3rmyyzG
	ABX/An0E9G4XMw5KmjJZwUfEY4Uyzqb5VBIf2qSO11yu9y/g1YUPw1rqSFmAC7cC
	sMyJRVuMcqTMMf7O3LyBrIhHgpAyvsgNtw72xjjBsSqHG9w2DiWf58l8gDpqlx9n
	AdVngB+M9zMbVnP5+cX9W8i1ST5/sDpk9AYsw8rZuenRviNJLbJvwBAjW+wZGVQQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9hcjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 07:55:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C7ff9L003880;
	Wed, 12 Aug 2026 07:55:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w56s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 07:55:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C7tfX131326868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 07:55:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A650558052;
	Wed, 12 Aug 2026 07:55:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2410258056;
	Wed, 12 Aug 2026 07:55:36 +0000 (GMT)
Received: from [9.61.0.237] (unknown [9.61.0.237])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 07:55:35 +0000 (GMT)
Message-ID: <975ecb71-417b-4e21-a5c6-1a0882d135b9@linux.ibm.com>
Date: Wed, 12 Aug 2026 13:25:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] nvme-multipath: add support for latency I/O policy
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-5-nilay@linux.ibm.com>
 <055c80a6-16f2-4d1b-ab6e-fc4fd24e7227@oracle.com>
 <569f183a-03eb-454f-9871-4af16dbfc1e8@linux.ibm.com>
 <a44c6939-00e7-44e2-99e0-8753627aa11b@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a44c6939-00e7-44e2-99e0-8753627aa11b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 2KE5pAp1-HkDkKY2GjTo0LwD4YnEZfPy
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c2700 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=m9YoFhAi5jrzhlcu2YYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1OSBTYWx0ZWRfX1VyRiGwwM3d6
 orpvTkJ6XUsx3V9nktNszA6r4PivMp/UZhvfFJhjSMdOSlrU4TxvMfoO3toRvb2mHy/buyqF8a4
 BDWCE4v2M5s38vjR7rwL/SwKbp4nRWmqTbT9OEXReASfdSoNfo16PGJc9GWeEpFxTaIP8ama+s4
 7tvQ6fpD9ovmnGlbXvarfAmppZ1YihEzWff8JVD4DYWYltdnvMbpeNRTH26g5EK7Ny9iMmEMjwN
 mha9cCamr8TGRAW3g6W6L1Lr8NgVLD7FvsKAFSEWmtE4smjrij1IHu+BVZY5MwHHNGH1wQuVomS
 uM/+wOe4BR8MNgCelTxxFEam+AcCf4iFTQ03HSW1oif6DhqiUPY1jy9UAkN/tIJzG3YLVyVPkqr
 yPQnuuJiCMgaQwHjkToc/lfTeL7pBoaDILWIwkaRRWa6koSC0EeuKDUSfiUuV8EwwygZuY8dqaV
 NlTE27h3FJWMQKUDIEw==
X-Proofpoint-ORIG-GUID: pu8gYUoXbcic3trBJvygqq2n1KKCTE9C
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1OSBTYWx0ZWRfX54r2kbemAq35
 a+bklQYfjhhDJ9KgApK430BvIREn8G85c/gwFA/7bDxNEAoNsIz4GZmoS0/QoOi1G+yg7jhE/P9
 5YHuYsVLhZ+09TTVJNaVKmuUXoWj7S0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_005554_302156_047DC9AB 
X-CRM114-Status: GOOD (  43.33  )
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

On 8/11/26 3:33 PM, John Garry wrote:
> 
>>>> +}
>>>> +
>>>> +/*
>>>> + * Formula to calculate the EWMA (Exponentially Weighted Moving Average):
>>>> + * ewma = (old_ewma * (EWMA_SHIFT - 1) + (EWMA_SHIFT)) / EWMA_SHIFT
>>>> + * For instance, with EWMA_SHIFT = 3, this assigns 7/8 (~87.5 %) weight to
>>>> + * the existing/old ewma and 1/8 (~12.5%) weight to the new sample.
>>>> + */
>>>> +static inline u64 calc_ewma_update(u64 old, u64 new)
>>>> +{
>>>> +    return (old * ((1 << NVME_DEFAULT_LATENCY_EWMA_SHIFT) - 1)
>>>> +            + new) >> NVME_DEFAULT_LATENCY_EWMA_SHIFT;
> 
> side note: I have to admit that I did not check all the mathematics of these ewma calculations ...
> 
>>>> +}
>>>> +
>>>> +static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
> 
> Could the context analysis annotation be added here eventually to declare that the srcu read lock is held?
> 
Yes it will be added when I resend series based off nvme-7.3 as
support of clang context annotation is added in nvme-7.3.

>>>> +{
>>>> +    int cpu;
>>>> +    unsigned int op_type;
>>>> +    struct nvme_path_lat *path_lat;
>>>> +    struct nvme_path_lat_stat *stat;
>>>> +    u64 now, latency, slat_ns, avg_lat_ns;
>>>> +    struct nvme_ns_head *head = ns->head;
>>>> +
>>>> +    if (list_is_singular(&head->list))
>>>> +        return;
>>>> +
>>>> +    now = ktime_get_ns();
>>>> +    latency = now >= rq->io_start_time_ns ? now - rq->io_start_time_ns : 0;
>>>> +    if (!latency)
>>>> +        return;
>>>> +
>>>> +    /*
>>>> +     * As completion code path is serialized(i.e. no same completion queue
>>>> +     * update code could run simultaneously on multiple cpu) we can safely
>>>> +     * access per cpu nvme path stat here from another cpu (in case the
>>>> +     * completion cpu is different from submission cpu).
>>>> +     * The only field which could be accessed simultaneously here is the
>>>> +     * path ->weight which may be accessed by this function as well as I/O
>>>> +     * submission path during path selection logic and we protect ->weight
>>>> +     * using READ_ONCE/WRITE_ONCE. Yes this may not be 100% accurate but
>>>> +     * we also don't need to be so accurate here as the path credit would
>>>> +     * be anyways refilled, based on path weight, once path consumes all
>>>> +     * its credits. And we limit path weight/credit max up to 64. Please
>>>> +     * also refer nvme_latency_path().
>>>> +     */
> 
> ...
> 
>>>>    void nvme_mpath_end_request(struct request *rq)
>>>>    {
>>>>        struct nvme_ns *ns = rq->q->queuedata;
>>>> @@ -206,6 +407,15 @@ void nvme_mpath_end_request(struct request *rq)
>>>>        if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
>>>>            atomic_dec_if_positive(&ns->ctrl->nr_active);
>>>> +    if (test_bit(NVME_NS_PATH_STAT, &ns->flags)) {
>>>> +        int srcu_idx;
>>>> +
>>>> +        srcu_idx = srcu_read_lock(&ns->head->srcu);
>>>> +        if (test_bit(NVME_NS_PATH_STAT, &ns->flags))
>>>
>>> Some may ask why check NVME_NS_PATH_STAT twice.
>>
>> The first check is a fast-path optimization to avoid taking the SRCU read
>> lock when latency sampling is disabled. The second check is needed because
>> NVME_NS_PATH_STAT could be cleared after the first test but before acquiring
>> the SRCU lock, so we revalidate it after entering the protected section.
> 
> It is probably worth a brief comment on that. A similar trick is done in __blk_mq_tag_busy() and every so often someone asks about it. Or maybe it is another function. I don't remember.
> 
Yeah okay will add comment in the code.

>>>
>>>> +    blk_stat_enable_accounting(ns->queue);
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static bool nvme_disable_ns_latency_sampling(struct nvme_ns *ns)
>>>> +{
>>>> +    int cpu;
>>>> +    struct nvme_ns_head *head = ns->head;
>>>> +    bool changed = false;
>>>> +
>>>> +    if (!test_and_clear_bit(NVME_NS_PATH_STAT, &ns->flags))
>>>> +        return false;
>>>> +
>>>> +    for_each_possible_cpu(cpu) {
>>>> +        if (ns == READ_ONCE(*per_cpu_ptr(head->latency_path, cpu))) {
>>>> +            WRITE_ONCE(*per_cpu_ptr(head->latency_path, cpu), NULL);
>>>> +            changed = true;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    blk_stat_disable_accounting(ns->queue);
>>>> +    blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, ns->queue);
>>>
>>> eh, what if QUEUE_FLAG_SAME_FORCE was already enabled before nvme_enable_ns_latency_sampling()?
>>>
>> Good catch! It looks like we need a nested reference count for
>> QUEUE_FLAG_SAME_FORCE, similar to QUEUE_FLAG_STATS and
>> QUEUE_FLAG_QUIESCED.
> 
> Furthermore, I think that userspace can change this via sysfs, no? I think that the file is rq_affinity. If so, could that break things (if userspace did change this flag)?
> 
So that's where I suggested using a nested ref count. I'd
add an helper similar to blk_stat_{enable|dsiable}_accounting() and
that new helper would be then used in both sysfs path as well
latency policy enable/disable path.

>>>>    }
>>>> @@ -268,6 +554,45 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>>>>        srcu_read_unlock(&ctrl->srcu, srcu_idx);
>>>>    }
>>>> +int nvme_alloc_ns_stat(struct nvme_ns *ns)
>>>
>>> Surely "mpath" should be in the name, no? It seems that every other public API in multpath.c has "mpath" in the name.
>>
>> Not all APIs have "mpath" in its name, such as nvme_failover_req(),
>> nvme_kick_requeue_lists() etc, but most other have. So I would
>> rename it to nvme_mpath_alloc_ns_stat().
> 
> nvme_failover_req() would obviously be a multipath function from the name. Anyway, "mpath" in the name just seem better.
> 
>>>
>>>> +{
>>>> +    int i, cpu;
>>>> +    struct nvme_path_lat_work *work;
>>>> +    gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
>>>> +
>>>> +    if (!ns->head->disk)
>>>> +        return 0;
>>>> +
>>>> +    ns->path_lat = __alloc_percpu_gfp(NVME_NUM_STAT_GROUPS *
>>>> +                sizeof(struct nvme_path_lat),
>>>> +                __alignof__(struct nvme_path_lat), gfp);
>>>> +    if (!ns->path_lat)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    for_each_possible_cpu(cpu) {
>>>> +        for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
>>>> +            work = &per_cpu_ptr(ns->path_lat, cpu)[i].work;
>>>> +            work->ns = ns;
>>>> +            work->op_type = i;
>>>> +            INIT_WORK(&work->weight_work, nvme_mpath_weight_work);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void nvme_mpath_set_ctrl_paths(struct nvme_ctrl *ctrl)
>>>
>>> what do you mean by "set" here?
>>
>> It is intended as the counterpart of nvme_mpath_clear_ctrl_paths().
>> The former clears/disables the I/O policy state for the controller
>> namespaces, while this helper sets/enables it.
> 
> To me, clear paths meaning is obvious, in that any per-NUMA node paths are cleared for all the paths associated with the controller.
> 
> nvme_mpath_set_ctrl_paths() does not really do the opposite - it instead just enables the IO latency sampling per path.
> 
> Anyway, I don't feel too strongly about this, but it just seems that the naming could be improved.
> 
>>>
>>>> +{
>>>> +    struct nvme_ns *ns;
>>>> +    int srcu_idx;
>>>> +
>>>> +    srcu_idx = srcu_read_lock(&ctrl->srcu);
>>>> +    list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
>>>> +                srcu_read_lock_held(&ctrl->srcu))
>>>> +        nvme_enable_ns_latency_sampling(ns);
>>>> +    srcu_read_unlock(&ctrl->srcu, srcu_idx);
>>>> +}
>>>> +
>>>>    void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
>>>>    {
>>>>        sector_t capacity = get_capacity(head->disk);
>>>> @@ -280,6 +605,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
>>>>                     srcu_read_lock_held(&head->srcu)) {
>>>>            if (capacity != get_capacity(ns->disk))
>>>>                clear_bit(NVME_NS_READY, &ns->flags);
>>>> +
>>>> +        nvme_reset_ns_latency_stat(ns);
>>>>        }
>>>>        srcu_read_unlock(&head->srcu, srcu_idx);
>>>> @@ -404,6 +731,92 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
>>>>        return found;
>>>>    }
>>>> +static inline bool nvme_state_is_live(enum nvme_ana_state state)
> ...
> 
>>>>        }
>>>>        mutex_unlock(&head->lock);
>>>> +    mutex_lock(&nvme_subsystems_lock);
>>>
>>> I am curious - why use the nvme_subsystems_lock?
>>>
>> nvme_subsys_iopolicy_update() and nvme_mpath_set_live() can run concurrently.
>> nvme_subsystems_lock serializes these paths so that latency sampling is
>> enabled consistently with the subsystem I/O policy.
> 
> ok, maybe then please consider a comment. It can be useful.
> 
sure, will add one.
> 
>>>> @@ -527,6 +530,30 @@ enum nvme_stat_group {
>>>>        NVME_NUM_STAT_GROUPS
>>>>    };
>>>> +struct nvme_path_lat_stat {
>>>> +    u64 nr_samples;        /* total num of samples processed */
>>>
>>> why u64 and not unsigned long long?
>>>
>> I used u64 intentionally because this is a monotonically increasing
>> sample counter, and I wanted a fixed-width 64-bit type. I didn't see
>> any particular advantage in using unsigned long long here. If there's
>> a reason to prefer it in this context, I'm happy to change it.
> 
> hmmm... I thought that in general we only should use a fixed width type when it is required, e.g. reading from a 32b register, then use u32.
> 
The sizeof unsigned long long counter would be 8 bytes (or 64 bit) on both
32-bit and 64-but system, isn't it? So, it seems, using u64 makes the
intended width clearer than unsigned long long.

Thanks,
--Nilay

