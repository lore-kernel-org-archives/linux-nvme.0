Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1F2D59F77
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Dec 2025 07:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xYkJolWf0qzxbe+bQOTz5G4uDnnNbfd5nYKZPi/eL6Q=; b=PR/O1h3YakwA0MQ9Paq1U0MGoT
	ehyH3+V/yOw0GdbY2Rbwjij5+ZTJfmDke2MIn4J++Fxd/FJ+mr8149bVVANkUUvGuWUDvwKbgfbc5
	Fucl4XtcqR6SmNLVuVXNzXy0CPUaBAAGjWDqumnBAdFtRMkY7z8pXH7FLdLVcgyaW3DUCXLy5X8U2
	/C3ID9hYIJ7KL+x9IVGKG9hQu4EAaQ+UpM7xkR2MitXCU491E2H6r0ZwduUOWgtSRdJwtqCz+an4B
	PRkJHIkv5xnfpojkNrhjLOFgF++CP/UjEs80qT2RWKDVwv2lhAx9GtxGdy+geBYn9pgpfOH7WpXtR
	ipZEtVMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUK3B-00000001Urx-3lTF;
	Sat, 13 Dec 2025 07:28:21 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUK38-00000001UrU-4Am2
	for linux-nvme@lists.infradead.org;
	Sat, 13 Dec 2025 07:28:21 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BD5RLQ9020180;
	Sat, 13 Dec 2025 07:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xYkJol
	Wf0qzxbe+bQOTz5G4uDnnNbfd5nYKZPi/eL6Q=; b=V8/O07NfHnHKaOLzqvikCg
	jULNQxCbGf9orDWsON6x8bVPmMfDwnXB+fpV3ndFiwd2w3cHKR+LrZ7R0uL/yesd
	HKMK5zTZh8Efe6svXTVoFAihFLQexftspEo2tF0FTjtB849kuzJPB3bRjJdTuGV+
	KACQXbWoSdx020NFtYSMm1WMtSQOheD1M7GNxmTeTbU5XtDtbAz6eF6Jkaj4/OTN
	3/+iuZt3YUBKV6IQsX4eZMuQeQCrFX6n5aASKnM/0Lgc0OOCp44gkUNZFGXyNK60
	3ldaSG59ik4VuCLFrQxsRyP7jPkRb+p9khLkbICDXaqrGf4mKnLliHmpJdYdqRXA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjpgwfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Dec 2025 07:28:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BD7S1mZ002343;
	Sat, 13 Dec 2025 07:28:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjpgwfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Dec 2025 07:28:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BD5CW1h030254;
	Sat, 13 Dec 2025 07:28:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxtsr432-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Dec 2025 07:28:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BD7RxdR27591282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Dec 2025 07:27:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5663C5805D;
	Sat, 13 Dec 2025 07:27:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 658605805B;
	Sat, 13 Dec 2025 07:27:54 +0000 (GMT)
Received: from [9.111.89.246] (unknown [9.111.89.246])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Dec 2025 07:27:53 +0000 (GMT)
Message-ID: <abe16085-f0dd-4f82-b48c-f2eb125da2ee@linux.ibm.com>
Date: Sat, 13 Dec 2025 12:57:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, dwagner@suse.de,
        axboe@kernel.dk, kanie@linux.alibaba.com, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <20251105103347.86059-3-nilay@linux.ibm.com>
 <6d7c519c-122e-41a6-9f76-a3c4dedb52f5@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <6d7c519c-122e-41a6-9f76-a3c4dedb52f5@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfX0a/TKJtX8Hq5
 C9LDM2BztKKsMLZiGPmpOUp7x8J6yHcuykoDrp3TKsjUPUU8kX0I+S0o+xsiM4tKf5lmWo4NFeR
 JNrmywg7geaeKVtjRjbSHJPbRn+pYxNQlX3gtv7jD/EY2gIEKMGxa6X16lDCrFCuYQ651R19Aza
 yHtvK6UWOOx5lHSuwSUAL+MzWX+GoEPK7xuikwMwDYIhj78gUTEjcT/OgB1UCAscIobO6qdxGtW
 2iafZopn+fA2lYXjwYap53pe0vM6Oh/U2HW0752BCvqJHTn09xt2o0ZCeI1kTdOwfyTdPMura4C
 fSIFLdCOcEvdN1IAvMdoTZxJwc+QhzZyADKRG46nSeqEkh+gfTEGL93PrdJtM8TH917Z83wvv5Q
 jCSh2s0CB2+WNcYSxbDcH1MUYYyzCA==
X-Proofpoint-GUID: muA4AlO93XFGowp-q40c2u-5YszPloAP
X-Proofpoint-ORIG-GUID: DpvvB3w5mmgu8zh6Pw-A8K4w25j9M7B6
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=693d1581 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=wclqsbBRtd3wGdlKWicA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-13_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_232819_258341_5039B545 
X-CRM114-Status: GOOD (  45.39  )
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



On 12/12/25 6:34 PM, Sagi Grimberg wrote:
> 
> 
> On 05/11/2025 12:33, Nilay Shroff wrote:
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
>> values.
> 
> So a given cpu would select path-a vs. another cpu that may select path-b?
> How does that play with less queues than cpu cores? what happens to cores
> that have low traffic?
> 
The path-selection logic does not depend on the relationship between the number
of CPUs and the number of hardware queues. It simply selects a path based on the
per-CPU path score/credit, which reflects the relative performance of each available
path.
For example, assume we have two paths (A and B) to the same shared namespace. 
For each CPU, we maintain a smoothed latency estimate for every path. From these
latency values we derive a per-path score or credit. The credit represents the relative
share of I/O that each path should receive: a path with lower observed latency gets more
credit, and a path with higher latency gets less.

I/O distribution is thus governed directly by the available credits on that CPU. When the
NVMe multipath driver performs path selection, it chooses the path with sufficient credits,
updates the bio’s bdev to correspond to that path, and submits the bio. Only after this
point does the block layer map the bio to an hctx through the usual ctx->hctx mapping (i.e., 
matching the issuing CPU to the appropriate hardware queue). In other words, the multipath
policy runs above the block-layer queueing logic, and the number of hardware queues does
not affect how paths are scored or selected.

>> Every ~15 seconds, a simple average latency of per-CPU batched
>> samples are computed and fed into an Exponentially Weighted Moving
>> Average (EWMA):
> 
> I suggest to have iopolicy name reflect ewma. maybe "ewma-lat"?

Okay that sounds good! Shall we name it "ewma-lat" or "weighted-lat"? 

> 
>>
>> avg_latency = div_u64(batch, batch_count);
>> new_ewma_latency = (prev_ewma_latency * (WEIGHT-1) + avg_latency)/WEIGHT
>>
>> With WEIGHT = 8, this assigns 7/8 (~87.5%) weight to the previous
>> latency value and 1/8 (~12.5%) to the most recent latency. This
>> smoothing reduces jitter, adapts quickly to changing conditions,
>> avoids storing historical samples, and works well for both low and
>> high I/O rates.
> 
> This weight was based on empirical measurements?
> 
Yes correct and so we also allow user to configure WEIGHT, if needed.

>>   Path weights are then derived from the smoothed (EWMA)
>> latency as follows (example with two paths A and B):
>>
>>      path_A_score = NSEC_PER_SEC / path_A_ewma_latency
>>      path_B_score = NSEC_PER_SEC / path_B_ewma_latency
>>      total_score  = path_A_score + path_B_score
>>
>>      path_A_weight = (path_A_score * 100) / total_score
>>      path_B_weight = (path_B_score * 100) / total_score
> 
> What happens to R/W mixed workloads? What happens when the I/O pattern
> has a distribution of block sizes?
> 

We maintain separate metrics for READ and WRITE traffic, and during path
selection we use the appropriate metric depending on the I/O type.

Regarding block-size variability: the current implementation does not yet
account for I/O size. This is an important point — thank you for raising it.
I discussed this today with Hannes at LPC, and we agreed that a practical
approach is to normalize latency per 512-byte block. For our purposes, we 
do not need an exact latency value; a relative latency metric is sufficient,
as it ultimately feeds into path scoring. A path with higher latency ends up
with a lower score, and a path with lower latency gets a higher score — the 
exact absolute values are less important than maintaining consistent proportional
relationships.

Normalizing latency per 512 bytes gives us a stable, size-aware metric that scales
across different I/O block sizes. I think that it's easy to normalize a latency number
per 512 bytes block and I'd implement that in next patch version.
 > I think that in order to understand how a non-trivial path selector works we need
> thorough testing in a variety of I/O patterns.
> 
Yes that was done running fio with different I/O engines, I/O tyeps (read, write, r/w) and 
different block sizes. I tested it using NVMe pcie and nvmf-tcp. The tests were performed 
for both direct and buffered I/O. Also I ran blktests configuring adaptive I/O policy. 
Still if you prefer running anything further let me know.

>>
>> where:
>>    - path_X_ewma_latency is the smoothed latency of a path in nanoseconds
>>    - NSEC_PER_SEC is used as a scaling factor since valid latencies
>>      are < 1 second
>>    - weights are normalized to a 0–64 scale across all paths.
>>
>> Path credits are refilled based on this weight, with one credit
>> consumed per I/O. When all credits are consumed, the credits are
>> refilled again based on the current weight. This ensures that I/O is
>> distributed across paths proportionally to their calculated weight.
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/core.c      |  15 +-
>>   drivers/nvme/host/ioctl.c     |  31 ++-
>>   drivers/nvme/host/multipath.c | 425 ++++++++++++++++++++++++++++++++--
>>   drivers/nvme/host/nvme.h      |  74 +++++-
>>   drivers/nvme/host/pr.c        |   6 +-
>>   drivers/nvme/host/sysfs.c     |   2 +-
>>   6 files changed, 530 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index fa4181d7de73..47f375c63d2d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -672,6 +672,9 @@ static void nvme_free_ns_head(struct kref *ref)
>>       cleanup_srcu_struct(&head->srcu);
>>       nvme_put_subsystem(head->subsys);
>>       kfree(head->plids);
>> +#ifdef CONFIG_NVME_MULTIPATH
>> +    free_percpu(head->adp_path);
>> +#endif
>>       kfree(head);
>>   }
>>   @@ -689,6 +692,7 @@ static void nvme_free_ns(struct kref *kref)
>>   {
>>       struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
>>   +    nvme_free_ns_stat(ns);
>>       put_disk(ns->disk);
>>       nvme_put_ns_head(ns->head);
>>       nvme_put_ctrl(ns->ctrl);
>> @@ -4137,6 +4141,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>       if (nvme_init_ns_head(ns, info))
>>           goto out_cleanup_disk;
>>   +    if (nvme_alloc_ns_stat(ns))
>> +        goto out_unlink_ns;
>> +
>>       /*
>>        * If multipathing is enabled, the device name for all disks and not
>>        * just those that represent shared namespaces needs to be based on the
>> @@ -4161,7 +4168,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>       }
>>         if (nvme_update_ns_info(ns, info))
>> -        goto out_unlink_ns;
>> +        goto out_free_ns_stat;
>>         mutex_lock(&ctrl->namespaces_lock);
>>       /*
>> @@ -4170,7 +4177,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>        */
>>       if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
>>           mutex_unlock(&ctrl->namespaces_lock);
>> -        goto out_unlink_ns;
>> +        goto out_free_ns_stat;
>>       }
>>       nvme_ns_add_to_ctrl_list(ns);
>>       mutex_unlock(&ctrl->namespaces_lock);
>> @@ -4201,6 +4208,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>       list_del_rcu(&ns->list);
>>       mutex_unlock(&ctrl->namespaces_lock);
>>       synchronize_srcu(&ctrl->srcu);
>> +out_free_ns_stat:
>> +    nvme_free_ns_stat(ns);
>>    out_unlink_ns:
>>       mutex_lock(&ctrl->subsys->lock);
>>       list_del_rcu(&ns->siblings);
>> @@ -4244,6 +4253,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>        */
>>       synchronize_srcu(&ns->head->srcu);
>>   +    nvme_mpath_cancel_adaptive_path_weight_work(ns);
>> +
> 
> I personally think that the check on path stats should be done in the call-site
> and not in the function itself.
Hmm, can you please elaborate on this point further? I think, I am unable to get 
your point here.

> 
>>       /* wait for concurrent submissions */
>>       if (nvme_mpath_clear_current_path(ns))
>>           synchronize_srcu(&ns->head->srcu);
>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>> index c212fa952c0f..759d147d9930 100644
>> --- a/drivers/nvme/host/ioctl.c
>> +++ b/drivers/nvme/host/ioctl.c
>> @@ -700,18 +700,29 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
>>   int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
>>           unsigned int cmd, unsigned long arg)
>>   {
>> +    u8 opcode;
>>       struct nvme_ns_head *head = bdev->bd_disk->private_data;
>>       bool open_for_write = mode & BLK_OPEN_WRITE;
>>       void __user *argp = (void __user *)arg;
>>       struct nvme_ns *ns;
>>       int srcu_idx, ret = -EWOULDBLOCK;
>>       unsigned int flags = 0;
>> +    unsigned int op_type = NVME_STAT_OTHER;
>>         if (bdev_is_partition(bdev))
>>           flags |= NVME_IOCTL_PARTITION;
>>   +    if (cmd == NVME_IOCTL_SUBMIT_IO) {
>> +        if (get_user(opcode, (u8 *)argp))
>> +            return -EFAULT;
>> +        if (opcode == nvme_cmd_write)
>> +            op_type = NVME_STAT_WRITE;
>> +        else if (opcode == nvme_cmd_read)
>> +            op_type = NVME_STAT_READ;
>> +    }
>> +
>>       srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, op_type);
> 
> Perhaps it would be easier to review if you split passing opcode to nvme_find_path()
> to a prep patch (explaining that the new iopolicy will leverage it)
> 
Sure, makes sense. I'll split this into prep patch as you suggested.
>>       if (!ns)
>>           goto out_unlock;
>>   @@ -733,6 +744,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
>>   long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>>           unsigned long arg)
>>   {
>> +    u8 opcode;
>>       bool open_for_write = file->f_mode & FMODE_WRITE;
>>       struct cdev *cdev = file_inode(file)->i_cdev;
>>       struct nvme_ns_head *head =
>> @@ -740,9 +752,19 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>>       void __user *argp = (void __user *)arg;
>>       struct nvme_ns *ns;
>>       int srcu_idx, ret = -EWOULDBLOCK;
>> +    unsigned int op_type = NVME_STAT_OTHER;
>> +
>> +    if (cmd == NVME_IOCTL_SUBMIT_IO) {
>> +        if (get_user(opcode, (u8 *)argp))
>> +            return -EFAULT;
>> +        if (opcode == nvme_cmd_write)
>> +            op_type = NVME_STAT_WRITE;
>> +        else if (opcode == nvme_cmd_read)
>> +            op_type = NVME_STAT_READ;
>> +    }
>>         srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, op_type);
>>       if (!ns)
>>           goto out_unlock;
>>   @@ -762,7 +784,10 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>>       struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>>       struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>>       int srcu_idx = srcu_read_lock(&head->srcu);
>> -    struct nvme_ns *ns = nvme_find_path(head);
>> +    const struct nvme_uring_cmd *cmd = io_uring_sqe_cmd(ioucmd->sqe);
>> +    struct nvme_ns *ns = nvme_find_path(head,
>> +            READ_ONCE(cmd->opcode) & 1 ?
>> +            NVME_STAT_WRITE : NVME_STAT_READ);
>>       int ret = -EINVAL;
>>         if (ns)
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 543e17aead12..55dc28375662 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -6,6 +6,9 @@
>>   #include <linux/backing-dev.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/blk-mq.h>
>> +#include <linux/math64.h>
>> +#include <linux/rculist.h>
>>   #include <trace/events/block.h>
>>   #include "nvme.h"
>>   @@ -66,9 +69,10 @@ MODULE_PARM_DESC(multipath_always_on,
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
>> @@ -83,6 +87,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>>           iopolicy = NVME_IOPOLICY_RR;
>>       else if (!strncmp(val, "queue-depth", 11))
>>           iopolicy = NVME_IOPOLICY_QD;
>> +    else if (!strncmp(val, "adaptive", 8))
>> +        iopolicy = NVME_IOPOLICY_ADAPTIVE;
>>       else
>>           return -EINVAL;
>>   @@ -198,6 +204,204 @@ void nvme_mpath_start_request(struct request *rq)
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
>>   +static void nvme_mpath_weight_work(struct work_struct *weight_work)
>> +{
>> +    int cpu, srcu_idx;
>> +    u32 weight;
>> +    struct nvme_ns *ns;
>> +    struct nvme_path_stat *stat;
>> +    struct nvme_path_work *work = container_of(weight_work,
>> +            struct nvme_path_work, weight_work);
>> +    struct nvme_ns_head *head = work->ns->head;
>> +    int op_type = work->op_type;
>> +    u64 total_score = 0;
>> +
>> +    cpu = get_cpu();
>> +
>> +    srcu_idx = srcu_read_lock(&head->srcu);
>> +    list_for_each_entry_srcu(ns, &head->list, siblings,
>> +            srcu_read_lock_held(&head->srcu)) {
>> +
>> +        stat = &this_cpu_ptr(ns->info)[op_type].stat;
>> +        if (!READ_ONCE(stat->slat_ns)) {
>> +            stat->score = 0;
>> +            continue;
>> +        }
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
>> +     * (normalized to the range 0–64). The weight represents the
>> +     * relative share of I/O the path should receive.
>> +     *
>> +     *   - lower smoothed latency -> higher weight
>> +     *   - higher smoothed slatency -> lower weight
>> +     *
>> +     * Next, while forwarding I/O, we assign "credits" to each path
>> +     * based on its weight (please also refer nvme_adaptive_path()):
>> +     *   - Initially, credits = weight.
>> +     *   - Each time an I/O is dispatched on a path, its credits are
>> +     *     decremented proportionally.
>> +     *   - When a path runs out of credits, it becomes temporarily
>> +     *     ineligible until credit is refilled.
>> +     *
>> +     * I/O distribution is therefore governed by available credits,
>> +     * ensuring that over time the proportion of I/O sent to each
>> +     * path matches its weight (and thus its performance).
>> +     */
>> +    list_for_each_entry_srcu(ns, &head->list, siblings,
>> +            srcu_read_lock_held(&head->srcu)) {
>> +
>> +        stat = &this_cpu_ptr(ns->info)[op_type].stat;
>> +        weight = div_u64(stat->score * 64, total_score);
>> +
>> +        /*
>> +         * Ensure the path weight never drops below 1. A weight
>> +         * of 0 is used only for newly added paths. During
>> +         * bootstrap, a few I/Os are sent to such paths to
>> +         * establish an initial weight. Enforcing a minimum
>> +         * weight of 1 guarantees that no path is forgotten and
>> +         * that each path is probed at least occasionally.
>> +         */
>> +        if (!weight)
>> +            weight = 1;
>> +
>> +        WRITE_ONCE(stat->weight, weight);
>> +    }
>> +out:
>> +    srcu_read_unlock(&head->srcu, srcu_idx);
>> +    put_cpu();
>> +}
>> +
>> +/*
>> + * Formula to calculate the EWMA (Exponentially Weighted Moving Average):
>> + * ewma = (old_ewma * (EWMA_SHIFT - 1) + (EWMA_SHIFT)) / EWMA_SHIFT
>> + * For instance, with EWMA_SHIFT = 3, this assigns 7/8 (~87.5 %) weight to
>> + * the existing/old ewma and 1/8 (~12.5%) weight to the new sample.
>> + */
>> +static inline u64 ewma_update(u64 old, u64 new)
> 
> it is a calculation function, lets call it calc_ewma_update
Yeah, will do this in next patch version.

>> +{
>> +    return (old * ((1 << NVME_DEFAULT_ADP_EWMA_SHIFT) - 1)
>> +            + new) >> NVME_DEFAULT_ADP_EWMA_SHIFT;
>> +}
>> +
>> +static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
>> +{
>> +    int cpu;
>> +    unsigned int op_type;
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
>> +    op_type = nvme_data_dir(req_op(rq));
>> +    info = &per_cpu_ptr(ns->info, cpu)[op_type];
> 
> info is really really really confusing and generic and not representative of what
> "info" it is used for. maybe path_lat? or path_stats? anything is better than info.
> 
Maybe I am used to with this code and so I never realized it. But yes agreed, I 
will make it @path_lat.  

>> +    stat = &info->stat;
>> +
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
>> +        dev_warn_ratelimited(ns->ctrl->device,
>> +            "ignoring sample with >1s latency (possible controller stall or timeout)\n");
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
>> +        (now - stat->last_weight_ts) >= NVME_DEFAULT_ADP_WEIGHT_TIMEOUT) {
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
>> +            WRITE_ONCE(stat->slat_ns, avg_lat_ns);
>> +        else {
>> +            slat_ns = ewma_update(stat->slat_ns, avg_lat_ns);
>> +            WRITE_ONCE(stat->slat_ns, slat_ns);
>> +        }
>> +
>> +        stat->batch = stat->batch_count = 0;
>> +
>> +        /*
>> +         * Defer calculation of the path weight in per-cpu workqueue.
>> +         */
>> +        schedule_work_on(cpu, &info->work.weight_work);
> 
> I'm unsure if the percpu is a good choice here. Don't you want it per hctx at least?
> workloads tend to bounce quite a bit between cpu cores... we have systems with hundreds of
> cpu cores.
As I explained earlier, in NVMe multipath driver code we don't know hctx while
we choose path. The ctx to hctx mapping happens later in the block layer while
submitting bio. Here we calculate the path score per-cpu and utilize it while
choosing path to forward I/O.

> 
>> +    }
>> +}
>> +
>>   void nvme_mpath_end_request(struct request *rq)
>>   {
>>       struct nvme_ns *ns = rq->q->queuedata;
>> @@ -205,6 +409,9 @@ void nvme_mpath_end_request(struct request *rq)
>>       if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
>>           atomic_dec_if_positive(&ns->ctrl->nr_active);
>>   +    if (test_bit(NVME_NS_PATH_STAT, &ns->flags))
>> +        nvme_mpath_add_sample(rq, ns);
>> +
> 
> Doing all this work for EVERY completion is really worth it?
> sounds kinda like an overkill.
We don't really do much in nvme_mpath_add_sample() other than just 
adding latency sample into batch. The real work where we calculate
the patch score is done once every ~15 seconds and that is done 
under separate workqueu. So we don't do any heavy lifing here during
I/O completion processing. 

> 
>>       if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>>           return;
>>       bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
>> @@ -238,6 +445,62 @@ static const char *nvme_ana_state_names[] = {
>>       [NVME_ANA_CHANGE]        = "change",
>>   };
>>   +static void nvme_mpath_reset_adaptive_path_stat(struct nvme_ns *ns)
>> +{
>> +    int i, cpu;
>> +    struct nvme_path_stat *stat;
>> +
>> +    for_each_possible_cpu(cpu) {
>> +        for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
>> +            stat = &per_cpu_ptr(ns->info, cpu)[i].stat;
>> +            memset(stat, 0, sizeof(struct nvme_path_stat));
>> +        }
>> +    }
>> +}
>> +
>> +void nvme_mpath_cancel_adaptive_path_weight_work(struct nvme_ns *ns)
>> +{
>> +    int i, cpu;
>> +    struct nvme_path_info *info;
>> +
>> +    if (!test_bit(NVME_NS_PATH_STAT, &ns->flags))
>> +        return;
>> +
>> +    for_each_online_cpu(cpu) {
>> +        for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
>> +            info = &per_cpu_ptr(ns->info, cpu)[i];
>> +            cancel_work_sync(&info->work.weight_work);
>> +        }
>> +    }
>> +}
>> +
>> +static bool nvme_mpath_enable_adaptive_path_policy(struct nvme_ns *ns)
>> +{
>> +    struct nvme_ns_head *head = ns->head;
>> +
>> +    if (!head->disk || head->subsys->iopolicy != NVME_IOPOLICY_ADAPTIVE)
>> +        return false;
>> +
>> +    if (test_and_set_bit(NVME_NS_PATH_STAT, &ns->flags))
>> +        return false;
>> +
>> +    blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, ns->queue);
> 
> This is an undocumented change...
Sure, I would add comment in this code in the next patch version.

> 
>> +    blk_stat_enable_accounting(ns->queue);
>> +    return true;
>> +}
>> +
>> +static bool nvme_mpath_disable_adaptive_path_policy(struct nvme_ns *ns)
>> +{
>> +
>> +    if (!test_and_clear_bit(NVME_NS_PATH_STAT, &ns->flags))
>> +        return false;
>> +
>> +    blk_stat_disable_accounting(ns->queue);
>> +    blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, ns->queue);
>> +    nvme_mpath_reset_adaptive_path_stat(ns);
>> +    return true;
>> +}
>> +
>>   bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
>>   {
>>       struct nvme_ns_head *head = ns->head;
>> @@ -253,6 +516,8 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
>>               changed = true;
>>           }
>>       }
>> +    if (nvme_mpath_disable_adaptive_path_policy(ns))
>> +        changed = true;
> 
> Don't understand why you are setting changed here? it relates to of the current_path
> was changed. doesn't make sense to me.
> 
I think you were correct. We don't have any rcu update here for adaptive path. 
Will remove this.

>>   out:
>>       return changed;
>>   }
>> @@ -271,6 +536,45 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>>       srcu_read_unlock(&ctrl->srcu, srcu_idx);
>>   }
>>   +int nvme_alloc_ns_stat(struct nvme_ns *ns)
>> +{
>> +    int i, cpu;
>> +    struct nvme_path_work *work;
>> +    gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
>> +
>> +    if (!ns->head->disk)
>> +        return 0;
>> +
>> +    ns->info = __alloc_percpu_gfp(NVME_NUM_STAT_GROUPS *
>> +            sizeof(struct nvme_path_info),
>> +            __alignof__(struct nvme_path_info), gfp);
>> +    if (!ns->info)
>> +        return -ENOMEM;
>> +
>> +    for_each_possible_cpu(cpu) {
>> +        for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
>> +            work = &per_cpu_ptr(ns->info, cpu)[i].work;
>> +            work->ns = ns;
>> +            work->op_type = i;
>> +            INIT_WORK(&work->weight_work, nvme_mpath_weight_work);
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void nvme_mpath_set_ctrl_paths(struct nvme_ctrl *ctrl)
> 
> Does this function set any ctrl paths? your code is very confusing.
> 
Here ctrl path means, we iterate through each controller namespaces-path 
and then sets/enable the adaptive path parameters required for each path. 
Moreover, we already have corresponding nvme_mpath_clear_ctrl_paths()
function which resets/clears the per-path parameters while chanigng I/O
policy. 

>> +{
>> +    struct nvme_ns *ns;
>> +    int srcu_idx;
>> +
>> +    srcu_idx = srcu_read_lock(&ctrl->srcu);
>> +    list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
>> +                srcu_read_lock_held(&ctrl->srcu))
>> +        nvme_mpath_enable_adaptive_path_policy(ns);
>> +    srcu_read_unlock(&ctrl->srcu, srcu_idx);
> 
> seems like it enables the iopolicy on all ctrl namespaces.
> the enable should also be more explicit like:
> nvme_enable_ns_lat_sampling or something like that.
> 
okay, I'll rename it to the appropriate function name, as you suggested. 

>> +}
>> +
>>   void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
>>   {
>>       struct nvme_ns_head *head = ns->head;
>> @@ -283,6 +587,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
>>                    srcu_read_lock_held(&head->srcu)) {
>>           if (capacity != get_capacity(ns->disk))
>>               clear_bit(NVME_NS_READY, &ns->flags);
>> +
>> +        nvme_mpath_reset_adaptive_path_stat(ns);
>>       }
>>       srcu_read_unlock(&head->srcu, srcu_idx);
>>   @@ -407,6 +713,92 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
>>       return found;
>>   }
>>   +static inline bool nvme_state_is_live(enum nvme_ana_state state)
>> +{
>> +    return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
>> +}
>> +
>> +static struct nvme_ns *nvme_adaptive_path(struct nvme_ns_head *head,
>> +        unsigned int op_type)
>> +{
>> +    struct nvme_ns *ns, *start, *found = NULL;
>> +    struct nvme_path_stat *stat;
>> +    u32 weight;
>> +    int cpu;
>> +
>> +    cpu = get_cpu();
>> +    ns = *this_cpu_ptr(head->adp_path);
>> +    if (unlikely(!ns)) {
>> +        ns = list_first_or_null_rcu(&head->list,
>> +                struct nvme_ns, siblings);
>> +        if (unlikely(!ns))
>> +            goto out;
>> +    }
>> +found_ns:
>> +    start = ns;
>> +    while (nvme_path_is_disabled(ns) ||
>> +            !nvme_state_is_live(ns->ana_state)) {
>> +        ns = list_next_entry_circular(ns, &head->list, siblings);
>> +
>> +        /*
>> +         * If we iterate through all paths in the list but find each
>> +         * path in list is either disabled or dead then bail out.
>> +         */
>> +        if (ns == start)
>> +            goto out;
>> +    }
>> +
>> +    stat = &this_cpu_ptr(ns->info)[op_type].stat;
>> +
>> +    /*
>> +     * When the head path-list is singular we don't calculate the
>> +     * only path weight for optimization as we don't need to forward
>> +     * I/O to more than one path. The another possibility is whenthe
>> +     * path is newly added, we don't know its weight. So we go round
>> +     * -robin for each such path and forward I/O to it.Once we start
>> +     * getting response for such I/Os, the path weight calculation
>> +     * would kick in and then we start using path credit for
>> +     * forwarding I/O.
>> +     */
>> +    weight = READ_ONCE(stat->weight);
>> +    if (!weight) {
>> +        found = ns;
>> +        goto out;
>> +    }
>> +
>> +    /*
>> +     * To keep path selection logic simple, we don't distinguish
>> +     * between ANA optimized and non-optimized states. The non-
>> +     * optimized path is expected to have a lower weight, and
>> +     * therefore fewer credits. As a result, only a small number of
>> +     * I/Os will be forwarded to paths in the non-optimized state.
>> +     */
>> +    if (stat->credit > 0) {
>> +        --stat->credit;
>> +        found = ns;
>> +        goto out;
>> +    } else {
>> +        /*
>> +         * Refill credit from path weight and move to next path. The
>> +         * refilled credit of the current path will be used next when
>> +         * all remainng paths exhaust its credits.
>> +         */
>> +        weight = READ_ONCE(stat->weight);
>> +        stat->credit = weight;
>> +        ns = list_next_entry_circular(ns, &head->list, siblings);
>> +        if (likely(ns))
>> +            goto found_ns;
>> +    }
>> +out:
>> +    if (found) {
>> +        stat->sel++;
>> +        *this_cpu_ptr(head->adp_path) = found;
>> +    }
>> +
>> +    put_cpu();
>> +    return found;
>> +}
>> +
>>   static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
>>   {
>>       struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
>> @@ -463,9 +855,12 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
>>       return ns;
>>   }
>>   -inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>> +inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
>> +        unsigned int op_type)
>>   {
>>       switch (READ_ONCE(head->subsys->iopolicy)) {
>> +    case NVME_IOPOLICY_ADAPTIVE:
>> +        return nvme_adaptive_path(head, op_type);
>>       case NVME_IOPOLICY_QD:
>>           return nvme_queue_depth_path(head);
>>       case NVME_IOPOLICY_RR:
>> @@ -525,7 +920,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>>           return;
>>         srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, nvme_data_dir(bio_op(bio)));
>>       if (likely(ns)) {
>>           bio_set_dev(bio, ns->disk->part0);
>>           bio->bi_opf |= REQ_NVME_MPATH;
>> @@ -567,7 +962,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
>>       int srcu_idx, ret = -EWOULDBLOCK;
>>         srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, NVME_STAT_OTHER);
>>       if (ns)
>>           ret = nvme_ns_get_unique_id(ns, id, type);
>>       srcu_read_unlock(&head->srcu, srcu_idx);
>> @@ -583,7 +978,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
>>       int srcu_idx, ret = -EWOULDBLOCK;
>>         srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, NVME_STAT_OTHER);
>>       if (ns)
>>           ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
>>       srcu_read_unlock(&head->srcu, srcu_idx);
>> @@ -725,6 +1120,9 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>       INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
>>       INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
>>       head->delayed_removal_secs = 0;
>> +    head->adp_path = alloc_percpu_gfp(struct nvme_ns*, GFP_KERNEL);
>> +    if (!head->adp_path)
>> +        return -ENOMEM;
>>         /*
>>        * If "multipath_always_on" is enabled, a multipath node is added
>> @@ -809,6 +1207,10 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>>       }
>>       mutex_unlock(&head->lock);
>>   +    mutex_lock(&nvme_subsystems_lock);
>> +    nvme_mpath_enable_adaptive_path_policy(ns);
>> +    mutex_unlock(&nvme_subsystems_lock);
>> +
>>       synchronize_srcu(&head->srcu);
>>       kblockd_schedule_work(&head->requeue_work);
>>   }
>> @@ -857,11 +1259,6 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
>>       return 0;
>>   }
>>   -static inline bool nvme_state_is_live(enum nvme_ana_state state)
>> -{
>> -    return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
>> -}
>> -
>>   static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>>           struct nvme_ns *ns)
>>   {
>> @@ -1039,10 +1436,12 @@ static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
>>         WRITE_ONCE(subsys->iopolicy, iopolicy);
>>   -    /* iopolicy changes clear the mpath by design */
>> +    /* iopolicy changes clear/reset the mpath by design */
>>       mutex_lock(&nvme_subsystems_lock);
>>       list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>>           nvme_mpath_clear_ctrl_paths(ctrl);
>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>> +        nvme_mpath_set_ctrl_paths(ctrl);
>>       mutex_unlock(&nvme_subsystems_lock);
>>         pr_notice("subsysnqn %s iopolicy changed from %s to %s\n",
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 102fae6a231c..715c7053054c 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -28,7 +28,10 @@ extern unsigned int nvme_io_timeout;
>>   extern unsigned int admin_timeout;
>>   #define NVME_ADMIN_TIMEOUT    (admin_timeout * HZ)
>>   -#define NVME_DEFAULT_KATO    5
>> +#define NVME_DEFAULT_KATO        5
>> +
>> +#define NVME_DEFAULT_ADP_EWMA_SHIFT    3
>> +#define NVME_DEFAULT_ADP_WEIGHT_TIMEOUT    (15 * NSEC_PER_SEC)
> 
> You need these defines outside of nvme-mpath?
> 
Currently, those macros are used in nvme/host/core.c. 
I can move this inisde that source file. 

>>     #ifdef CONFIG_ARCH_NO_SG_CHAIN
>>   #define  NVME_INLINE_SG_CNT  0
>> @@ -421,6 +424,7 @@ enum nvme_iopolicy {
>>       NVME_IOPOLICY_NUMA,
>>       NVME_IOPOLICY_RR,
>>       NVME_IOPOLICY_QD,
>> +    NVME_IOPOLICY_ADAPTIVE,
>>   };
>>     struct nvme_subsystem {
>> @@ -459,6 +463,37 @@ struct nvme_ns_ids {
>>       u8    csi;
>>   };
>>   +enum nvme_stat_group {
>> +    NVME_STAT_READ,
>> +    NVME_STAT_WRITE,
>> +    NVME_STAT_OTHER,
>> +    NVME_NUM_STAT_GROUPS
>> +};
> 
> I see you have stats per io direction. However you don't have it per IO size. I wonder
> how this plays into this iopolicy.
> 
Yes you're correct, and as mentioned earlier we'd measure latecy per 
512 byte blocks size.

>> +
>> +struct nvme_path_stat {
>> +    u64 nr_samples;        /* total num of samples processed */
>> +    u64 nr_ignored;        /* num. of samples ignored */
>> +    u64 slat_ns;        /* smoothed (ewma) latency in nanoseconds */
>> +    u64 score;        /* score used for weight calculation */
>> +    u64 last_weight_ts;    /* timestamp of the last weight calculation */
>> +    u64 sel;        /* num of times this path is selcted for I/O */
>> +    u64 batch;        /* accumulated latency sum for current window */
>> +    u32 batch_count;    /* num of samples accumulated in current window */
>> +    u32 weight;        /* path weight */
>> +    u32 credit;        /* path credit for I/O forwarding */
>> +};
> 
> I'm still not convinced that having this be per-cpu-per-ns really makes sense.

I understand your concern about whether it really makes sense to keep this 
per-cpu-per-ns, and I see your point that you would prefer maintaining the
stat per-hctx instead of per-CPU.

However, as mentioned earlier, during path selection we cannot reliably map an
I/O to a specific hctx, so using per-hctx statistics becomes problematic in 
practice. On the other hand, maintaining the metrics per-CPU has an additional
advantage: on a NUMA-aware system, the measured I/O latency naturally reflects
the NUMA distance between the workload’s CPU and the I/O controller. This means
that on multi-node systems, the policy can automatically favor I/O paths/controllers
that are local/near to the CPU issuing the request, which may lead to better
latency characteristics.

Really appreciate your feedback/comments!

Thanks,
--Nilay


