Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5CFD15D96
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nZD2seWEi+RVejF3BPoFok3lqe9ce20I13fr2IKGAOE=; b=rHGt9Gp5F3VoFtsRwjLzMDBgxU
	SBHZpuPDKSyz3aMenW3fDxrhk5casGQa7IIqyjLtEHmBaIitP+DrH9rvs10AHHm27uZv1Pb0AZC90
	9Zj6YUAKMVzENgqYOwYyjfXC+Yx7DJDB8svB5iGFd1XXv+yopt0uqi/pcDc8fBD+azbowrOYCoemb
	0uCQbJ86W2j2tiZ9g5451STQu7F/Eel/xwHoNMfVPCmrWx8Z5dxGWIH+OXrHTaQvI76/9dgyWwAQQ
	mxdY2G2nOYRflli2Zdsf0k3BN41bohobl34ulpVSyz/d7hqV2+1wz3JokMo+VisDb8BvnRZwFAbTT
	ONLTR7tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2sws-00000007Wbb-2myS;
	Mon, 21 Oct 2024 13:59:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2sbi-00000007RZo-2F2P
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 13:38:04 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KItY026993;
	Mon, 21 Oct 2024 13:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nZD2se
	WEi+RVejF3BPoFok3lqe9ce20I13fr2IKGAOE=; b=LjiNj9eC3/jMoUjuZ4jNqI
	F+M26jAIkGNoTJ7ABm3loi0QfEbdRWNMVMjuZj9BVMbIbbl0jmJbFnEdWkwn66cS
	G0eQkQeCYOE5pkOV/5MGBiLnh5kF2EE5RqKuNIe3+THC1E3cZVroYToNKqDkYnIU
	5kABB/TTU9ctNyNz5q6oGCdCGsPvnFfO0zfcoRBZoVw62M0WpkgT3649aW7FBPvw
	wdbXCoVcijczSe93RZrZP4gagFD0Sn+kZn4lbmi2J+iJcGteeaWE966wkIXDp/ZD
	X3IpYZ/UOonDMdXzJC5Bdt0QD+GqrE07pLCyV0guTZHga/6Xv7ulVN8mkbeQ3FBQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fch1b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 13:37:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49LCZCO5029153;
	Mon, 21 Oct 2024 13:37:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42crkjxf3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 13:37:53 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49LDbrOA12780200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 13:37:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 223135805F;
	Mon, 21 Oct 2024 13:37:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7BC158043;
	Mon, 21 Oct 2024 13:37:50 +0000 (GMT)
Received: from [9.171.30.180] (unknown [9.171.30.180])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Oct 2024 13:37:50 +0000 (GMT)
Message-ID: <adc0088e-13a2-4abf-a6fb-f2f0dc3e1d42@linux.ibm.com>
Date: Mon, 21 Oct 2024 19:07:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
        gjoyce@linux.ibm.com
References: <20240911062653.1060056-1-nilay@linux.ibm.com>
 <20240911062653.1060056-4-nilay@linux.ibm.com>
 <d9d0d36d-c599-4e41-94e0-2e0072d585f9@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d9d0d36d-c599-4e41-94e0-2e0072d585f9@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3lervYO3Dx2icskL-rjVog-2h12oVG9k
X-Proofpoint-GUID: 3lervYO3Dx2icskL-rjVog-2h12oVG9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_063802_861057_784D4FC5 
X-CRM114-Status: GOOD (  36.82  )
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



On 10/21/24 04:47, Sagi Grimberg wrote:
> 
> 
> 
> On 11/09/2024 9:26, Nilay Shroff wrote:
>> NVMe native multipath supports different IO policies for selecting I/O
>> path, however we don't have any visibility about which path is being
>> selected by multipath code for forwarding I/O.
>> This patch helps add that visibility by adding new sysfs attribute files
>> named "numa_nodes" and "queue_depth" under each namespace block device
>> path /sys/block/nvmeXcYnZ/. We also create a "multipath" sysfs directory
>> under head disk node and then from this directory add a link to each
>> namespace path device this head disk node points to.
>>
>> For instance, /sys/block/nvmeXnY/multipath/ would create a soft link to
>> each path the head disk node <nvmeXnY> points to:
>>
>> $ ls -1 /sys/block/nvme1n1/
>> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
>> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
>>
>> For round-robin I/O policy, we could easily infer from the above output
>> that I/O workload targeted to nvme3n1 would toggle across paths nvme1c1n1
>> and nvme1c3n1.
>>
>> For numa I/O policy, the "numa_nodes" attribute file shows the numa nodes
>> being preferred by the respective block device path. The numa nodes value
>> is comma delimited list of nodes or A-B range of nodes.
>>
>> For queue-depth I/O policy, the "queue_depth" attribute file shows the
>> number of active/in-flight I/O requests currently queued for each path.
> 
> Would it be possible to separate this to 3 patches, one for sysfs links, one
> for numa, and one for queue_depth?
Yeah it should be possible to split this patch into three different patches 
if you prefer so.

> 
> Also, are the sysfs files always exist? what do numa_nodes output in case
> the policy is round-robin? or what would queue_depth file produce?
> 
Assuming kernel is compiled with CONFIG_NVME_MULTIPATH, the sysfs files 
"numa_nodes" and "round_robin" would be always created once gendisk node 
(nvmeXCYnZ) for the per-path namespace device is added. 

In case io-policy is round-robin then numa_nodes file would show the numa
nodes preferred for the respective per-path namespace device in case the 
policy is set to numa. For instance, if we read the file
"/sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes" then it shows the numa 
nodes preferring the path nvme1c1n1 when I/O workload is targeted to nvme1n1.  

The queue_depth file would contain the value 0 if the io-policy is anything 
but queue-depth. The reason being queue_depth file emits the output of num of
active requests currently queued up in the nvme/fabric queue (i.e. ctrl->nr_active) 
however if the io-policy is not queue-depth then ->nr_active would typically remains 
zero.

BTW, we don't expect to read the numa_nodes file when the nvme subsystem 
io-policy is NOT numa. Similarly we don't expect user to review the 
queue_depth file when io-policy is NOT set to queue-depth. Isn't it? 

> 
> 
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/core.c      |  3 ++
>>   drivers/nvme/host/multipath.c | 71 +++++++++++++++++++++++++++++++++++
>>   drivers/nvme/host/nvme.h      | 20 ++++++++--
>>   drivers/nvme/host/sysfs.c     | 20 ++++++++++
>>   4 files changed, 110 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 983909a600ad..6be29fd64236 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3951,6 +3951,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>         if (!nvme_ns_head_multipath(ns->head))
>>           nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>> +
>> +    nvme_mpath_remove_sysfs_link(ns);
>> +
>>       del_gendisk(ns->disk);
>>         mutex_lock(&ns->ctrl->namespaces_lock);
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 518e22dd4f9b..7d9c36a7a261 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -654,6 +654,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>>           nvme_add_ns_head_cdev(head);
>>       }
>>   +    nvme_mpath_add_sysfs_link(ns);
>> +
>>       mutex_lock(&head->lock);
>>       if (nvme_path_is_optimized(ns)) {
>>           int node, srcu_idx;
>> @@ -922,6 +924,39 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
>>   }
>>   DEVICE_ATTR_RO(ana_state);
>>   +static ssize_t queue_depth_show(struct device *dev, struct device_attribute *attr,
>> +        char *buf)
>> +{
>> +    struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>> +
>> +    return sysfs_emit(buf, "%d\n", atomic_read(&ns->ctrl->nr_active));
>> +}
>> +DEVICE_ATTR_RO(queue_depth);
>> +
>> +static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
>> +        char *buf)
>> +{
>> +    int node, srcu_idx;
>> +    nodemask_t numa_nodes;
>> +    struct nvme_ns *current_ns;
>> +    struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>> +    struct nvme_ns_head *head = ns->head;
>> +
>> +    nodes_clear(numa_nodes);
>> +
>> +    srcu_idx = srcu_read_lock(&head->srcu);
>> +    for_each_node(node) {
>> +        current_ns = srcu_dereference(head->current_path[node],
>> +                &head->srcu);
>> +        if (ns == current_ns)
>> +            node_set(node, numa_nodes);
>> +    }
>> +    srcu_read_unlock(&head->srcu, srcu_idx);
>> +
>> +    return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&numa_nodes));
>> +}
>> +DEVICE_ATTR_RO(numa_nodes);
>> +
>>   static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>>           struct nvme_ana_group_desc *desc, void *data)
>>   {
>> @@ -934,6 +969,42 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>>       return -ENXIO; /* just break out of the loop */
>>   }
>>   +void nvme_mpath_add_sysfs_link(struct nvme_ns *ns)
>> +{
>> +    struct device *target;
>> +    struct kobject *kobj;
>> +    int rc;
>> +
>> +    if (test_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags))
>> +        return;
>> +
>> +    target = disk_to_dev(ns->disk);
>> +    kobj = &disk_to_dev(ns->head->disk)->kobj;
>> +    rc = sysfs_add_link_to_group(kobj, nvme_ns_mpath_attr_group.name,
>> +            &target->kobj, dev_name(target));
>> +    if (unlikely(rc)) {
>> +        dev_err(disk_to_dev(ns->head->disk),
>> +                "failed to create link to %s\n",
>> +                dev_name(target));
>> +    } else
>> +        set_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
> 
> This complication is not clear at all, not sure why this is needed, and it is
> not documented.
The nvme_mpath_add_sysfs_link function is invoked from nvme_mpath_set_live() when a 
new namespace is allocated and its ANA state is set to OPTIMIZED or NON-OPTIMIZED. 
The nvme_mpath_add_sysfs_link function simply creates the link to the target nvme 
path-device (nvmeXCYnZ) from head disk-node (nvmeXnY) device. If this looks complex 
then I would add commentary in the code in the next patch.

Thanks,
--Nilay

