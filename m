Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF91CAC5AA
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 03:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IE8Q4kHfo0Xx7AmtXj++OzGOhMvwYK8X/zqKgm7Aa7U=; b=QHOo5OoswqaIaBJdRkm40hIC3h
	RXR9l06MIXitSaxL5Ugumvq+8RZpS+X+f4fLXTk9RlgHv+imRZEYTADUWjjFrIG+aoxb8WixGq7Q6
	eWN4QQAw+Rjpzd07Z4lxdv2EmFaiX46j19LxjVHLG88Du6V+efyKKuLzGwVnYeAs+XXOcIPdkN33C
	j6mPstdYAApKd/+aMy/UQfZBGl3XeeqYroo0Leb6x6e3M+esUWR0o2qZTaFU9UKZjXRi8AD0J5Am3
	lbKPhwJWL3eZo5NIV+5YZHVd8QSKtGH/B0TdyB6iiCE0E946MEGaDH5FG3WuQkX7dWmonZ3sGk7cz
	N2qMJXhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0tw4-0000000CGN0-2RtB;
	Tue, 23 Sep 2025 03:43:24 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0tw0-0000000CGMC-2TIw
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 03:43:22 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGG0O0013222;
	Tue, 23 Sep 2025 03:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IE8Q4k
	Hfo0Xx7AmtXj++OzGOhMvwYK8X/zqKgm7Aa7U=; b=qzR7qKdgWJmQVvlBQ2eir3
	BeKz3GaNMlJvAIMOqXTlSpzp/uzfikqfuILMLMrIdj0ywPnXIi6fFlyTFXfIS8J2
	+9N4mvEc1fOZt6gYeuI6o9mmGB/VfLHoUhNdt9sEMU/AkoBsNVnQMxeSNZiVoUVD
	uCzT7Myqw/5Yb1ECwv9etXQhzZZ0+Uy4HWsIRLDJ7rnwrHV+ejfLMvNjJbsaNt6W
	hM2lF6/8JM2Ad9UjuXu45QV3mlhCwB96aQNvaiOHE5W3eOt6v8f2fkk2c5y1lKw8
	J6ch8uXkKxhKY7zI69ZL1EtMgZnFpodIdwplmtcj1FtGO06y1EjdIlILaJP6qzmQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpq6bgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 03:43:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N0iU0f031153;
	Tue, 23 Sep 2025 03:43:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vd28rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 03:43:09 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58N3h8N625625260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 03:43:08 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A43258062;
	Tue, 23 Sep 2025 03:43:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CE2B58056;
	Tue, 23 Sep 2025 03:43:04 +0000 (GMT)
Received: from [9.43.93.136] (unknown [9.43.93.136])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 03:43:04 +0000 (GMT)
Message-ID: <7e82159d-9e7d-415d-954b-985777ba41e7@linux.ibm.com>
Date: Tue, 23 Sep 2025 09:13:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] nvme-multipath: add support for adaptive I/O
 policy
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, gjoyce@ibm.com
References: <20250921111234.863853-1-nilay@linux.ibm.com>
 <20250921111234.863853-3-nilay@linux.ibm.com>
 <70beea89-0ba2-4300-a109-b8d2103fe4d6@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <70beea89-0ba2-4300-a109-b8d2103fe4d6@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d2174e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=c9_Uglh12u1Z_pb4mEcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KuQ0BjXBWUNmNKmk4X3GinZTLbwnHgk3
X-Proofpoint-GUID: KuQ0BjXBWUNmNKmk4X3GinZTLbwnHgk3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX3NJHoGwirtjd
 NuVfumAT/utj1t3UsFhdoK0rbe9cxEGEMN/pKAB+3Mc3nqStwNgmU/ZFJSbTt257TEnkhXiTKNG
 yh4GqTKXAAZdmS7pr0ftyejyF0H2kxFajNdhjX/8Zuyri5f3KZbotwCDeUQtjT8ITVyp0uFWd6p
 NpBVPylFLODrhCoJvFNEwgT6w++X64K0Ghse93JRN38xEbWf1sA3qCU7XLZ35eINysgDTalB5la
 UBt8LCMkGB5czEkSrVxKZH0b/1TyXkUlpKjEr+/imk4PIZB4ILExFb2f+AnxE2t6cn7X5IuZNdO
 BrHeXsxyHbDKkANNdwAx8fkV/3c6x6lzlXJ1pG6P6V9UyyF61lsNjaqmYvFeORo5rfEpiviCy9F
 +7rRUuqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_204321_102323_54D07E65 
X-CRM114-Status: GOOD (  34.94  )
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



On 9/22/25 1:00 PM, Hannes Reinecke wrote:
> On 9/21/25 13:12, Nilay Shroff wrote:
>> This commit introduces a new I/O policy named "adaptive". Users can
>> configure it by writing "adaptive" to "/sys/class/nvme-subsystem/nvme-
>> subsystemX/iopolicy"
>>
>> The adaptive policy dynamically distributes I/O based on measured
>> completion latency. The main idea is to calculate latency for each path,
>> derive a weight, and then proportionally forward I/O according to those
>> weights.
>>
>> To ensure scalability, path latency is measured per-CPU. Each CPU
>> maintains its own statistics, and I/O forwarding uses these per-CPU
>> values. Every ~15 seconds, a simple average latency of per-CPU batched
>> samples are computed and fed into an Exponentially Weighted Moving
>> Average (EWMA):
>>
>> avg_latency = div_u64(batch, batch_count);
>> new_ewma_latency = (prev_ewma_latency * (WEIGHT-1) + avg_latency)/WEIGHT
>>
>> With WEIGHT = 8, this assigns 7/8 (~87.5%) weight to the previous
>> latency value and 1/8 (~12.5%) to the most recent latency. This
>> smoothing reduces jitter, adapts quickly to changing conditions,
>> avoids storing historical samples, and works well for both low and
>> high I/O rates. Path weights are then derived from the smoothed (EWMA)
>> latency as follows (example with two paths A and B):
>>
>>      path_A_score = NSEC_PER_SEC / path_A_ewma_latency
>>      path_B_score = NSEC_PER_SEC / path_B_ewma_latency
>>      total_score  = path_A_score + path_B_score
>>
>>      path_A_weight = (path_A_score * 100) / total_score
>>      path_B_weight = (path_B_score * 100) / total_score
>>
>> where:
>>    - path_X_ewma_latency is the smoothed latency of a path in ns
>>    - NSEC_PER_SEC is used as a scaling factor since valid latencies
>>      are < 1 second
>>    - weights are normalized to a 0–100 scale across all paths.
>>
>> Path credits are refilled based on this weight, with one credit
>> consumed per I/O. When all credits are consumed, the credits are
>> refilled again based on the current weight. This ensures that I/O is
>> distributed across paths proportionally to their calculated weight.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/core.c      |  10 +-
>>   drivers/nvme/host/ioctl.c     |   7 +-
>>   drivers/nvme/host/multipath.c | 353 ++++++++++++++++++++++++++++++++--
>>   drivers/nvme/host/nvme.h      |  33 +++-
>>   drivers/nvme/host/pr.c        |   6 +-
>>   drivers/nvme/host/sysfs.c     |   2 +-
>>   6 files changed, 389 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 6b7493934535..6cd1d2c3e6ee 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -689,6 +689,7 @@ static void nvme_free_ns(struct kref *kref)
>>   {
>>       struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
>>   +    nvme_mpath_free_stat(ns);
>>       put_disk(ns->disk);
>>       nvme_put_ns_head(ns->head);
>>       nvme_put_ctrl(ns->ctrl);
>> @@ -4132,6 +4133,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>       if (nvme_init_ns_head(ns, info))
>>           goto out_cleanup_disk;
>>   +    if (nvme_mpath_alloc_stat(ns))
>> +        goto out_unlink_ns;
>> +
>>       /*
>>        * If multipathing is enabled, the device name for all disks and not
>>        * just those that represent shared namespaces needs to be based on the
>> @@ -4156,7 +4160,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>       }
>>         if (nvme_update_ns_info(ns, info))
>> -        goto out_unlink_ns;
>> +        goto out_free_ns_stat;
>>         mutex_lock(&ctrl->namespaces_lock);
>>       /*
>> @@ -4165,7 +4169,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>        */
>>       if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
>>           mutex_unlock(&ctrl->namespaces_lock);
>> -        goto out_unlink_ns;
>> +        goto out_free_ns_stat;
>>       }
>>       nvme_ns_add_to_ctrl_list(ns);
>>       mutex_unlock(&ctrl->namespaces_lock);
>> @@ -4196,6 +4200,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>       list_del_rcu(&ns->list);
>>       mutex_unlock(&ctrl->namespaces_lock);
>>       synchronize_srcu(&ctrl->srcu);
>> +out_free_ns_stat:
>> +    nvme_mpath_free_stat(ns);
>>    out_unlink_ns:
>>       mutex_lock(&ctrl->subsys->lock);
>>       list_del_rcu(&ns->siblings);
>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>> index 6b3ac8ae3f34..aab7b795a168 100644
>> --- a/drivers/nvme/host/ioctl.c
>> +++ b/drivers/nvme/host/ioctl.c
>> @@ -716,7 +716,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
>>           flags |= NVME_IOCTL_PARTITION;
>>         srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, open_for_write ? WRITE : READ);
>>       if (!ns)
>>           goto out_unlock;
>>   @@ -747,7 +747,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>>       int srcu_idx, ret = -EWOULDBLOCK;
>>         srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, open_for_write ? WRITE : READ);
>>       if (!ns)
>>           goto out_unlock;
>>   @@ -767,7 +767,8 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>>       struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>>       struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>>       int srcu_idx = srcu_read_lock(&head->srcu);
>> -    struct nvme_ns *ns = nvme_find_path(head);
>> +    struct nvme_ns *ns = nvme_find_path(head,
>> +            ioucmd->file->f_mode & FMODE_WRITE ? WRITE : READ);
>>       int ret = -EINVAL;
>>         if (ns)
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 3da980dc60d9..4f56a2bf7ea3 100644
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
>>   @@ -66,9 +68,10 @@ MODULE_PARM_DESC(multipath_always_on,
>>       "create multipath node always except for private namespace with non-unique nsid; note that this also implicitly enables native multipath support");
>>     static const char *nvme_iopolicy_names[] = {
>> -    [NVME_IOPOLICY_NUMA]    = "numa",
>> -    [NVME_IOPOLICY_RR]    = "round-robin",
>> -    [NVME_IOPOLICY_QD]      = "queue-depth",
>> +    [NVME_IOPOLICY_NUMA]     = "numa",
>> +    [NVME_IOPOLICY_RR]     = "round-robin",
>> +    [NVME_IOPOLICY_QD]       = "queue-depth",
>> +    [NVME_IOPOLICY_ADAPTIVE] = "adaptive",
>>   };
>>     static int iopolicy = NVME_IOPOLICY_NUMA;
>> @@ -83,6 +86,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>>           iopolicy = NVME_IOPOLICY_RR;
>>       else if (!strncmp(val, "queue-depth", 11))
>>           iopolicy = NVME_IOPOLICY_QD;
>> +    else if (!strncmp(val, "adaptive", 8))
>> +        iopolicy = NVME_IOPOLICY_ADAPTIVE;
>>       else
>>           return -EINVAL;
>>   @@ -196,6 +201,190 @@ void nvme_mpath_start_request(struct request *rq)
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
>>   +int nvme_mpath_alloc_stat(struct nvme_ns *ns)
>> +{
>> +    gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
>> +
>> +    if (!ns->head->disk)
>> +        return 0;
>> +
>> +    ns->cpu_stat = __alloc_percpu_gfp(
>> +            2 * sizeof(struct nvme_path_stat),
>> +            __alignof__(struct nvme_path_stat),
>> +            gfp);
>> +    if (!ns->cpu_stat)
>> +        return -ENOMEM;
>> +
>> +    return 0;
>> +}
>> +
>> +#define NVME_EWMA_SHIFT    3
>> +static inline u64 ewma_update(u64 old, u64 new)
>> +{
>> +    return (old * ((1 << NVME_EWMA_SHIFT) - 1) + new) >> NVME_EWMA_SHIFT;
>> +}
>> +
>> +static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
>> +{
>> +    int cpu, srcu_idx;
>> +    unsigned int rw;
>> +    struct nvme_path_stat *stat;
>> +    struct nvme_ns *cur_ns;
>> +    u32 weight;
>> +    u64 now, latency, avg_lat_ns;
>> +    u64 total_score = 0;
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
>> +    stat = &per_cpu_ptr(ns->cpu_stat, cpu)[rw];
>> +
> 
> This is tad awkward for setups where #CPUs > #paths.
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
>> +
>> +    /*
>> +     * Accumulate latency samples and increment the batch count for each
>> +     * ~15 second interval. When the interval expires, compute the simple
>> +     * average latency over that window, then update the smoothed (EWMA)
>> +     * latency. The path weight is recalculated based on this smoothed
>> +     * latency.
>> +     */
>> +    stat->batch += latency;
>> +    stat->batch_count++;
>> +    stat->nr_samples++;
>> +
>> +    if (now > stat->last_weight_ts &&
>> +            (now - stat->last_weight_ts) >= 15 * NSEC_PER_SEC) {
>> +
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
>> +        if (unlikely(!stat->slat_ns))
>> +            stat->slat_ns = avg_lat_ns;
>> +        else
>> +            stat->slat_ns = ewma_update(stat->slat_ns, avg_lat_ns);
>> +
>> +        stat->batch = stat->batch_count = 0;
>> +
>> +        srcu_idx = srcu_read_lock(&head->srcu);
>> +        list_for_each_entry_srcu(cur_ns, &head->list, siblings,
>> +                srcu_read_lock_held(&head->srcu)) {
> 
> And this is even more awkward as we need to iterate over all paths
> (during completion!).
> 
Hmm yes, but we only iterate once every ~15 seconds per CPU, so the overhead is minimal.
Typically we don’t have a large number of paths to deal with: enterprise SSDs usually
expose at most two controllers, and even in fabrics setups the path count is usually 
limited to around 4–6. So the loop should run quite fast.
Also, looping in itself isn’t unusual — for example, the queue-depth I/O policy already
iterates over all paths in the submission path to check queue depth before dispatching each 
I/O. That said, if looping in the completion path is still a concern, we could consider
moving this into a dedicated worker thread instead. What do you think?

> Do we really need to do this?
> What would happen if we just measure the latency on the local CPU
> and do away with this loop?
> We would have less samples, true, but we would even be able to
> not only differentiate between distinct path latency but also between
> different CPU latencies; I would think this being a bonus for
> multi-socket machines.
> 
The idea is to keep per-cpu view consistent for each path. As we know,
in NVMe/fabrics multipath, submission and completion CPUs don’t necessarily
match (depends on the host’s irq/core mapping). And so if we were to measure
the latency/EWMA locally per-cpu then the per-CPU accumulator might be biased
towards the completion CPU, not the submission CPU. For instance, if submission
is on CPU A but completion lands on CPU B, then CPU A’s weights never reflect
it's I/O experience — they’ll be skewed by how interrupts get steered.

So on a multi socket/NUMA systems, depending on topology, calculating local
per-cpu ewma/latency may or may not line up. For example:

- If we have #cpu <= #vectors supported by NVMe disk then typically
  we have 1:1 mapping between submission and completion queues and hence all completions for
  a queue are steered to the same CPU that also submits, then per-CPU stats are accurate.

- But when #CPUs > #vectors, completions may be centralized or spread differently. In that 
  case, the per-CPU latency view can be distorted — e.g., CPU A may submit, but CPU B takes
  completions, so CPU A’s weights never reflect its own I/O behavior.

> _And_ we wouldn't need to worry about path failures, which is bound
> to expose some race conditions if we need to iterate paths at the
> same time than path failures are being handled.
> 
Yes agreed we may have some race here and so the path score/weight may be 
skewed when that happens but then that'd be auto-corrected in the next epoc
(after ~15 sec) when we re-calculate the path weight/score again, isn't it?

> But nevertheless: great job!
Thank you :)

--Nilay
 

