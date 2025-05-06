Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA3CC3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bZVfdftTzfZqnJIQktyhvG19d0Vtpd/s79SmU+boEPo=; b=LOxLyQzqUugMKhtbsc8EEjtIpT
	DumNLQagGvr6dOid3qdPvDFEqatnIm+Kn/C6OSYDPL+xwFSqRLoKbLv1MZw1LdYbp5fg6Je5wvzaQ
	jkygXXcRbObAlmogxRUXDYAzbQHyMy/FeMORDZoKjCgEWKckQ4+VSm6tXfZsi03Z7PM56Au56t9oe
	pfk6vRIyjm6kUxqAEJLZ2pi211qkIW8EHPor0xTENLFvOhGl89r8wfOa+IFCe550lcQxck421Fttk
	vamVkFH/31+VeGOI1FKSu/p8CQOicTeQ2lxo3maH8pp58XTjXqBP58l8rBOIE9cR7YxRPVQFvMMAR
	Ib5aE6lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCEA2-0000000BFac-3gnX;
	Tue, 06 May 2025 09:00:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCDf5-0000000B9uA-1KOH
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 08:28:24 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545L3LRh018071;
	Tue, 6 May 2025 08:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bZVfdf
	tTzfZqnJIQktyhvG19d0Vtpd/s79SmU+boEPo=; b=aZr92OdnfqTpjoIbshfDbe
	VLv5xtoi+2kdUG8yCck9QkiawWN3t4WjZPvLRffAfwj8DLHu2sCKtaL7LA9+UFrS
	IY+SSzTQATzTNKcXXfSKO66G1E9BrkMaJ7sdlJC5PHkEVRR6DoWWo424WsxBwKLf
	GRdh9jniXspQNDqWLCYyg6N8BzcK/xTHWd0Bpa/10ChS6IZQQkNv1dtePoFe8TeQ
	a1p1kk10eFDVKnB7Xxca57AmBxriDGRq3FugpY9MZ4IC/+qgid2urdds//TOwjJ0
	DUSH4xIeNdx905zZcTcZA5lQL1BOkJwPl0RJ7/1Wj6+pZcuwaq/gtfyaFcNNUUWg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f4wkj7bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 08:28:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5467pQtx001272;
	Tue, 6 May 2025 08:28:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftarmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 08:28:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5468S5cZ6947528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 08:28:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90ACB5803F;
	Tue,  6 May 2025 08:28:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D74758056;
	Tue,  6 May 2025 08:28:02 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 May 2025 08:28:02 +0000 (GMT)
Message-ID: <bf6ba108-1ef9-4722-8091-4bb0ad0582f8@linux.ibm.com>
Date: Tue, 6 May 2025 13:58:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250504175051.2208162-1-nilay@linux.ibm.com>
 <20250504175051.2208162-2-nilay@linux.ibm.com>
 <dd7330a2-6499-4af7-af3a-489ab86d2b5f@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <dd7330a2-6499-4af7-af3a-489ab86d2b5f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Up9jN/wB c=1 sm=1 tr=0 ts=6819c817 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VJ3oETf2gTVF74GEWb8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _6DS0Pd0tXNRF9L3wlW9yf5EBgAt5_JM
X-Proofpoint-GUID: _6DS0Pd0tXNRF9L3wlW9yf5EBgAt5_JM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA3NiBTYWx0ZWRfX3x5pk4CGA0/V UumQOVQ4zG8kE8AUGSWSpqAkrBNtVI9aqyCH+D8urgSOx4CwtgHypo4e1VSJ3lxOntX/6wUaPOy bFM7bRjoIICZbwsz2KLJGMQlCAHQwgIYWxP43iS64RXSp06QGAnmuGtDLD+0LiWuJeUv1XckjEK
 lsXIzUIqavJ+6JzT4CBCIiqAWKbZeUj/tial56ahm5RVJkcsY24fo9Dr6GXpF5MZerbY1OfB76F oQoStwxP7e+9C34F1WT9Nh4I1UewReftWJTxIkwuank2ChV2+XAjUUvyVkkD3QVUvj26QDkozbC eSNqfZxFOhNzId91h85yilOzIh0TDEhftUSkrI1iRSAN/Kjbycbslo4d4gyWrgX23v32E4JQ95r
 XirHGfgI6feUjTS8J3UgSnsUbB7wc24m+URQZTG78DCuAsKAaFsGJ7Yc9LYHI6PP64zD+zdP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060076
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_012823_361466_C5E33017 
X-CRM114-Status: GOOD (  30.75  )
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



On 5/5/25 12:09 PM, Hannes Reinecke wrote:
> On 5/4/25 19:50, Nilay Shroff wrote:
> 
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index eb6ea8acb3cc..0f6b01f10c70 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3560,7 +3560,7 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>>            */
>>           if (h->ns_id != nsid || !nvme_is_unique_nsid(ctrl, h))
>>               continue;
>> -        if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
>> +        if (nvme_tryget_ns_head(h))
>>               return h;
>>       }
>>   @@ -3688,6 +3688,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>>       ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>>       ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
>>       kref_init(&head->ref);
>> +    if (ctrl->ops->flags & NVME_F_FABRICS)
>> +        nvme_mpath_set_fabrics(head);
>>   
> 
> Please make this a separate patch.
Yes sure, will do it while I spin the next patchset.

> 
>>       if (head->ids.csi) {
>>           ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
>> @@ -3804,7 +3806,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>>           }
>>       } else {
>>           ret = -EINVAL;
>> -        if (!info->is_shared || !head->shared) {
>> +        if ((!info->is_shared || !head->shared) &&
>> +            !list_empty(&head->list)) {
>>               dev_err(ctrl->device,
>>                   "Duplicate unshared namespace %d\n",
>>                   info->nsid);
>> @@ -4008,7 +4011,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>       mutex_lock(&ns->ctrl->subsys->lock);
>>       list_del_rcu(&ns->siblings);
>>       if (list_empty(&ns->head->list)) {
>> -        list_del_init(&ns->head->entry);
>> +        if (!nvme_mpath_queue_if_no_path(ns->head))
>> +            list_del_init(&ns->head->entry);
>>           last_path = true;
>>       }
>>       mutex_unlock(&ns->ctrl->subsys->lock);
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 250f3da67cc9..f3f981c9f3ec 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -442,7 +442,24 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>>               break;
>>           }
>>       }
>> -    return false;
>> +
>> +    /*
>> +     * If "head->delayed_removal_secs" is configured (i.e., non-zero), do
>> +     * not immediately fail I/O. Instead, requeue the I/O for the configured
>> +     * duration, anticipating that if there's a transient link failure then
>> +     * it may recover within this time window. This parameter is exported to
>> +     * userspace via sysfs, and its default value is zero. It is internally
>> +     * mapped to NVME_NSHEAD_QUEUE_IF_NO_PATH. When delayed_removal_secs is
>> +     * non-zero, this flag is set to true. When zero, the flag is cleared.
>> +     *
>> +     * Note: This option is not exposed to the users for NVMeoF connections.
>> +     * In fabric-based setups, fabric link failure is managed through other
>> +     * parameters such as "reconnect_delay" and "max_reconnects" which is
>> +     * handled at respective fabric driver layer. Therefor, head->delayed_
>> +     * removal_secs" is intended exclusively for non-fabric (e.g., PCIe)
>> +     * multipath configurations.
>> +     */
>> +    return nvme_mpath_queue_if_no_path(head);
>>   }
>>     static void nvme_ns_head_submit_bio(struct bio *bio)
>> @@ -617,6 +634,40 @@ static void nvme_requeue_work(struct work_struct *work)
>>       }
>>   }
>>   +static void nvme_remove_head(struct nvme_ns_head *head)
>> +{
>> +    if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>> +        /*
>> +         * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
>> +         * to allow multipath to fail all I/O.
>> +         */
>> +        kblockd_schedule_work(&head->requeue_work);
>> +
>> +        nvme_cdev_del(&head->cdev, &head->cdev_device);
>> +        synchronize_srcu(&head->srcu);
>> +        del_gendisk(head->disk);
>> +        nvme_put_ns_head(head);
>> +    }
>> +}
>> +
>> +static void nvme_remove_head_work(struct work_struct *work)
>> +{
>> +    struct nvme_ns_head *head = container_of(to_delayed_work(work),
>> +            struct nvme_ns_head, remove_work);
>> +    bool shutdown = false;
>> +
> 
> Don't you need to check here if the 'QUEUE_IF_NO_PATH' bit is still
> cleared?

No, we don't need to do that, because the QUEUE_IF_NO_PATH flag is
tied to the head->delayed_removal_secs setting. 
Specifically, the QUEUE_IF_NO_PATH flag is set when head->delayed_
removal_secs is configured to a non-zero value. It is cleared only
when head->delayed_removal_secs is reset to zero.

For example, if the user sets delayed_removal_secs to a non-zero 
value for a head node, the QUEUE_IF_NO_PATH flag is set. Even if
all paths to a shared namespace are lost, the flag remains set 
until delayed_removal_secs is reset to zero.

Hence, instead of relying solely on this flag, here we check whether
head->list is empty after the delayed removal timeout has elapsed. 
If head->list is not empty, it indicates that a path to the namespace
has been recovered (e.g., the link failure was resolved in time). 
Therefore, we should not remove the head node.

In short in this function, checking whether head->list is empty
is sufficient to determine whether the head node should be removed
or retained.
> 
>> +    mutex_lock(&head->subsys->lock);
>> +    if (list_empty(&head->list)) {
>> +        list_del_init(&head->entry);
>> +        shutdown = true;
>> +    }
>> +    mutex_unlock(&head->subsys->lock);
>> +    if (shutdown)
>> +        nvme_remove_head(head);
>> +
>> +    module_put(THIS_MODULE);
>> +}
>> +
>>   int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>   {
>>       struct queue_limits lim;
>> @@ -626,6 +677,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>       spin_lock_init(&head->requeue_lock);
>>       INIT_WORK(&head->requeue_work, nvme_requeue_work);
>>       INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
>> +    INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
>> +    head->delayed_removal_secs = 0;
>>         /*
>>        * Add a multipath node if the subsystems supports multiple controllers.
>> @@ -659,6 +712,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>       set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
>>       sprintf(head->disk->disk_name, "nvme%dn%d",
>>               ctrl->subsys->instance, head->instance);
>> +    nvme_tryget_ns_head(head);
> 
> What is that doing here?
> Why do you tak an additional reference?

We take an additional reference to the head node here to ensure that
it isn't freed immediately when all paths to the shared namespace
are removed. The final reference to the head node is only released when:
- All paths to the namespace are lost, and
- No new path to the namespace has appeared even after the configured 
  delayed_removal_secs (if set) has elapsed.
This way it's ensured that the head node remains valid during the 
grace period, allowing recovery if a path becomes available again.

Thanks,
--Nilay

