Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF8C6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 10:20:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208BE61287
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 10:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208BE61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0F2TotrItLGc0+G8KK+u5N3g2DzAGbJcu6/VHktZNQk=; b=zxp0WAbHqKIbMO
	noOD+lVo6XLpBkCW7o1Gq4YBRexeoUcemxk+oOP5vP2h5Q1M1VkWGrPaIvYltBmFwHDw8kO8hNWNj
	X/NvM+tO0+jv8vE3SkVLWKkEFYorcMgBbmmoUaauDFqjZNxJeXQ2zCVi78b/XxDqQ8g3v6/m6RfRb
	0AagWnx0ybLiUQjT3ndx0m2wKhsKlTts9sO3L/8XPkxXg8wmm+HlwzZfDSyw0m94hF0u3tW3RH/QM
	8y8zE3AgLpzXjTV13k20CC1pbeTzPa0C8OgLoUQoPlFt41hHGCw+I6rV8f3iXLTbhSZEDq0ryPK7h
	Lzh0Rd49a7i02evoVBHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6VoA-001CAW-2Y; Thu, 22 Jul 2021 10:20:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Vo4-001C7h-Mu
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 10:19:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626949194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9C3/RBYaUolmyP3VeziFcKEg2Hn93S2rUxjIWk+nhkM=;
 b=TDAHrSW0ocBVyrePy1qh499x6ZJF5x8x4lk0UN7kyswrht9fbw4N6H3N8YR1t+koczpZlg
 5/SAFsfcZ6FcS9S4mz6Exwdl2mBFdlQNxvLYYptuEpn882PsN3mrr7Aejplxh0/juEBFlM
 VLailRgq8yS40ruT3q38gQdbgCUgB7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-R9J8JA5kMm6jeaJSqzAD7Q-1; Thu, 22 Jul 2021 06:19:53 -0400
X-MC-Unique: R9J8JA5kMm6jeaJSqzAD7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0865710150A0;
 Thu, 22 Jul 2021 10:19:51 +0000 (UTC)
Received: from T590 (ovpn-13-219.pek2.redhat.com [10.72.13.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8252060C5F;
 Thu, 22 Jul 2021 10:19:42 +0000 (UTC)
Date: Thu, 22 Jul 2021 18:19:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YPlGOOMSdm6Bcyy/@T590>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
 <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com>
 <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com>
 <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com>
 <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_031956_905388_4C1C5785 
X-CRM114-Status: GOOD (  29.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 22, 2021 at 11:05:00AM +0100, John Garry wrote:
> On 22/07/2021 08:58, Ming Lei wrote:
> > On Wed, Jul 21, 2021 at 12:07:22PM +0100, John Garry wrote:
> > > On 21/07/2021 10:59, Ming Lei wrote:
> > > > > I have now removed that from the tree, so please re-pull.
> > > > Now the kernel can be built successfully, but not see obvious improvement
> > > > on the reported issue:
> > > > 
> > > > [root@ampere-mtjade-04 ~]# uname -a
> > > > Linux ampere-mtjade-04.khw4.lab.eng.bos.redhat.com 5.14.0-rc2_smmu_fix+ #2 SMP Wed Jul 21 05:49:03 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux
> > > > 
> > > > [root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> > > > + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> > > > test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> > > > fio-3.27
> > > > Starting 1 process
> > > > Jobs: 1 (f=1): [r(1)][100.0%][r=1503MiB/s][r=385k IOPS][eta 00m:00s]
> > > > test: (groupid=0, jobs=1): err= 0: pid=3143: Wed Jul 21 05:58:14 2021
> > > >     read: IOPS=384k, BW=1501MiB/s (1573MB/s)(14.7GiB/10001msec)
> > > I am not sure what baseline you used previously, but you were getting 327K
> > > then, so at least this would be an improvement.
> > Looks the improvement isn't from your patches, please see the test result on
> > v5.14-rc2:
> > 
> > [root@ampere-mtjade-04 ~]# uname -a
> > Linux ampere-mtjade-04.khw4.lab.eng.bos.redhat.com 5.14.0-rc2_linus #3 SMP Thu Jul 22 03:41:24 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux
> > [root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 20 1 /dev/nvme1n1 4k
> > + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
> > test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> > fio-3.27
> > Starting 1 process
> > Jobs: 1 (f=1): [r(1)][100.0%][r=1489MiB/s][r=381k IOPS][eta 00m:00s]
> > test: (groupid=0, jobs=1): err= 0: pid=3099: Thu Jul 22 03:53:04 2021
> >    read: IOPS=381k, BW=1487MiB/s (1559MB/s)(29.0GiB/20001msec)
> 
> I'm a bit surprised at that.
> 
> Anyway, I don't see such an issue as you are seeing on my system. In
> general, running from different nodes doesn't make a huge difference. But
> note that the NVMe device is on NUMA node #2 on my 4-node system. I assume
> that the IOMMU is also located in that node.
> 
> sudo taskset -c 0 fio/fio --bs=4k --ioengine=io_uring --fixedbufs
> --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16
> --iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1
> --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
> 
>  read: IOPS=479k
> 
> ---
> sudo taskset -c 4 fio/fio --bs=4k --ioengine=io_uring --fixedbufs
> --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16
> --iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1
> --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
> 
>  read: IOPS=307k
> 
> ---
> sudo taskset -c 32 fio/fio --bs=4k --ioengine=io_uring --fixedbufs
> --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16
> --iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1
> --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
> 
> read: IOPS=566k
> 
> --
> sudo taskset -c 64 fio/fio --bs=4k --ioengine=io_uring --fixedbufs
> --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16
> --iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1
> --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
> 
> read: IOPS=488k
> 
> ---
> sudo taskset -c 96 fio/fio --bs=4k --ioengine=io_uring --fixedbufs
> --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16
> --iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1
> --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
> 
>  read: IOPS=508k
> 
> 
> If you check below, you can see that cpu4 services an NVMe irq. From
> checking htop, during the test that cpu is at 100% load, which I put the
> performance drop (vs cpu0) down to.

nvme.poll_queues is 2 in my test, and no irq is involved. But the irq mode
fio test is still as bad as io_uring.

> 
> Here's some system info:
> 
> HW queue irq affinities:
> PCI name is 81:00.0: nvme0n1
> -eirq 298, cpu list 67, effective list 67
> -eirq 299, cpu list 32-38, effective list 35
> -eirq 300, cpu list 39-45, effective list 39
> -eirq 301, cpu list 46-51, effective list 46
> -eirq 302, cpu list 52-57, effective list 52
> -eirq 303, cpu list 58-63, effective list 60
> -eirq 304, cpu list 64-69, effective list 68
> -eirq 305, cpu list 70-75, effective list 70
> -eirq 306, cpu list 76-80, effective list 76
> -eirq 307, cpu list 81-85, effective list 84
> -eirq 308, cpu list 86-90, effective list 86
> -eirq 309, cpu list 91-95, effective list 92
> -eirq 310, cpu list 96-101, effective list 100
> -eirq 311, cpu list 102-107, effective list 102
> -eirq 312, cpu list 108-112, effective list 108
> -eirq 313, cpu list 113-117, effective list 116
> -eirq 314, cpu list 118-122, effective list 118
> -eirq 315, cpu list 123-127, effective list 124
> -eirq 316, cpu list 0-5, effective list 4
> -eirq 317, cpu list 6-11, effective list 6
> -eirq 318, cpu list 12-16, effective list 12
> -eirq 319, cpu list 17-21, effective list 20
> -eirq 320, cpu list 22-26, effective list 22
> -eirq 321, cpu list 27-31, effective list 28
> 
> 
> john@ubuntu:~$ lscpu | grep NUMA
> NUMA node(s):  4
> NUMA node0 CPU(s):   0-31
> NUMA node1 CPU(s):   32-63
> NUMA node2 CPU(s):   64-95
> NUMA node3 CPU(s):   96-127
> 
> john@ubuntu:~$ lspci | grep -i non
> 81:00.0 Non-Volatile memory controller: Huawei Technologies Co., Ltd. Device
> 0123 (rev 45)
> 
> cat /sys/block/nvme0n1/device/device/numa_node
> 2

BTW, nvme driver doesn't apply the pci numa node, and I guess the
following patch is needed:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11779be42186..3c5e10e8b0c2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4366,7 +4366,11 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
+#ifdef CONFIG_NUMA
+	ctrl->numa_node = dev->numa_node;
+#else
 	ctrl->numa_node = NUMA_NO_NODE;
+#endif
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);

> 
> [   52.968495] nvme 0000:81:00.0: Adding to iommu group 5
> [   52.980484] nvme nvme0: pci function 0000:81:00.0
> [   52.999881] nvme nvme0: 23/0/0 default/read/poll queues

Looks you didn't enabling polling. In irq mode, it isn't strange
to observe IOPS difference when running fio on different CPUs.

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
