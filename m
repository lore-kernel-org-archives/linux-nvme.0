Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BCCC5B56A
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s32epwG8Au0JmORGq+6gQMMB7pNUqnNsP7ZlxJtNYEU=; b=fCDP4soFpQ/e8P+etnBPBcn4g2
	HNR8yHIa4TAPM7Yfxn+j0v1Ezkl+HtmTQdDTQNrxiOLwkiQfES5GDeUM2O99Ycb595rr8WZLhR3Qi
	7bgvUOtOkvFUE30gp91h1Stqx2+gpQPW9XHXjjw1mJ3OqoYahSHy6zZcK5rGRza8w6NQ1be0vxZd1
	uGd/tYd9z1flkdUwMr3Tq9NG1WzF8OBOCaYniPZ+Zbu9QAROqTPoKXoR8wk/xT1mUDwmsR6DWbZXw
	+qTlfjjLk8ZZAUnpwuJ8ewRJJG7mBy8vJWVsvkO/lcm/uOkefKzh7oiZzg837iVwrbuQVoIlKGqfR
	/F7sZpSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTfT-0000000CV8F-3FMU;
	Mon, 10 Aug 2026 17:20:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTfQ-0000000CV7X-3923
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 17:20:05 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGVbTZ2069369;
	Mon, 10 Aug 2026 17:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s32epw
	G8Au0JmORGq+6gQMMB7pNUqnNsP7ZlxJtNYEU=; b=c8P1Z9tpdfKn+BNnTqhMGb
	bKIJm8rDDFz3xgX0JzjNMy2USLI5fKSdyFP1HUu3l6OumBHH8TkyTnbH6MfU3eIy
	mlv8ymShFuiJ0V0zb2AXgEfaTisVq+FheNpl0LfUqAQvY/z3rp6JnX7UnHzVh8xM
	wd6AQAfJuFx38WOC3TRB1eSlfRX5bKqo4zc21nstZ9fDQ6rSlH9VvvRMv899mFgW
	ZjXOjmmESH9dILMsPA1dOCDc27rWN+hIeBOFl4tk0+3B6nyuLdufquXJ/mBIuf1l
	8xiyyYJFZV9g5qtxHkvDR2JzPzHRHejAiKfygWfIpH4Es0MDq9kn+CanTJKQ0c8A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2rt6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 17:19:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AHBSDn006784;
	Mon, 10 Aug 2026 17:19:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g5kuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 17:19:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AHJmS228836542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 17:19:48 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF4C35805F;
	Mon, 10 Aug 2026 17:19:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EE9C58058;
	Mon, 10 Aug 2026 17:19:43 +0000 (GMT)
Received: from [9.43.109.88] (unknown [9.43.109.88])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 17:19:42 +0000 (GMT)
Message-ID: <dc2bb999-ca97-4899-8470-c95a80ae1229@linux.ibm.com>
Date: Mon, 10 Aug 2026 22:49:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] nvme-multipath: pass I/O type to nvme_find_path()
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-4-nilay@linux.ibm.com>
 <f6daf09b-338d-4518-9d1a-a172b3c2bef5@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <f6daf09b-338d-4518-9d1a-a172b3c2bef5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7a0835 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=b23waOSzvKwLCPFMUBIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vgnBJ2_ucyft29wBmS-wgO32ier7S_Fj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE0NiBTYWx0ZWRfX+Sz8o7M932Ky
 wMRCmSuL3f7N/FjM+G8zjx/j3wApN7g2/qNsPM/VwUiJJ3ulQiVdSQ0lR3Vf3CHZFeb5kZfD6tM
 QT5cZneCjF6BRqdhb42h+ODKExd/az1ZWpPCppvqdQgROB5S8trB+c1ONpFXyE+gMBtRfRP4P+Q
 Acqswt4B3sQBXulC+lGEX+TPLHz8OzlZ1nYF5rTVBuPja5hcZkig2/XMmw0/fUKXYTT0sWmrW9G
 TdfR9mrbODFhvPw9J29lu9phTOwgVl0AuELLYDyLZEIi8DvoK95r9BRwN7ZRvw/BvZgx9jjtKtO
 6OCFATzI4aH1iII/dqJh4nBiOlu3hpM3LZE9WyfWmvfVvWIHEiUry4nzMSHrlUSeQyacwpCLH5d
 Ve5/TkoqsMJqeOSei43Apdun5aOMYBF3Z2EeZGYyvOXV2oIie0VcCZWiY0CmZ8LNTxfxJGEzi9l
 KWNteYMBP/nTI/TJcAw==
X-Proofpoint-ORIG-GUID: wd4aozlWBGESSjOQ6vz68H_WxTCYoJCt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE0NiBTYWx0ZWRfX7qJwIOvXOsIz
 twHAiA5B89GxxsWAiBwG5Var5lMoeyNAJ/PVyomm+HptPSHoD3ZC9jTFdomtFe2ZoNH6bG6JVVJ
 QPRNwhPXVWZLDH3HDAApxPdwsnSN46M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_102004_917294_44583427 
X-CRM114-Status: GOOD (  31.53  )
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

On 8/10/26 2:27 PM, John Garry wrote:
>> @@ -741,6 +752,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
>>    long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>>            unsigned long arg)
>>    {
>> +    u8 opcode;
> 
> why declared at the top?
> 
yes will move it close to its first use.

>>        bool open_for_write = file->f_mode & FMODE_WRITE;
>>        struct cdev *cdev = file_inode(file)->i_cdev;
>>        struct nvme_ns_head *head =
>> @@ -748,9 +760,19 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>>        void __user *argp = (void __user *)arg;
>>        struct nvme_ns *ns;
>>        int srcu_idx, ret = -EWOULDBLOCK;
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
>>        srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, op_type);
>>        if (!ns)
>>            goto out_unlock;
>> @@ -770,9 +792,19 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>>        struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>>        struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>>        int srcu_idx = srcu_read_lock(&head->srcu);
>> -    struct nvme_ns *ns = nvme_find_path(head);
>> +    struct nvme_ns *ns;
>>        int ret = -EINVAL;
>> +    const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
>> +                        struct nvme_uring_cmd);
>> +    unsigned int op_type = NVME_STAT_OTHER;
>> +    __u8 opcode = READ_ONCE(cmd->opcode);
>> +
>> +    if (opcode == nvme_cmd_write)
>> +        op_type = NVME_STAT_WRITE;
>> +    else if (opcode == nvme_cmd_read)
>> +        op_type = NVME_STAT_READ;
> 
> nit: I think that having a final else leg to set op_type is nicer than setting to NVME_STAT_OTHER at init time (and overwriting in some cases).
> 
okay will address this in next version.

>> +    ns = nvme_find_path(head, op_type);
>>        if (ns)
>>            ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
>>        srcu_read_unlock(&head->srcu, srcu_idx);
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 9b9a657fa330..8c20ff516e61 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -460,7 +460,8 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
>>        return ns;
>>    }
>> -inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>> +inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
>> +        unsigned int op_type)
>>    {
>>        switch (READ_ONCE(head->subsys->iopolicy)) {
>>        case NVME_IOPOLICY_QD:
>> @@ -522,7 +523,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>>            return;
>>        srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, __nvme_data_dir(bio_op(bio)));
> 
> It's a but unfortunate that we have to find op_type even for when not using the latency iopolicy.
> 
I looked at a few alternatives to avoid passing op_type into
nvme_find_path(), but couldn't find a cleaner approach.
Fortunately, determining op_type is inexpensive, so I don't
expect it to have any measurable performance impact.

>>        if (likely(ns)) {
>>            bio_set_dev(bio, ns->disk->part0);
>>            /*
>> @@ -572,7 +573,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
>>        int srcu_idx, ret = -EWOULDBLOCK;
>>        srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, NVME_STAT_OTHER);
>>        if (ns)
>>            ret = nvme_ns_get_unique_id(ns, id, type);
>>        srcu_read_unlock(&head->srcu, srcu_idx);
>> @@ -588,7 +589,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
>>        int srcu_idx, ret = -EWOULDBLOCK;
>>        srcu_idx = srcu_read_lock(&head->srcu);
>> -    ns = nvme_find_path(head);
>> +    ns = nvme_find_path(head, NVME_STAT_OTHER);
>>        if (ns)
>>            ret = nvme_ns_report_zones(ns, sector, nr_zones, args);
>>        srcu_read_unlock(&head->srcu, srcu_idx);
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 824651cc898d..8a9ec502912d 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -520,6 +520,13 @@ struct nvme_ns_ids {
>>        u8    csi;
>>    };
>> +enum nvme_stat_group {
>> +    NVME_STAT_READ,
>> +    NVME_STAT_WRITE,
>> +    NVME_STAT_OTHER,
> 
> Would NVME_STAT_OTHER ever be used in high frequency scenarios such that it is worth having its own type? If not, could NVME_STAT_READ be reused?
> 
It may not be used in high-throughput scenarios, but treating these
commands as READ or WRITE would unnecessarily skew the latency statistics
for actual read/write workloads. Keeping them in a separate category
avoids that distortion, so I think having NVME_STAT_OTHER makes sense.

>> +    NVME_NUM_STAT_GROUPS
> 
> Can these ever be used for non-mulitpath? I just wonder why multipath or similar is not in the name
> 
Today they're only used by the multipath code. I kept the names generic
because they simply classify NVMe operations into READ/WRITE/OTHER based
on the command opcode, which isn't inherently multipath-specific.

>> +};
>> +
>>    /*
>>     * Anchor structure for namespaces.  There is one for each namespace in a
>>     * NVMe subsystem that any of our controllers can see, and the namespace
>> @@ -1032,7 +1039,39 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
>>    extern const struct block_device_operations nvme_bdev_ops;
>>    void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
>> -struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
>> +struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, unsigned int op_type);
>> +
>> +static inline int __nvme_data_dir(const enum req_op op)
>> +{
> 
> This returns an int (so not strongly typed), which is going to be NVME_STAT_READ, NVME_STAT_WRITE, or NVME_STAT_OTHER. From the function name, I am not sure if that it expected. Some might expect READ or WRITE returned. 'stat' should be in the name, or similar.
Good point. I'll change the return type to enum nvme_stat_group and
rename the helper to better reflect that it returns a stat group
rather than a data direction.

> 
>> +    if (op == REQ_OP_READ)
>> +        return NVME_STAT_READ;
>> +    else if (op == REQ_OP_WRITE)
>> +        return NVME_STAT_WRITE;
>> +    else
>  > +        return NVME_STAT_OTHER;> +}
>> +
>> +static inline int __nvme_data_dir_passthru(enum nvme_opcode op)
>> +{
> 
> As __nvme_data_dir
Yes, I'll make the same change there as well.

> 
>> +    if (op == nvme_cmd_read)
>> +        return NVME_STAT_READ;
>> +    else if (op == nvme_cmd_write)
>> +        return NVME_STAT_WRITE;
>> +    else
>> +        return NVME_STAT_OTHER;
>> +}
>> +
>> +static inline int nvme_data_dir(struct request *req)
> 
> As __nvme_data_dir
> 
Yes, I'll make the same change there as well.

Thanks,
--Nilay

