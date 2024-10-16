Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE362D20693
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 03:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oWxECMca74WLPsmqhLVotQu3G4fMeZsdvp9eijNM/gM=; b=dpb2B23TSOHdGgtzcu28CTUN0M
	IVDPDIWz8+GhkwZr7Gn8hERUr+L0N3FNmniSj4wxQIdwg1DeMb6rTqFwh2gyRXIi9DK1tuVVpKvpV
	6TWpM9zVVxUXfNSBobFaBqo/6rJtR+11ZCaNo2CDoorfIOIO4TFdGnUvmcEY0rPRQBjyyoeULzQa1
	4zzbj6VdKFgI57kaqP48APVnUeQ4L2aDLbQQ3f/GK2HyFhMexHQgiXwC6JL8JOiUzbKVaWnNJ8UXw
	oHjkh9/uezxoCglL4tCvQ14BVpd9xEikh6ExOg8hCSiiGACTvvArGxGrdOELaZpDBBaFspmSSYANh
	6dPwsrYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0urI-0000000AMvK-3TOJ;
	Wed, 16 Oct 2024 03:38:00 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0urF-0000000AMuo-46d6
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 03:37:59 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G2snJs005147;
	Wed, 16 Oct 2024 03:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oWxECM
	ca74WLPsmqhLVotQu3G4fMeZsdvp9eijNM/gM=; b=JdoOSiUaSd97u28Tx4UtDv
	HUNEwduRQGKTd4z3BLpyjJnKH7s3Pjw50fJYxZhuX8y+P6JDp9nDLXI2IP9U24zv
	l0QHUAr3y7nqEQcWVPSEFoMi+g+5GfAT8SYs5wUHLeNelkzYPD1S+FrD7lHqzfmu
	h5wCDkzBYG0AC/vGbw/P56BzzRwz8ebMp4cbE4XyUfQUn1tFJgF+EMcr8VrMigqj
	O0dMVsGzdZ25m78sRQ6iUq4gXI/yx6CjJccXxaqxjxkskqwBht3ocFH+6wib6tLW
	zI0ZJtyg2eXuwegrI0oVSPmVpGBr8YLuLJWk+qVtV+8b9btpFWN/RCOoghPeeD2Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42a54dg3te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 03:37:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FNWika005377;
	Wed, 16 Oct 2024 03:19:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj6tde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 03:19:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49G3JD0J22479584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 03:19:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C798658067;
	Wed, 16 Oct 2024 03:19:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32F1358056;
	Wed, 16 Oct 2024 03:19:10 +0000 (GMT)
Received: from [9.171.76.114] (unknown [9.171.76.114])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Oct 2024 03:19:09 +0000 (GMT)
Message-ID: <2476d00b-35d3-4516-b76c-9b76a499e4fc@linux.ibm.com>
Date: Wed, 16 Oct 2024 08:49:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
From: Nilay Shroff <nilay@linux.ibm.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, gjoyce@linux.ibm.com
References: <20240911062653.1060056-1-nilay@linux.ibm.com>
 <20240911062653.1060056-4-nilay@linux.ibm.com>
 <5050777a-2812-4fcf-bed9-00f0cb5706fc@suse.de>
 <93af0dc5-c988-423c-9788-e93ca8703fd5@linux.ibm.com>
 <0f4528f0-8ef3-449f-bb15-47878d93a002@suse.de>
 <48bf8a1d-3a47-4c94-8cd0-7d8c4ea5d3ab@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <48bf8a1d-3a47-4c94-8cd0-7d8c4ea5d3ab@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 93hur8SKxQNf_xoHnEc3z70IaNtAUyX_
X-Proofpoint-ORIG-GUID: 93hur8SKxQNf_xoHnEc3z70IaNtAUyX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_203758_163274_3E67DB46 
X-CRM114-Status: GOOD (  27.99  )
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

Hi Hannes,

On 10/7/24 21:03, Nilay Shroff wrote:
> 
> 
> On 10/7/24 19:34, Hannes Reinecke wrote:
>> On 10/7/24 15:47, Nilay Shroff wrote:
>>>
>>>
>>> On 10/7/24 15:44, Hannes Reinecke wrote:
>>>> On 9/11/24 08:26, Nilay Shroff wrote:
>>>>> NVMe native multipath supports different IO policies for selecting I/O
>>>>> path, however we don't have any visibility about which path is being
>>>>> selected by multipath code for forwarding I/O.
>>>>> This patch helps add that visibility by adding new sysfs attribute files
>>>>> named "numa_nodes" and "queue_depth" under each namespace block device
>>>>> path /sys/block/nvmeXcYnZ/. We also create a "multipath" sysfs directory
>>>>> under head disk node and then from this directory add a link to each
>>>>> namespace path device this head disk node points to.
>>>>>
>>>>> For instance, /sys/block/nvmeXnY/multipath/ would create a soft link to
>>>>> each path the head disk node <nvmeXnY> points to:
>>>>>
>>>>> $ ls -1 /sys/block/nvme1n1/
>>>>> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
>>>>> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
>>>>>
>>>>> For round-robin I/O policy, we could easily infer from the above output
>>>>> that I/O workload targeted to nvme3n1 would toggle across paths nvme1c1n1
>>>>> and nvme1c3n1.
>>>>>
>>>>> For numa I/O policy, the "numa_nodes" attribute file shows the numa nodes
>>>>> being preferred by the respective block device path. The numa nodes value
>>>>> is comma delimited list of nodes or A-B range of nodes.
>>>>>
>>>>> For queue-depth I/O policy, the "queue_depth" attribute file shows the
>>>>> number of active/in-flight I/O requests currently queued for each path.
>>>>>
>>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>>> ---
>>>>>    drivers/nvme/host/core.c      |  3 ++
>>>>>    drivers/nvme/host/multipath.c | 71 +++++++++++++++++++++++++++++++++++
>>>>>    drivers/nvme/host/nvme.h      | 20 ++++++++--
>>>>>    drivers/nvme/host/sysfs.c     | 20 ++++++++++
>>>>>    4 files changed, 110 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index 983909a600ad..6be29fd64236 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -3951,6 +3951,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>>>          if (!nvme_ns_head_multipath(ns->head))
>>>>>            nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>>>>> +
>>>>> +    nvme_mpath_remove_sysfs_link(ns);
>>>>> +
>>>>>        del_gendisk(ns->disk);
>>>>>          mutex_lock(&ns->ctrl->namespaces_lock);
>>>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>>>>> index 518e22dd4f9b..7d9c36a7a261 100644
>>>>> --- a/drivers/nvme/host/multipath.c
>>>>> +++ b/drivers/nvme/host/multipath.c
>>>>> @@ -654,6 +654,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>>>>>            nvme_add_ns_head_cdev(head);
>>>>>        }
>>>>>    +    nvme_mpath_add_sysfs_link(ns);
>>>>> +
>>>>>        mutex_lock(&head->lock);
>>>>>        if (nvme_path_is_optimized(ns)) {
>>>>>            int node, srcu_idx;
>>>> Nearly there.
>>> Thank you for your review comments!
>>>
>>>>
>>>> You can only call 'nvme_mpath_add_sysfs_link()' if the gendisk on the head had been created.
>>>>
>>>> And there is one branch in nvme_mpath_add_disk():
>>>>
>>>>                  if (desc.state) {
>>>>                          /* found the group desc: update */
>>>>                          nvme_update_ns_ana_state(&desc, ns);
>>>>
>>>> which does not go via nvme_mpath_set_live(), yet a device link would need to be create here, too.
>>>> But you can't call nvme_mpath_add_sysfs_link() from nvme_mpath_add_disk(), as the actual gendisk
>>>> might only be created later on during ANA log parsing.>>
>>>> It is a tangle, and I haven't found a good way out of this.
>>>> But I am _very much_ in favour of having these links, so please
>>>> update your patch.
>>>> In case disk supports ANA group then yes it would go through nvme_mpath_add_disk()->nvme_update_ns_ana_state();
>>>> and later nvme_update_ns_ana_state() would also fall through function nvme_mpath_set_live where we call
>>>> nvme_mpath_add_sysfs_link().
>>>
>>> So I think that in any case while multipath namespace is being created it has to go through
>>> nvme_mpath_set_live function. And as we see in nvme_mpath_set_live function, we only create
>>> sysfs link after the gendisk on the head is created. Do you agree with this? Or please let
>>> me know if you have any further question.
>>>
>> But it doesn't:
>>
>>         if (nvme_state_is_live(ns->ana_state) &&
>>             nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE)
>>                 nvme_mpath_set_live(ns);
>>
>> so if a namespace is being created for which nvme_state_is_live() returns 'false' nvme_mpath_set_live() is not called, and no links are being created.
>> This can happen eg. if the first namespace to be encountered is in any other state than 'optimized' or 'non-optimized'.
>>
> 
> OK I got what you're suggesting here. So in this particular case when ANA state of a shared namespace 
> is neither "optimized" nor "non-optimized", we would have gendisk for shared namepspace (i.e. 
> nvmeXcYnZ) created but we don't have yet gendisk for corresponding head node (i.e. nvmeXnY) created. 
> So without the gendisk for head node created, how could we create a link from it to the namespace node? 
> 
> The link from gendisk head node would be eventually created when the ANA state of the namespace transition 
> to "optimized" or "non-optimized" state. I think, it's not anyways possible to have multipathing function 
> enabled until the gendisk for the head node created, isn't it? So I don't yet understand why do we really 
> need device link created if we don't have gendisk for head not ready? Am I missing anything here?
> 
>> Cheers,
>>
>> Hannes
>
A gentle ping about this thread. Does change look okay or you have further comments?
Am I missing something here? If so, can you please help me with it?

Thanks,
--Nilay  

 

