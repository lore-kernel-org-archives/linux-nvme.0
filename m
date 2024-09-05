Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7707ACD4F4D
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2024 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b91SfZTso4iutLAByLr/8kU+9540fsABwnztjpx08is=; b=IG4sRivrRaP98/oJSoVDmltoDN
	5hK8XJCAPp6BuZmQLM6KEtEqullVrnn4l+4W+aHN/oYmc38zwE5txYge/LbcVgSInGkZyx6OPBNJH
	Ksz1UtoISXjsgqeTL13Yl/TDcXNRFxQRDzWR4zXAa+jcdHnbssENBSRihlcPgdU6Ae2HX7iD6XjJi
	w0sQzYtdLl9CpliTOq7PpTVu+UpHF2S+nJlO9VatXFfl0dUs+ZFtEOXtn//L7mM9AJbpr7r2ngyWB
	MF8yyc9hlVJZHb7GeHP4sgDZIkZI8Evj0JQw9hmt/r1fxcUKiXFY9be1iNihqp79OIP1ERlq7gOyv
	BMnhLWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm6dw-00000007Jt2-2Yjo;
	Thu, 05 Sep 2024 07:11:00 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm6Zf-00000007JDL-3QUD
	for linux-nvme@lists.infradead.org;
	Thu, 05 Sep 2024 07:06:37 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bbf138477so3192245e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2024 00:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725519993; x=1726124793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b91SfZTso4iutLAByLr/8kU+9540fsABwnztjpx08is=;
        b=PJGVbvpHOwbPABurk9pIenFa+lOq6GDMzAkrYl9GztzzPWJWjOXuGUZhQEtUaK5usk
         CU2cv4V8Kf22LYGb29l6t+xNuZexOLODJIIylzzft8ftEs9QdRGaIwzuZLlN43SWNs4C
         neDGXQoE9OFU/mkFSJE9RMctddIWpZhs2bhpmVXoviOX7xmQga26sH5rXzo4Y6gWw192
         MbarD2eHRpnFYArrVoxNBwrzAB08sISgC+l5nkpO7rrsjOeBqfcT4hlrKdUoESQbWmOK
         ritPWvYvl4EHcJB0fIVN3khsbry5otc2fh9yKUoZUhpMdzwKNuqTTmzflgsD1wmCnqcT
         B2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVNot2EZfZRksZzGQCQM6ZKiK6gORuWwGRESaDDfC/9RW4YxpTScKl0k+nNVwxfc2PvO8sgMUV8O13l@lists.infradead.org
X-Gm-Message-State: AOJu0YyeEFLddDhUpeUN2GwSmyygg8Ps3m/tGW9XWco1zcU5J3ZBDFZw
	hhKDRjNfc2BXEyZubKIDxyFGJhz2hIddSl1NIDnV6QtEN7UUHTOR
X-Google-Smtp-Source: AGHT+IEYYs/zH2d2QPBW4ISJtuFfhL3EfO3siad1xssVNcL13jiqw/bGPCZVQZJcUoS5OFbDYZj3Ew==
X-Received: by 2002:a05:600c:3b8a:b0:426:58ca:5a3 with SMTP id 5b1f17b1804b1-42c881031e2mr73859415e9.30.1725519991909;
        Thu, 05 Sep 2024 00:06:31 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3759637c766sm6721375f8f.57.2024.09.05.00.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 00:06:31 -0700 (PDT)
Message-ID: <a5d65cfa-46a1-4d11-9a27-c7db5dcab45a@grimberg.me>
Date: Thu, 5 Sep 2024 10:06:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-multipath: fix I/O stall when remapping
 namespaces
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240903180345.35253-1-hare@kernel.org>
 <20240903180345.35253-3-hare@kernel.org>
 <1acc9b52-e3dc-4142-91d4-48eba61d4fd0@grimberg.me>
 <3654d3d6-7f5c-4e5b-926c-339a985ace1e@suse.de>
 <47002e19-0de1-4bfd-9549-57894741d0c4@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <47002e19-0de1-4bfd-9549-57894741d0c4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_000635_888699_7B88CDD9 
X-CRM114-Status: GOOD (  32.47  )
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




On 04/09/2024 11:59, Hannes Reinecke wrote:
> On 9/4/24 10:20, Hannes Reinecke wrote:
>> On 9/3/24 21:38, Sagi Grimberg wrote:
>>>
>>>
>>>
>>> On 03/09/2024 21:03, Hannes Reinecke wrote:
>>>> During repetitive namespace remapping operations (ie removing a 
>>>> namespace and
>>>> provision a different namespace with the same NSID) on the target the
>>>> namespace might have changed between the time the initial scan
>>>> was performed, and partition scan was invoked by device_add_disk()
>>>> in nvme_mpath_set_live(). We then end up with a stuck scanning 
>>>> process:
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
>>>> This happens when we have several paths, some of which are 
>>>> inaccessible,
>>>> and the active paths are removed first. Then nvme_find_path() will 
>>>> requeue
>>>> I/O in the ns_head (as paths are present), but the requeue list is 
>>>> never
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
>>>> diff --git a/drivers/nvme/host/multipath.c 
>>>> b/drivers/nvme/host/multipath.c
>>>> index c9d23b1b8efc..1b1deb0450ab 100644
>>>> --- a/drivers/nvme/host/multipath.c
>>>> +++ b/drivers/nvme/host/multipath.c
>>>> @@ -407,6 +407,9 @@ static struct nvme_ns *nvme_numa_path(struct 
>>>> nvme_ns_head *head)
>>>>   inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>>>>   {
>>>> +    if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>>>> +        return NULL;
>>>> +
>>>>       switch (READ_ONCE(head->subsys->iopolicy)) {
>>>>       case NVME_IOPOLICY_QD:
>>>>           return nvme_queue_depth_path(head);
>>>> @@ -421,6 +424,9 @@ static bool nvme_available_path(struct 
>>>> nvme_ns_head *head)
>>>>   {
>>>>       struct nvme_ns *ns;
>>>> +    if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>>>> +        return NULL;
>>>> +
>>>>       list_for_each_entry_rcu(ns, &head->list, siblings) {
>>>>           if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
>>>>               continue;
>>>> @@ -967,11 +973,15 @@ void nvme_mpath_shutdown_disk(struct 
>>>> nvme_ns_head *head)
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
>>> Not sure how this helps given that you don't wait for srcu to 
>>> synchronize
>>> before you kick the requeue.
>>>
>> It certainly is helping in my testcase. But having a synchronize_srcu 
>> here is probably not a bad idea.
>>
>>>>   }
>>>>   void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>>>
>>> Why do you need to clear NVME_NSHEAD_DISK_LIVE ? In the last posting 
>>> you mentioned that ns_remove is stuck on srcu_synchronize? Can you 
>>> explain why nvme_find_path is able to find a path given that it is 
>>> already cleared NVME_NS_READY ? oris it nvme_available_path that is 
>>> missing a check? Maybe can do with checking NVME_NS_READY instead?
>>
>> Turned out that the reasoning in the previous revision wasn't quite 
>> correct; since then I have seen several test-run where the above stack
>> trace was the _only_ one in the system, so the stall in removing 
>> namespaces is more a side-effect. The ns_head was still visible
>> in sysfs while in that state, with exactly one path left:
>>
>> # ls /sys/block
>> nvme0c4n1  nvme0c4n3  nvme0n1  nvme0n3  nvme0c4n2  nvme0c4n5 nvme0n2 
>> nvme0n5
>>
>> (whereas there had been 6 controllers with 6 namespaces).
>> So we fail to trigger a requeue to restart I/O on the stuck scanning
>> process; the actual path state really don't matter as never get this 
>> far.
>> This can happen when the partition scan triggered by 
>> device_add_disk() (from one controller) interleaves with 
>> nvme_ns_remove() from another controller. Both processes are running 
>> lockless wrt to ns_head at that
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
>> _and_ that last path happens to be an 'inaccessible' one, I/O will be 
>> requeued in the ns_head but never restarted, leaving to a hung process.
>> Note, that I/O might also be triggered by userspace (eg udev); the 
>> device node is still present at that time. And that's also what I see
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
>> checking. But we definitely need to requeue I/O after we called 
>> del_gendisk().
>>
> Turns out that we don't check NVME_NS_READY in all places; we would 
> need this patch:
>
> diff --git a/drivers/nvme/host/multipath.c 
> b/drivers/nvme/host/multipath.c
> index c9d23b1b8efc..d8a6f51896fd 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -424,6 +424,8 @@ static bool nvme_available_path(struct 
> nvme_ns_head *head)
>         list_for_each_entry_rcu(ns, &head->list, siblings) {
>                 if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, 
> &ns->ctrl->flags))
>                         continue;
> +               if (test_bit(NVME_NS_READY, &ns->flags))
> +                       continue;
>                 switch (nvme_ctrl_state(ns->ctrl)) {
>                 case NVME_CTRL_LIVE:
>                 case NVME_CTRL_RESETTING:
>
> in addition to moving of kblockd_schedule.
>
> So what do you prefer, checking NVME_NS_HEAD_LIVE or NVME_NS_READY?

Well, NVME_NS_READY is cleared in nvme_ns_remove (which is fine) but also
in nvme_mpath_revalidate_paths() if the capacity changed, so theoretically,
if the last remaining path changed its capacity, it will make 
nvme_available_path()
fail, and in turn, mpath IO will fail and not added to the requeue_list, 
which would be
wrong. So I think that nvme_available_path should check 
NVME_NSHEAD_DISK_LIVE,
but nvme_find_path is fine in its current form.

