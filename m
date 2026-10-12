Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD57CA9ED0
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 08:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZQ5mv5OnhlUrqBSbx5D/SdklIILQ6FyBNmt0B1I402U=; b=UR3ooj9te2c4yQAzUiPng7ggj4
	awUFAu2uBnDtpfqD4/qLRAGZUi1No/1DTLVEi4eMM0smxWkpfcLaAyKKzvRyj/+c3DTay1ADs0sZE
	vMNU/NDIPPAN0EUED1Z7sMYGC/6ZqqVr1aE1JfCs0Tol6R+Ge3OdqesZB7mTRE8TA6yfYYlqhf1wJ
	Xs63HOx8C9pjBccrn/pfiotSuzgHHTUAB4yFBBF7zFXqgpOMG2k8xylCBiVaZeHyU3KaVPyYnFWrV
	mfz/XoQVMc4v3aXDU/wtWTA9XmXMPDy1796oCAAudMkP2qsvbbCHBhzZ4JIBsRxIqLiEIv7G43bsl
	Tvgx8oPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGBbu-00000009xr2-21FX;
	Mon, 12 Oct 2026 08:42:18 +0000
Received: from out-27.mta0.migadu.com ([2001:41d0:1004:224b::1b] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGBbm-00000009xmN-2vrL
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 08:42:12 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=o2e972utFFQk0BpQcOPt5dGwhiilIlCaD4fH59gbqmg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791794526; v=1; x=1792399326;
 b=CIs9CNJGQUGiqAI2ZqXcFp8GQCPZ14aJt/EoAX5tXeuGWVTkftOkULl+0xKe7rQSNXNkBrXK
 bMO5IB857jP5OZTX8m6H4Sk4YA/bW8a4a+0Kp4R9dZRxpl/FPFfYHLJ/Ehfjue76fo5BmPhNczF
 PFSlp2ouwbjyf3+1xxkr8xW4=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id a325368366ef22a3;
	Mon, 12 Oct 2026 08:42:06 +0000
X-Mizu-Trace-ID: a325368366ef22a3
X-Migadu-Flow: FLOW_OUT
Message-ID: <2007f03b-2c76-4c36-a0bd-0ce99d1a01a2@linux.dev>
Date: Mon, 12 Oct 2026 09:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
To: Adrian Huang12 <ahuang12@lenovo.com>, Christoph Hellwig <hch@lst.de>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jiwei JW10 Sun <sunjw10@lenovo.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20261006120248.147654-1-hch@lst.de>
 <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
 <20261008123724.GA22096@lst.de>
 <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_014210_946207_673C4A8C 
X-CRM114-Status: GOOD (  19.59  )
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

On 10/9/26 10:11, Adrian Huang12 wrote:
>> -----Original Message-----
>> From: Christoph Hellwig <hch@lst.de>
>> Sent: Thursday, October 8, 2026 8:37 PM
>> To: John Garry <john.garry@linux.dev>
>> Cc: Christoph Hellwig <hch@lst.de>; kbusch@kernel.org; Adrian Huang12
>> <ahuang12@lenovo.com>; sagi@grimberg.me; linux-nvme@lists.infradead.org;
>> Jiwei JW10 Sun <sunjw10@lenovo.com>; iommu@lists.linux.dev
>> Subject: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
>> based on DMA optimized limitation"
>>
>> On Thu, Oct 08, 2026 at 08:36:54AM +0100, John Garry wrote:
>>> On 10/6/26 13:02, Christoph Hellwig wrote:
>>>> This turns down to cause up to 15% performance regressions on
>>>> standard large transfer workloads.  Revert it and hope the IOVA
>>>> allocator can eventually be fixed to remove the need for the original
>> workaround.
>>>>
>>>> This reverts commit 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd.
>>>>
>>>
>>> What was the block size and conditions for the original issue? The
>>> commit just mentions that mdts=10 and we get a 4096KB max HW sectors.
>>
>> Good question.  The original submitter and reporter are on Cc.
> 
> 1. The block size depends on the configuration of the fio parameter 'bs'. See below for details.
> 2. Conditions for the original issue: The issue is triggered if the IO size > 128KB.
> 
> [Detail]
> 1. A NVME with mdts=10 (maximum data transfer size = 4096 KB)
>    1.1 fio with bs=128k or below => Passed
>    1.2 fio with bs > 128k => Failed


That block size limit is an important detail missing from 
3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd commit message.

And now we seem to have a conflict, as Christoph wants block size > IOVA 
rcache limit but you find it may cause this soft lockup.

> 2. Another NVME with mdts=5 (maximum data transfer size = 128KB)
>    2.1 The issue does not reproduce regardless of the 'bs' configuration
> 3. The condition '128 KB' is identified because the IOMMU scalable IOVA mechanism supports a maximum transfer size of 128 KB.
> 4. IOMMU pass-through mode does not trigger the issue with the 'mdts=10' nvme disk.
> 5. The issue only appears with high-core-count servers
>    5.1 Reproduced servers: 448-core server and 384-core server
>    5.2 Non-reproduced server: 128-core server

How long does it take for the lockup to trigger? Pretty quickly, I guess.

Does changing the number of CPUs affect throughput (before the lockup)? 
Are you using just a single disk?

> 
> BTW, with this reverted patch, I'm setting up the test environment to check whether the issue does not appear with a newer kernel that includes the updated IOMMU subsystem. I'll share the results by the end of next week.
> 

thanks


