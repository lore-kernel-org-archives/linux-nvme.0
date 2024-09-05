Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23190CD4F4D
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2024 06:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=47/IyZ1DUIC3Ev0IQudXIsfqNtR3Da9ZMRwX7DcxMfI=; b=zQHIlsH9l1XfZd37SDNXStURzP
	pyLe8+cpvlCvkMNq+8kSqiexLIxDLWI7Oaet/Z0dsj/BFMPKJHTY0/u7W47D6+n1f0On7wMTwRD5v
	4XUdomyDAkkUVBZ24xoAxkCYXxtm6yuMkufMo3YFRah1PJ8xGYB0iKuy/x0DDLsO+0UrlgDNucGnL
	DVZcLxHDvaZslVcji/fyEeEqAsciwaNT9SPSOIE2wGl3kR/lCR/s4ayMfK0zMk4l7ueiGdblZWxV3
	6Ctj0lc9H1RoRci+fRgX9k7cqH1S9bmCwq6ZXwpZz40o/K7xx7ZbxnaknYM9hGZ4q7fo7JnN/BcrR
	N7hVpTbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm6Cx-00000007DvM-19uI;
	Thu, 05 Sep 2024 06:43:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm6Bq-00000007DTE-1Val
	for linux-nvme@lists.infradead.org;
	Thu, 05 Sep 2024 06:42:00 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4851l4PQ020383;
	Thu, 5 Sep 2024 06:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=4
	7/IyZ1DUIC3Ev0IQudXIsfqNtR3Da9ZMRwX7DcxMfI=; b=knJf+NbEynnDvRCWz
	wVx/uFf3nakI9ET8pwY7oM8mRcTS5dAdVLaivELNIaAimqsgzanceA783ZB6/IzF
	2DPUUay30wdCqXzpvbXjB8+hoSxKGYjdiQ+f8YJ47/4Xr/9NafWou9TejR/XrCuR
	9Sz7+9piPaPQKBjg7d9fUVNjexnbKacNARpfq1lxEKiH9j9T9NZnSEEQw0krQWXW
	6KOx2i60WAyGwy7uwaEMcuOlEpo1Gksk6ts+7tT9i57McEC3Nszyp0GAqs7VkrOI
	ImeSjp6r49xQCC/MlZdv4qxz6EB5ABQEG9RPB1nRyxEdVh1fomfcLCqbz1EAyIIx
	7Gxwg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bttyq4k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 06:41:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4855T2Cd000438;
	Thu, 5 Sep 2024 06:41:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cdguupc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 06:41:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4856feZa9175654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Sep 2024 06:41:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A33058058;
	Thu,  5 Sep 2024 06:41:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 832CF58059;
	Thu,  5 Sep 2024 06:41:37 +0000 (GMT)
Received: from [9.171.91.249] (unknown [9.171.91.249])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Sep 2024 06:41:37 +0000 (GMT)
Message-ID: <f697fda4-2aa0-4423-b588-8dad7968d7c4@linux.ibm.com>
Date: Thu, 5 Sep 2024 12:11:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-multipath: fix I/O stall when remapping
 namespaces
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20240903180345.35253-1-hare@kernel.org>
 <20240903180345.35253-3-hare@kernel.org>
 <d3762e8e-dcae-46fd-b222-92b552d3449f@linux.ibm.com>
 <edefb61b-8d4d-40e1-9d07-d8ba1c8bed07@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <edefb61b-8d4d-40e1-9d07-d8ba1c8bed07@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F7djYp4tTt2wxeEjREYQbtEJAlO2HrF8
X-Proofpoint-ORIG-GUID: F7djYp4tTt2wxeEjREYQbtEJAlO2HrF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=974
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409050046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_234158_770967_2889283E 
X-CRM114-Status: GOOD (  22.17  )
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



On 9/4/24 21:25, Hannes Reinecke wrote:
> On 9/4/24 16:52, Nilay Shroff wrote:
>>
>>
>> On 9/3/24 23:33, Hannes Reinecke wrote:
>>> During repetitive namespace remapping operations (ie removing a namespace and
>>> provision a different namespace with the same NSID) on the target the
>>> namespace might have changed between the time the initial scan
>>> was performed, and partition scan was invoked by device_add_disk()
>>> in nvme_mpath_set_live(). We then end up with a stuck scanning process:
>>>
>>> [<0>] folio_wait_bit_common+0x12a/0x310
>>> [<0>] filemap_read_folio+0x97/0xd0
>>> [<0>] do_read_cache_folio+0x108/0x390
>>> [<0>] read_part_sector+0x31/0xa0
>>> [<0>] read_lba+0xc5/0x160
>>> [<0>] efi_partition+0xd9/0x8f0
>>> [<0>] bdev_disk_changed+0x23d/0x6d0
>>> [<0>] blkdev_get_whole+0x78/0xc0
>>> [<0>] bdev_open+0x2c6/0x3b0
>>> [<0>] bdev_file_open_by_dev+0xcb/0x120
>>> [<0>] disk_scan_partitions+0x5d/0x100
>>> [<0>] device_add_disk+0x402/0x420
>>> [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
>>> [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
>>> [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
>>> [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
>>> [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
>>>
>>> This happens when we have several paths, some of which are inaccessible,
>>> and the active paths are removed first. Then nvme_find_path() will requeue
>>> I/O in the ns_head (as paths are present), but the requeue list is never
>>> triggered as all remaining paths are inactive.
>>> This patch checks for NVME_NSHEAD_DISK_LIVE when selecting a path,
>>> and requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared once
>>> the last path has been removed to properly terminate pending I/O.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/host/multipath.c | 14 ++++++++++++--
>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>>> index c9d23b1b8efc..1b1deb0450ab 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -407,6 +407,9 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
>>>     inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>>>   {
>>> +    if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>>> +        return NULL;
>>> +
>>>       switch (READ_ONCE(head->subsys->iopolicy)) {
>>>       case NVME_IOPOLICY_QD:
>>>           return nvme_queue_depth_path(head);
>>> @@ -421,6 +424,9 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>>>   {
>>>       struct nvme_ns *ns;
>>>   +    if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>>> +        return NULL;
>>> +
>>>       list_for_each_entry_rcu(ns, &head->list, siblings) {
>>>           if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
>>>               continue;
>>> @@ -967,11 +973,15 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>>>   {
>>>       if (!head->disk)
>>>           return;
>>> -    kblockd_schedule_work(&head->requeue_work);
>>> -    if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>>> +    if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>>>           nvme_cdev_del(&head->cdev, &head->cdev_device);
>>>           del_gendisk(head->disk);
>>>       }
>>> +    /*
>>> +     * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
>>> +     * to allow multipath to fail all I/O.
>>> +     */
>>> +    kblockd_schedule_work(&head->requeue_work);
>>>   }
>> Not sure, in your case, whether nvme_mpath_remove_disk() is called or not?
>> The nvme_mpath_remove_disk() shall trigger the ns_head reqiest list.
>>
> It would, but we're never get this far as the reference to ns_head it held by the above stack trace (and nvme_mpath_remove_disk()) is called
> when the last reference to ns_head drops.
OK, I see. In that case, I believe checking NVME_NS_READY in nvme_avalibale_path() should 
be a  good idea. 
> 
> Cheers,
> 
> Hannes

Thanks,
--Nilay

