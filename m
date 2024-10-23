Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA95CCF538A
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4a25TYqUpEylBMKYpD373LSNXtSThV1qJr0XXWKRGo=; b=4TSbJCZMiJSGWulrkz6YKBCbsd
	bhzcVMwALtgr/jx4TNXj0IbGVN0NPAW6KBhnQ1zPAGQazJ+pceErdT2sD22JrNS6W5T7YTEAyYXFN
	YuKtwiIIe2EBsooM4WedX6YWJqkCsnvz5z+tF9D9g2GVAI72hfpvtKLUaJCy1GKtR8UXywbCgZ5GD
	QF5oOg8ZIdPdLhQeGXSV1m3WV3MG4YrXHPg3t/j3hM5dg+0BTNuuf4fHs5VyEAW8ls3gb5zoytUoj
	3Qo9s9uQFjR6Gs55JTRUcNnn5lWv8pBgi0iFdbyEWrGxVMSPt0oO2q6VgPktBrGOaFMZPyTSLC+Rd
	jqeIc0jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bSb-0000000EYdt-2C2l;
	Wed, 23 Oct 2024 13:31:37 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bSX-0000000EYae-3aJ8
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 13:31:35 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0N27c002899;
	Wed, 23 Oct 2024 13:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y4a25T
	YqUpEylBMKYpD373LSNXtSThV1qJr0XXWKRGo=; b=WPn/OXN8VR0wiTMOVPdMbV
	YkVM2J0U6rFNvOd1KYcoQJT7c6gDwR71u1BtZlfciLsE94aUIIHjsXjX/QEfuxl3
	es0UgKpACrlQjMpQk+UvPK01jTz22vz2MBTCTmz9tNl4uVCE31ySBYsi/xiZosCH
	hIQRfqE72VE0EEG7pvTvh2vYvU10WMwcbBNT5vgAS5qxorogYs+jzSaAqbr/x3rc
	G/rb+oHvkxRyVE5AC6F/qKg/jgMrsO0qgO2KtdTGRmPBY2T+LALtECcZZuX5BW1x
	WhikBDETj4DnFb7bpkWn+Co1DbQC/CN21drrCDVK9VZjSbNLCASC+3w0PSzQ6QQQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafu6nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 13:31:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBhM0q001794;
	Wed, 23 Oct 2024 13:31:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9b166-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 13:31:19 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NDVJXU48627970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:31:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CE035805A;
	Wed, 23 Oct 2024 13:31:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FEFB58054;
	Wed, 23 Oct 2024 13:31:16 +0000 (GMT)
Received: from [9.171.35.98] (unknown [9.171.35.98])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 13:31:15 +0000 (GMT)
Message-ID: <a6bca823-646e-450b-8356-d9626339764d@linux.ibm.com>
Date: Wed, 23 Oct 2024 19:01:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
        gjoyce@linux.ibm.com, Hannes Reinecke <hare@suse.de>
References: <20240911062653.1060056-1-nilay@linux.ibm.com>
 <20240911062653.1060056-4-nilay@linux.ibm.com>
 <d9d0d36d-c599-4e41-94e0-2e0072d585f9@grimberg.me>
 <adc0088e-13a2-4abf-a6fb-f2f0dc3e1d42@linux.ibm.com>
 <97c8466d-ee4c-4009-9d5e-725436c963f1@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <97c8466d-ee4c-4009-9d5e-725436c963f1@grimberg.me>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZVncI-qBP-su5u-HB6nuES7jaINUYlIX
X-Proofpoint-ORIG-GUID: ZVncI-qBP-su5u-HB6nuES7jaINUYlIX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230079
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_063134_039799_1BDEDD8E 
X-CRM114-Status: GOOD (  33.33  )
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



On 10/23/24 15:28, Sagi Grimberg wrote:
>>> Also, are the sysfs files always exist? what do numa_nodes output in case
>>> the policy is round-robin? or what would queue_depth file produce?
>>>
>> Assuming kernel is compiled with CONFIG_NVME_MULTIPATH, the sysfs files
>> "numa_nodes" and "round_robin" would be always created once gendisk node
>> (nvmeXCYnZ) for the per-path namespace device is added.
>>
>> In case io-policy is round-robin then numa_nodes file would show the numa
>> nodes preferred for the respective per-path namespace device in case the
>> policy is set to numa. For instance, if we read the file
>> "/sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes" then it shows the numa
>> nodes preferring the path nvme1c1n1 when I/O workload is targeted to nvme1n1.
>>
>> The queue_depth file would contain the value 0 if the io-policy is anything
>> but queue-depth. The reason being queue_depth file emits the output of num of
>> active requests currently queued up in the nvme/fabric queue (i.e. ctrl->nr_active)
>> however if the io-policy is not queue-depth then ->nr_active would typically remains
>> zero.
>>
>> BTW, we don't expect to read the numa_nodes file when the nvme subsystem
>> io-policy is NOT numa. Similarly we don't expect user to review the
>> queue_depth file when io-policy is NOT set to queue-depth. Isn't it?
> 
> I'm asking what does it show in case it _is_ read. queue_depth and numa_nodes
> output seems to be a "lie" in case the policy is round-robin.
> 
Yes the output of queue_dpeth and numa_nodes is not useful when io-policy 
is round-robin. So do you suggest to avoid emitting any output when io-policy 
is round-robin and user reads numa_nodes or queue_depth file? 
Similarly, when io-policy is numa, we should refrain from emitting anything 
if user access queue_depth file and the same is the case when io-policy is 
queue-depth and user access the numa_nodes file.
>>
>>>
>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>> ---
>>>>    drivers/nvme/host/core.c      |  3 ++
>>>>    drivers/nvme/host/multipath.c | 71 +++++++++++++++++++++++++++++++++++
>>>>    drivers/nvme/host/nvme.h      | 20 ++++++++--
>>>>    drivers/nvme/host/sysfs.c     | 20 ++++++++++
>>>>    4 files changed, 110 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index 983909a600ad..6be29fd64236 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -3951,6 +3951,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>>          if (!nvme_ns_head_multipath(ns->head))
>>>>            nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>>>> +
>>>> +    nvme_mpath_remove_sysfs_link(ns);
>>>> +
>>>>        del_gendisk(ns->disk);
>>>>          mutex_lock(&ns->ctrl->namespaces_lock);
>>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>>>> index 518e22dd4f9b..7d9c36a7a261 100644
>>>> --- a/drivers/nvme/host/multipath.c
>>>> +++ b/drivers/nvme/host/multipath.c
>>>> @@ -654,6 +654,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>>>>            nvme_add_ns_head_cdev(head);
>>>>        }
>>>>    +    nvme_mpath_add_sysfs_link(ns);
>>>> +
>>>>        mutex_lock(&head->lock);
>>>>        if (nvme_path_is_optimized(ns)) {
>>>>            int node, srcu_idx;
>>>> @@ -922,6 +924,39 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
>>>>    }
>>>>    DEVICE_ATTR_RO(ana_state);
>>>>    +static ssize_t queue_depth_show(struct device *dev, struct device_attribute *attr,
>>>> +        char *buf)
>>>> +{
>>>> +    struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>>>> +
>>>> +    return sysfs_emit(buf, "%d\n", atomic_read(&ns->ctrl->nr_active));
>>>> +}
>>>> +DEVICE_ATTR_RO(queue_depth);
>>>> +
>>>> +static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
>>>> +        char *buf)
>>>> +{
>>>> +    int node, srcu_idx;
>>>> +    nodemask_t numa_nodes;
>>>> +    struct nvme_ns *current_ns;
>>>> +    struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>>>> +    struct nvme_ns_head *head = ns->head;
>>>> +
>>>> +    nodes_clear(numa_nodes);
>>>> +
>>>> +    srcu_idx = srcu_read_lock(&head->srcu);
>>>> +    for_each_node(node) {
>>>> +        current_ns = srcu_dereference(head->current_path[node],
>>>> +                &head->srcu);
>>>> +        if (ns == current_ns)
>>>> +            node_set(node, numa_nodes);
>>>> +    }
>>>> +    srcu_read_unlock(&head->srcu, srcu_idx);
>>>> +
>>>> +    return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&numa_nodes));
>>>> +}
>>>> +DEVICE_ATTR_RO(numa_nodes);
>>>> +
>>>>    static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>>>>            struct nvme_ana_group_desc *desc, void *data)
>>>>    {
>>>> @@ -934,6 +969,42 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>>>>        return -ENXIO; /* just break out of the loop */
>>>>    }
>>>>    +void nvme_mpath_add_sysfs_link(struct nvme_ns *ns)
>>>> +{
>>>> +    struct device *target;
>>>> +    struct kobject *kobj;
>>>> +    int rc;
>>>> +
>>>> +    if (test_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags))
>>>> +        return;
>>>> +
>>>> +    target = disk_to_dev(ns->disk);
>>>> +    kobj = &disk_to_dev(ns->head->disk)->kobj;
>>>> +    rc = sysfs_add_link_to_group(kobj, nvme_ns_mpath_attr_group.name,
>>>> +            &target->kobj, dev_name(target));
>>>> +    if (unlikely(rc)) {
>>>> +        dev_err(disk_to_dev(ns->head->disk),
>>>> +                "failed to create link to %s\n",
>>>> +                dev_name(target));
>>>> +    } else
>>>> +        set_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
>>> This complication is not clear at all, not sure why this is needed, and it is
>>> not documented.
>> The nvme_mpath_add_sysfs_link function is invoked from nvme_mpath_set_live() when a
>> new namespace is allocated and its ANA state is set to OPTIMIZED or NON-OPTIMIZED.
>> The nvme_mpath_add_sysfs_link function simply creates the link to the target nvme
>> path-device (nvmeXCYnZ) from head disk-node (nvmeXnY) device. If this looks complex
>> then I would add commentary in the code in the next patch.
> 
> Still not clear why we need a flag for this? The usage suggest that we may call add/remove sysfs link
> multiple times... What about inaccessible paths? or paths that transition to/from inaccessible? They
> will add/remove their corresponding sysfs links?
The NVME_NS_SYSFS_ATTR_LINK flag is useful to avoid creating link multiple times when 
ana state of an nvme path transition from optimized to non-optimized state or vice-versa.

When ana state of nvme path transitions to live (i.e. optimized or non-optimized), we call 
nvme_mpath_set_live() and then from this function we call nvme_mpath_add_sysfs_link(). 
Assuming the sysfs link for the nvme path already exists, if we attempt to recreate the link 
then sysfs_add_link_to_group() complains about this anomaly loudly. It warns about this anomaly
by printing stack dump. You may refer sysfs_warn_dup(). 

For inaccessible path, in the current implementation, we don't create sysfs link. 
However in one of the earlier discussion, Hannes recommended[1] to always create the link
to the path whose ana state could be inaccessible or any other state. So I am preparing 
for the next patch iteration where I will address this comment.

[1]: https://lore.kernel.org/all/3c92b9ae-1223-4787-90e3-955f82161269@suse.de/

Thanks,
--Nilay  

