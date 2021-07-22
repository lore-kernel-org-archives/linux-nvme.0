Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B09CC6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 10:11:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4466261260
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 10:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4466261260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HhriOAPbfMcuGSXeFPP+RWVSeLBpShrJKH3uFhr269w=; b=SwaumukY6W1USAaExbkMhXGO30
	WCUisWiQ0G30fKhNdGU2PHz8/Ebjxsw/JsDsJCCRsRIUF2CMiPLNxFPN3h6j5lcAI4pHwadTzfXje
	oqXWEZrra7R3YluCApZB+ldqcJ0gLILmFKeZJpwBk+HyCL+q84ZKLi282VQxzAXFDgXtP3jAXbnun
	62LTBcAU0w/tz7z5XfIDuhqzZ6hd7qLqKjO/0Y4L+h4Tr/4j9h7zVXW1nbxmRR+GFszC/1+Y9B+cA
	2I9FO0YveddqpPLRaVhJBsDsv7e+8jhaeQOER6NQK5Yo5BLdCMnMCoZZkSl5wBwbjPMYl67rVoCEu
	ItkvjybA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Vfb-0018vX-OR; Thu, 22 Jul 2021 10:11:11 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6VZp-0016kZ-O5; Thu, 22 Jul 2021 10:05:16 +0000
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVnp53xVDz6H71B;
 Thu, 22 Jul 2021 17:53:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 22 Jul 2021 12:05:06 +0200
Received: from [10.47.26.161] (10.47.26.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 22 Jul
 2021 11:05:06 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com> <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com> <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
From: John Garry <john.garry@huawei.com>
Message-ID: <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com>
Date: Thu, 22 Jul 2021 11:05:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YPklDMng1hL3bQ+v@T590>
Content-Language: en-US
X-Originating-IP: [10.47.26.161]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_030514_154449_FA6DE3A5 
X-CRM114-Status: GOOD (  13.98  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 22/07/2021 08:58, Ming Lei wrote:
> On Wed, Jul 21, 2021 at 12:07:22PM +0100, John Garry wrote:
>> On 21/07/2021 10:59, Ming Lei wrote:
>>>> I have now removed that from the tree, so please re-pull.
>>> Now the kernel can be built successfully, but not see obvious improvement
>>> on the reported issue:
>>>
>>> [root@ampere-mtjade-04 ~]# uname -a
>>> Linux ampere-mtjade-04.khw4.lab.eng.bos.redhat.com 5.14.0-rc2_smmu_fix+ #2 SMP Wed Jul 21 05:49:03 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux
>>>
>>> [root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
>>> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
>>> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
>>> fio-3.27
>>> Starting 1 process
>>> Jobs: 1 (f=1): [r(1)][100.0%][r=1503MiB/s][r=385k IOPS][eta 00m:00s]
>>> test: (groupid=0, jobs=1): err= 0: pid=3143: Wed Jul 21 05:58:14 2021
>>>     read: IOPS=384k, BW=1501MiB/s (1573MB/s)(14.7GiB/10001msec)
>> I am not sure what baseline you used previously, but you were getting 327K
>> then, so at least this would be an improvement.
> Looks the improvement isn't from your patches, please see the test result on
> v5.14-rc2:
> 
> [root@ampere-mtjade-04 ~]# uname -a
> Linux ampere-mtjade-04.khw4.lab.eng.bos.redhat.com 5.14.0-rc2_linus #3 SMP Thu Jul 22 03:41:24 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux
> [root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 20 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> fio-3.27
> Starting 1 process
> Jobs: 1 (f=1): [r(1)][100.0%][r=1489MiB/s][r=381k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=3099: Thu Jul 22 03:53:04 2021
>    read: IOPS=381k, BW=1487MiB/s (1559MB/s)(29.0GiB/20001msec)

I'm a bit surprised at that.

Anyway, I don't see such an issue as you are seeing on my system. In 
general, running from different nodes doesn't make a huge difference. 
But note that the NVMe device is on NUMA node #2 on my 4-node system. I 
assume that the IOMMU is also located in that node.

sudo taskset -c 0 fio/fio --bs=4k --ioengine=io_uring --fixedbufs 
--registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 
--iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1 
--runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting

  read: IOPS=479k

---
sudo taskset -c 4 fio/fio --bs=4k --ioengine=io_uring --fixedbufs 
--registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 
--iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1 
--runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting

  read: IOPS=307k

---
sudo taskset -c 32 fio/fio --bs=4k --ioengine=io_uring --fixedbufs 
--registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 
--iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1 
--runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting

read: IOPS=566k

--
sudo taskset -c 64 fio/fio --bs=4k --ioengine=io_uring --fixedbufs 
--registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 
--iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1 
--runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting

read: IOPS=488k

---
sudo taskset -c 96 fio/fio --bs=4k --ioengine=io_uring --fixedbufs 
--registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 
--iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1 
--runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting

  read: IOPS=508k


If you check below, you can see that cpu4 services an NVMe irq. From 
checking htop, during the test that cpu is at 100% load, which I put the 
performance drop (vs cpu0) down to.

Here's some system info:

HW queue irq affinities:
PCI name is 81:00.0: nvme0n1
-eirq 298, cpu list 67, effective list 67
-eirq 299, cpu list 32-38, effective list 35
-eirq 300, cpu list 39-45, effective list 39
-eirq 301, cpu list 46-51, effective list 46
-eirq 302, cpu list 52-57, effective list 52
-eirq 303, cpu list 58-63, effective list 60
-eirq 304, cpu list 64-69, effective list 68
-eirq 305, cpu list 70-75, effective list 70
-eirq 306, cpu list 76-80, effective list 76
-eirq 307, cpu list 81-85, effective list 84
-eirq 308, cpu list 86-90, effective list 86
-eirq 309, cpu list 91-95, effective list 92
-eirq 310, cpu list 96-101, effective list 100
-eirq 311, cpu list 102-107, effective list 102
-eirq 312, cpu list 108-112, effective list 108
-eirq 313, cpu list 113-117, effective list 116
-eirq 314, cpu list 118-122, effective list 118
-eirq 315, cpu list 123-127, effective list 124
-eirq 316, cpu list 0-5, effective list 4
-eirq 317, cpu list 6-11, effective list 6
-eirq 318, cpu list 12-16, effective list 12
-eirq 319, cpu list 17-21, effective list 20
-eirq 320, cpu list 22-26, effective list 22
-eirq 321, cpu list 27-31, effective list 28


john@ubuntu:~$ lscpu | grep NUMA
NUMA node(s):  4
NUMA node0 CPU(s):   0-31
NUMA node1 CPU(s):   32-63
NUMA node2 CPU(s):   64-95
NUMA node3 CPU(s):   96-127

john@ubuntu:~$ lspci | grep -i non
81:00.0 Non-Volatile memory controller: Huawei Technologies Co., Ltd. 
Device 0123 (rev 45)

cat /sys/block/nvme0n1/device/device/numa_node
2

[   52.968495] nvme 0000:81:00.0: Adding to iommu group 5
[   52.980484] nvme nvme0: pci function 0000:81:00.0
[   52.999881] nvme nvme0: 23/0/0 default/read/poll queues
[   53.019821]  nvme0n1: p1

john@ubuntu:~$ uname -a
Linux ubuntu 5.14.0-rc2-dirty #297 SMP PREEMPT Thu Jul 22 09:23:33 BST 
2021 aarch64 aarch64 aarch64 GNU/Linux

Thanks,
John

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
