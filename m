Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1E5CD4F59
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2024 06:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hyOPrM0dD98K1ZyHgCJnwqqUHnqmhZ+ogXqfOTrEqLo=; b=xLsYeWdiHeinnxSRJuFPpQv0yN
	speJIs3Q4xetvnMMdGRQnQ4B2Wfb6PYzJXqE/K6cu1cm0Gxb+rMyl0bg0BqQ5LAmjpo7xjjk2Qj4H
	V9UiA7WsZCvvzEblVo89tYOoErISreVxVzGYC0h7NooAT8vlXosn+GFfMdnm2hAdMsjRY1Y3tm40T
	0KVFfkMnNTJEDj5a+lfg7VQ1GO6ElnBsna+nl23oufC8eVuB5APgDCKnet2F7lnHTE9+6mlvro4Lh
	hFPUHE/spofDyIz3Rhrf6BZfUUIpiclEbK3xSJlGK8TfxRGKzgKfG7JdSa2111rOj38XpI/2J5Xla
	qIUj5RwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm6EW-00000007EZ9-1yMK;
	Thu, 05 Sep 2024 06:44:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm6De-00000007EDI-26ws
	for linux-nvme@lists.infradead.org;
	Thu, 05 Sep 2024 06:43:52 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484IkaR3007662;
	Thu, 5 Sep 2024 06:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=h
	yOPrM0dD98K1ZyHgCJnwqqUHnqmhZ+ogXqfOTrEqLo=; b=NFSzUDLDinu1YYF75
	D6H/2aBVGaz0YOPpEj8jSPbrlgVWpzPj914nbeO/VWBBNvGCT+qBBb1Cgc4tZRNJ
	9+1RebSaAMbmNznI1d/W1lcdTpjyOLy5U874uIuKT7D+i/p0Xt/rBkVTunaFOK5G
	QQHv0jo3B1Tz3pWbCcj5UEI0k9VssixiS9feyWDzWIOEJNQax8DPAs17LvjZBDiw
	UV+hZ5ZU0Ll1/lEDLGeNqA9XQnHN7YG+BToaRPODhAV2Vv39CYyfclriFQKbNif/
	4OlJLTGWNJPc2OrlabmglEyjQVl40MC9sPZxPCuG/U+Pb5fCdxqbmHwJ+Gzw9DIv
	T3FQw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9q7mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 06:43:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4853R7ku009141;
	Thu, 5 Sep 2024 06:43:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cg73u4c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 06:43:42 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4856hfiK48628368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Sep 2024 06:43:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB0895805B;
	Thu,  5 Sep 2024 06:43:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92FCE58059;
	Thu,  5 Sep 2024 06:43:39 +0000 (GMT)
Received: from [9.171.91.249] (unknown [9.171.91.249])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Sep 2024 06:43:39 +0000 (GMT)
Message-ID: <2aa19e4b-1050-4fc0-96b8-c93501bf2d3b@linux.ibm.com>
Date: Thu, 5 Sep 2024 12:13:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-multipath: fix I/O stall when remapping
 namespaces
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240903180345.35253-1-hare@kernel.org>
 <20240903180345.35253-3-hare@kernel.org>
 <1acc9b52-e3dc-4142-91d4-48eba61d4fd0@grimberg.me>
 <3654d3d6-7f5c-4e5b-926c-339a985ace1e@suse.de>
 <47002e19-0de1-4bfd-9549-57894741d0c4@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <47002e19-0de1-4bfd-9549-57894741d0c4@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AQ7ZsTlyon059iAQolio2tZ46mhrN8b7
X-Proofpoint-ORIG-GUID: AQ7ZsTlyon059iAQolio2tZ46mhrN8b7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_234350_674911_02F292F1 
X-CRM114-Status: GOOD (  34.85  )
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



On 9/4/24 14:29, Hannes Reinecke wrote:
> On 9/4/24 10:20, Hannes Reinecke wrote:
>> On 9/3/24 21:38, Sagi Grimberg wrote:
>>>
>>>
>>>
>>> On 03/09/2024 21:03, Hannes Reinecke wrote:
>>>> During repetitive namespace remapping operations (ie removing a namespace and
>>>> provision a different namespace with the same NSID) on the target the
>>>> namespace might have changed between the time the initial scan
>>>> was performed, and partition scan was invoked by device_add_disk()
>>>> in nvme_mpath_set_live(). We then end up with a stuck scanning process:
>>>>
>>>> [<0>] folio_wait_bit_common+0x12a/0x310
>>>> [<0>] filemap_read_folio+0x97/0xd0
>>>> [<0>] do_read_cache_folio+0x108/0x390
>>>> [<0>] read_part_sector+0x31/0xa0
>>>> [<0>] read_lba+0xc5/0x160
>>>> [<0>] efi_partition+0xd9/0x8f0
>>>> [<0>] bdev_disk_changed+0x23d/0x6d0
>>>> [<0>] blkdev_get_whole+0x78/0xc0
>>>> [<0>] bdev_open+0x2c6/0x3b0
>>>> [<0>] bdev_file_open_by_dev+0xcb/0x120
>>>> [<0>] disk_scan_partitions+0x5d/0x100
>>>> [<0>] device_add_disk+0x402/0x420
>>>> [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
>>>> [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
>>>> [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
>>>> [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
>>>> [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
>>>>
>>>> This happens when we have several paths, some of which are inaccessible,
>>>> and the active paths are removed first. Then nvme_find_path() will requeue
>>>> I/O in the ns_head (as paths are present), but the requeue list is never
>>>> triggered as all remaining paths are inactive.
>>>> This patch checks for NVME_NSHEAD_DISK_LIVE when selecting a path,
>>>> and requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared once
>>>> the last path has been removed to properly terminate pending I/O.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>>> ---
>>>>   drivers/nvme/host/multipath.c | 14 ++++++++++++--
>>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>>>> index c9d23b1b8efc..1b1deb0450ab 100644
>>>> --- a/drivers/nvme/host/multipath.c
>>>> +++ b/drivers/nvme/host/multipath.c
>>>> @@ -407,6 +407,9 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
>>>>   inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>>>>   {
>>>> +    if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>>>> +        return NULL;
>>>> +
>>>>       switch (READ_ONCE(head->subsys->iopolicy)) {
>>>>       case NVME_IOPOLICY_QD:
>>>>           return nvme_queue_depth_path(head);
>>>> @@ -421,6 +424,9 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>>>>   {
>>>>       struct nvme_ns *ns;
>>>> +    if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>>>> +        return NULL;
>>>> +
>>>>       list_for_each_entry_rcu(ns, &head->list, siblings) {
>>>>           if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
>>>>               continue;
>>>> @@ -967,11 +973,15 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>>>>   {
>>>>       if (!head->disk)
>>>>           return;
>>>> -    kblockd_schedule_work(&head->requeue_work);
>>>> -    if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>>>> +    if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>>>>           nvme_cdev_del(&head->cdev, &head->cdev_device);
>>>>           del_gendisk(head->disk);
>>>>       }
>>>> +    /*
>>>> +     * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
>>>> +     * to allow multipath to fail all I/O.
>>>> +     */
>>>> +    kblockd_schedule_work(&head->requeue_work);
>>>
>>> Not sure how this helps given that you don't wait for srcu to synchronize
>>> before you kick the requeue.
>>>
>> It certainly is helping in my testcase. But having a synchronize_srcu here is probably not a bad idea.
>>
>>>>   }
>>>>   void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>>>
>>> Why do you need to clear NVME_NSHEAD_DISK_LIVE ? In the last posting you mentioned that ns_remove is stuck on srcu_synchronize? Can you explain why nvme_find_path is able to find a path given that it is already cleared NVME_NS_READY ? oris it nvme_available_path that is missing a check? Maybe can do with checking NVME_NS_READY instead?
>>
>> Turned out that the reasoning in the previous revision wasn't quite correct; since then I have seen several test-run where the above stack
>> trace was the _only_ one in the system, so the stall in removing namespaces is more a side-effect. The ns_head was still visible
>> in sysfs while in that state, with exactly one path left:
>>
>> # ls /sys/block
>> nvme0c4n1  nvme0c4n3  nvme0n1  nvme0n3  nvme0c4n2  nvme0c4n5  nvme0n2 nvme0n5
>>
>> (whereas there had been 6 controllers with 6 namespaces).
>> So we fail to trigger a requeue to restart I/O on the stuck scanning
>> process; the actual path state really don't matter as never get this far.
>> This can happen when the partition scan triggered by device_add_disk() (from one controller) interleaves with nvme_ns_remove() from another controller. Both processes are running lockless wrt to ns_head at that
>> time, so if the partition scan issues I/O after the schedule_work
>> in nvme_mpath_shutdown_disk():
>>
>> void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>> {
>>      if (!head->disk)
>>          return;
>>      kblockd_schedule_work(&head->requeue_work);
>>      if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>>          nvme_cdev_del(&head->cdev, &head->cdev_device);
>>          del_gendisk(head->disk);
>>      }
>> }
>>
>> _and_ that last path happens to be an 'inaccessible' one, I/O will be requeued in the ns_head but never restarted, leaving to a hung process.
>> Note, that I/O might also be triggered by userspace (eg udev); the device node is still present at that time. And that's also what I see
>> in my test runs; occasionally I get additional stuck udev processes:
>> [<0>] __folio_lock+0x114/0x1f0
>> [<0>] truncate_inode_pages_range+0x3c0/0x3e0
>> [<0>] blkdev_flush_mapping+0x45/0xe0
>> [<0>] blkdev_put_whole+0x2e/0x40
>> [<0>] bdev_release+0x129/0x1b0
>> [<0>] blkdev_release+0xd/0x20
>> [<0>] __fput+0xf7/0x2d0
>> also waiting on I/O.
>>
>> You might be right checking for NS_READY might be sufficient, I'll be
>> checking. But we definitely need to requeue I/O after we called del_gendisk().
>>
> Turns out that we don't check NVME_NS_READY in all places; we would need this patch:
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index c9d23b1b8efc..d8a6f51896fd 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -424,6 +424,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>         list_for_each_entry_rcu(ns, &head->list, siblings) {
>                 if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
>                         continue;
> +               if (test_bit(NVME_NS_READY, &ns->flags))
> +                       continue;
>                 switch (nvme_ctrl_state(ns->ctrl)) {
>                 case NVME_CTRL_LIVE:
>                 case NVME_CTRL_RESETTING:
> 
> in addition to moving of kblockd_schedule.
> 
I think you may want to test here, 

if (!test_bit(NVME_NS_READY, &ns->flags))
        continue;

> So what do you prefer, checking NVME_NS_HEAD_LIVE or NVME_NS_READY?
> 
> Cheers,
> 
> Hannes

Thanks,
--Nilay

