Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D117C07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 10:27:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36D361248
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 10:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36D361248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PKuGO8KQXmaEfB59TsP0EmRqc6PLqPXmqR+tjwIo+nU=; b=SDNB6cveCIbmZ7QbADKrItUwc5
	/emGVfttjm3Gik97XnLHEfs18BULJ1NM0mvDURZvSVRHdRiQQs/BLegOp/bhzIIIKENR65PjD6cKy
	I06OkcNwprX2pmUjlBg5lS/6BnVhYQiiYxSUvCE9sPVRnVyPsYhsQKuw7Iso5ipmm5U0xk13uWHci
	YfbYzgrJNV6kLwfFxkYe4/5TPfcPscJ1SaBEYyCAjc51DjGKB1YM6yB7Sh3tCC9BJh5s8Llz/nlrb
	DQBsgp1sWAyaNo3+5DYIgerYGEKM5eRkaY2M6AxvJOZl0uxlOgoDGT6q6exm8Fb1y8DnzUK7G7VDb
	S41OBXVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1njE-001Vc7-GN; Fri, 09 Jul 2021 10:27:28 +0000
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1nip-001VSN-PJ; Fri, 09 Jul 2021 10:27:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53F5ED1;
 Fri,  9 Jul 2021 03:26:59 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B37B33F5A1;
 Fri,  9 Jul 2021 03:26:58 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
References: <YOgK8fdv7dOQtkET@T590>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
Date: Fri, 9 Jul 2021 11:26:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOgK8fdv7dOQtkET@T590>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_032703_955427_618588F3 
X-CRM114-Status: GOOD (  15.69  )
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

On 2021-07-09 09:38, Ming Lei wrote:
> Hello,
> 
> I observed that NVMe performance is very bad when running fio on one
> CPU(aarch64) in remote numa node compared with the nvme pci numa node.
> 
> Please see the test result[1] 327K vs. 34.9K.
> 
> Latency trace shows that one big difference is in iommu_dma_unmap_sg(),
> 1111 nsecs vs 25437 nsecs.

Are you able to dig down further into that? iommu_dma_unmap_sg() itself 
doesn't do anything particularly special, so whatever makes a difference 
is probably happening at a lower level, and I suspect there's probably 
an SMMU involved. If for instance it turns out to go all the way down to 
__arm_smmu_cmdq_poll_until_consumed() because polling MMIO from the 
wrong node is slow, there's unlikely to be much you can do about that 
other than the global "go faster" knobs (iommu.strict and 
iommu.passthrough) with their associated compromises.

Robin.

> [1] fio test & results
> 
> 1) fio test result:
> 
> - run fio on local CPU
> taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> 
> IOPS: 327K
> avg latency of iommu_dma_unmap_sg(): 1111 nsecs
> 
> 
> - run fio on remote CPU
> taskset -c 80 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> 
> IOPS: 34.9K
> avg latency of iommu_dma_unmap_sg(): 25437 nsecs
> 
> 2) system info
> [root@ampere-mtjade-04 ~]# lscpu | grep NUMA
> NUMA node(s):                    2
> NUMA node0 CPU(s):               0-79
> NUMA node1 CPU(s):               80-159
> 
> lspci | grep NVMe
> 0003:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> 
> [root@ampere-mtjade-04 ~]# cat /sys/block/nvme1n1/device/device/numa_node
> 0
> 
> 
> 
> Thanks,
> Ming
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
