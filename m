Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B63C55160
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BrFJ4EzykIjtfv6Pxd6NjOjW60mEYMbewLkfvdyDoHQ=; b=fPbtWlnLM7I0v81h/xkwDzGo4b
	XvkFVWgdLNJ8C2FI7wbi/cUCJcaPdHZigA6u3Wy9sZekPK+Lia9UGoYKVFXV9m/GqMi8sG0XTvNmI
	kE2SV43G5RGwva9M/3Osl/ko5rUjYhYrxRbN3ijoYqSTHC7TJ25wkvMNmFAMCDvmZzF5ohaxA/qmE
	diCpm42c8RTpuSR8DcOKRxDh4SGuuRd+yOM/OZg3FPaPtmLFIO7NrvnWFST9fspclRaKL5vKweVqg
	Z0wRmFMLyzPjpsjyyiQvZP9GHAVuQceebL8PfH1BVxUbRo7QrpJpHLacz3cYvGv9GXCnF3vZrYm+K
	gUd8AIVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPS9-0000000APS6-0JkR;
	Thu, 30 Jul 2026 12:01:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPS5-0000000APRL-3kxg
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 12:01:31 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHrFn2760687;
	Thu, 30 Jul 2026 12:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BrFJ4E
	zykIjtfv6Pxd6NjOjW60mEYMbewLkfvdyDoHQ=; b=rxpmbLALZWzUBbz+qaBsag
	E8DGACDdlHhBRe3CpR5vIJZBDOXwNSyMGSUB62jtFE0pKV2K2agNxwlv/x2tusQS
	70CoBRlCOOZibvqKX+ewpCRm8r8KEqfw6xfvR2R5ffASBzj0PBUbVTEL39upBCc3
	8HATmEF6hcIV0f+a5uhWALeRPBD1RGjZ93U4Fwl/umjqqd6SGhvZTBwiJlUwEWDL
	8kTvc48LKJW18XtY9pmaiGRirSUCFu26Dg+QyAWclL6zOpClGj8SHkcF+L8zEU4H
	mWXw8D3+QpyNy2NbeeLHtHSeQd9zOPIhrVPlw6Tmb37lstPxyKoVgUI8PX9Mz1Xg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd6pj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 12:01:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UBuGHA008832;
	Thu, 30 Jul 2026 12:01:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhk3d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 12:01:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UC1GBt31457996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 12:01:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C738658064;
	Thu, 30 Jul 2026 12:01:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47DE758061;
	Thu, 30 Jul 2026 12:01:13 +0000 (GMT)
Received: from [9.43.106.218] (unknown [9.43.106.218])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 12:01:12 +0000 (GMT)
Message-ID: <83701c38-ba9e-4134-85f0-e11e1129375d@linux.ibm.com>
Date: Thu, 30 Jul 2026 17:31:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
To: Guixin Liu <kanie@linux.alibaba.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <20251105103347.86059-3-nilay@linux.ibm.com>
 <61fb25bf-3ee1-4400-8b65-ea6cfe27b9a2@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <61fb25bf-3ee1-4400-8b65-ea6cfe27b9a2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 2CY7hxg-wXVGJ5gvSOWe9yGRngui52jh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX7kQaXX9gbSto
 LYaJNmGBOZjlcy9CmGVlNMpYxQ4EGl7anxlopdvzBLpA6totfZ/DtZpagAtu+eylYOQJRtgXI8y
 dH5fHXBOFt25o2gOJyzKQi+1BtfW/cM=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b3d0e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=LQ7CPBkDTJ-YLoJuaowA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfXxOKtZNAzoPAZ
 06Xu0uU7ngVqHS0d4pdWz/2icDrm1sO68OPlqfAAQW4hk97aWB9HJbaXTY5QapJYTAtPdVIccgu
 w0A/UpRBHyIMn3Hu98UPvRUCbVqqKQaGZneLqM/5bK7bAharebEwPwI+OSZi7LZ8zEL3/AFKl+p
 aMpXZwiRayfukmxRTh5ywMu8IpJZvd3yu5MM9eBTG0lbwpP5AExLui7NceuNW8kc2mw6tOqYHAL
 sfK/tHWY48togN9jYJiW5BOLHsyXgAIBbty/Pz9mxR85lvRdSBdRJj1shRWLv8pWiinhjSC6Z7U
 zLkW+uppjpA+bB6xHVnaydiSNvBPEvzfg0Z/JrKgnP0eYPWvIfedE5w+2IieqlJTdalMZz/oW7J
 fBDRpxdr+A357IkfliTmSpmQFBP25wweC+/hsW1tyxzZGrSSOkfZjc0Tr/XnsMLIulWm5FhZWCi
 OUme8Q7ivouGg3CGfKw==
X-Proofpoint-GUID: Cia7lAkV56VSSlOLU0zOEKt6GFMDYi-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_050130_077262_2DB1472B 
X-CRM114-Status: GOOD (  35.84  )
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

On 7/29/26 1:25 PM, Guixin Liu wrote:
> Hi,
>    Raise some comments to see if we can keep moving this
> feature forward.
>    Once this feature is merged, I'll be able to build the
> service-time I/O policy on top of it.
> 
Thanks for the review! BTW we alreday have patch revision v6
upstream now. You may find it here (in case you missed it):
https://lore.kernel.org/all/20260520182112.863076-1-nilay@linux.ibm.com/

> 
> 在 2025/11/5 18:33, Nilay Shroff 写道:
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
>> @@ -689,6 +692,7 @@ static void nvme_free_ns(struct kref *kref)
>>   {
>>       struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
>> +    nvme_free_ns_stat(ns);
>>       put_disk(ns->disk);
>>       nvme_put_ns_head(ns->head);
>>       nvme_put_ctrl(ns->ctrl);
>> @@ -4137,6 +4141,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>       if (nvme_init_ns_head(ns, info))
>>           goto out_cleanup_disk;
>> +    if (nvme_alloc_ns_stat(ns))
>> +        goto out_unlink_ns;
>> +
>>       /*
>>        * If multipathing is enabled, the device name for all disks and not
>>        * just those that represent shared namespaces needs to be based on the
>> @@ -4161,7 +4168,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>       }
>>       if (nvme_update_ns_info(ns, info))
>> -        goto out_unlink_ns;
>> +        goto out_free_ns_stat;
>>       mutex_lock(&ctrl->namespaces_lock);
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
>> +    nvme_mpath_cancel_adaptive_path_weight_work(ns);
>> +
> 
> Here cancel weight_work first and only then clear the NVME_NS_PATH_STAT flag.
> 
> During this window, nvme_mpath_end_request() may see that the NVME_NS_PATH_STAT
> 
> flag is still set and re-queue weight_work.
> 
> Therefore, you should clear the NVME_NS_PATH_STAT flag first and then cancel weight_work.

Yes, agreed, good catch! That said, we also need to ensure that ns is not removed
while weight work is scheduled or in progress. Will handle this in next revision.

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
>>       if (bdev_is_partition(bdev))
>>           flags |= NVME_IOCTL_PARTITION;
>> +    if (cmd == NVME_IOCTL_SUBMIT_IO) {
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
>>       if (!ns)
>>           goto out_unlock;
>> @@ -733,6 +744,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
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
>>       srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, op_type);
>>       if (!ns)
>>           goto out_unlock;
>> @@ -762,7 +784,10 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>>       struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>>       struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>>       int srcu_idx = srcu_read_lock(&head->srcu);
>> -    struct nvme_ns *ns = nvme_find_path(head);
>> +    const struct nvme_uring_cmd *cmd = io_uring_sqe_cmd(ioucmd->sqe);
>> +    struct nvme_ns *ns = nvme_find_path(head,
>> +            READ_ONCE(cmd->opcode) & 1 ?
>> +            NVME_STAT_WRITE : NVME_STAT_READ);
> Here using nvme_cmd's opcode to find the path, but on the completion side using
> req_op(rq) to count.
> 
> For passthrough IOs, the req_op(rq) is REQ_OP_DRV_IN or REQ_OP_DRV_OUT, this cause
> nvme_data_dir() return OTHER when the IO is nvme read, and also broken to flush and write_zeros.

Yeah true... will fix this in next revision.

>>       int ret = -EINVAL;
>>       if (ns)
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
>> @@ -66,9 +69,10 @@ MODULE_PARM_DESC(multipath_always_on,
>>       "create multipath node always except for private namespace with non-unique nsid; note that this also implicitly enables native multipath support");
>>   static const char *nvme_iopolicy_names[] = {
>> -    [NVME_IOPOLICY_NUMA]    = "numa",
>> -    [NVME_IOPOLICY_RR]    = "round-robin",
>> -    [NVME_IOPOLICY_QD]      = "queue-depth",
>> +    [NVME_IOPOLICY_NUMA]     = "numa",
>> +    [NVME_IOPOLICY_RR]     = "round-robin",
>> +    [NVME_IOPOLICY_QD]       = "queue-depth",
>> +    [NVME_IOPOLICY_ADAPTIVE] = "adaptive",
>>   };
>>   static int iopolicy = NVME_IOPOLICY_NUMA;
>> @@ -83,6 +87,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>>           iopolicy = NVME_IOPOLICY_RR;
>>       else if (!strncmp(val, "queue-depth", 11))
>>           iopolicy = NVME_IOPOLICY_QD;
>> +    else if (!strncmp(val, "adaptive", 8))
>> +        iopolicy = NVME_IOPOLICY_ADAPTIVE;
>>       else
>>           return -EINVAL;
>> @@ -198,6 +204,204 @@ void nvme_mpath_start_request(struct request *rq)
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
>> +static void nvme_mpath_weight_work(struct work_struct *weight_work)
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
>> +    }
>> +}
>> +
>>   void nvme_mpath_end_request(struct request *rq)
>>   {
>>       struct nvme_ns *ns = rq->q->queuedata;
>> @@ -205,6 +409,9 @@ void nvme_mpath_end_request(struct request *rq)
>>       if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
>>           atomic_dec_if_positive(&ns->ctrl->nr_active);
>> +    if (test_bit(NVME_NS_PATH_STAT, &ns->flags))
>> +        nvme_mpath_add_sample(rq, ns);
>> +
>>       if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>>           return;
>>       bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
>> @@ -238,6 +445,62 @@ static const char *nvme_ana_state_names[] = {
>>       [NVME_ANA_CHANGE]        = "change",
>>   };
>> +static void nvme_mpath_reset_adaptive_path_stat(struct nvme_ns *ns)
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
> The adp_path still hold the ns's pointer, should clear too,
> otherwise, we will access a freed ns.
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
>>   out:
>>       return changed;
>>   }
>> @@ -271,6 +536,45 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>>       srcu_read_unlock(&ctrl->srcu, srcu_idx);
>>   }
>> +int nvme_alloc_ns_stat(struct nvme_ns *ns)
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
> Should alloc this only when the user use the adaptive io policy?
> 
That's possible but I'd prefer instead allocating it while ns is allocated.
That would reduce unnecessary complexities when user updates or switches
iopolicy from/to adaptive.

Thanks,
--Nilay


