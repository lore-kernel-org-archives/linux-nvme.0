Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84553CC6B30
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 10:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LHESuAmcdN198dFsmEinPLfiZjBhShf5wCXW58beaE8=; b=ZI5c5c4GYt3OsZY60/RhCiI7tf
	zLPgnFZjZaMuICiDjRaXopljxAR2I4ifdrQO9Xc8CMtkfNY+F67kN9hNcNUByBQS3oHoqq5KpnbSF
	4m1xugkZGviET62urAHSon6513eKFfZwhdvLNU2doF95LRRCd8iNyWIW+hrwJvHpvv3xpWwPnbv/0
	TgyRxqfowkfbcMQR7Nynh5rV0AMVMj+NNj09pDoHtJNhcnWgG0IofY8VxH9Q1Rq9C04kY1UWSpxoK
	uOg9fnRfHujXxCqoX2DNRX9QYagKuk5Hc44xyxjGM1RmsUIuz4WpY29eQmO2W252oWB8C9zAev/0Z
	AfA1peZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHIjr-0000000HRf3-26yv;
	Thu, 15 Oct 2026 10:31:07 +0000
Received: from out-34.mta1.migadu.com ([95.215.58.34] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHIji-0000000HRdn-3EVx
	for linux-nvme@lists.infradead.org;
	Thu, 15 Oct 2026 10:31:01 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=KL50O/iWsTHmbo6NadhTpGohH+0IwIFZqJc3pja8taE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792060255; v=1; x=1792665055;
 b=LQtHygRSVbiX/tqocinrRwPZYKTkWTJ6aD/vJe6ehxQdft2TFWZSueOOBh6MnqHfRQGag1DN
 W6GoQGbL6WXpUxmnNbYEgm10kkLtPeTQ4nbjdTfxoQXIc0kL5xKvlgpMOo1S7uXDL3p4L/zGCtn
 8rddGaTkUafnq9OoGKhpzv2M=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id dd78c0c2979e365e;
	Thu, 15 Oct 2026 10:30:55 +0000
X-Mizu-Trace-ID: dd78c0c2979e365e
X-Migadu-Flow: FLOW_OUT
Message-ID: <f4f48392-4181-456e-b3d7-907a30b13825@linux.dev>
Date: Thu, 15 Oct 2026 11:30:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
From: John Garry <john.garry@linux.dev>
To: Christoph Hellwig <hch@lst.de>, Adrian Huang12 <ahuang12@lenovo.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jiwei JW10 Sun <sunjw10@lenovo.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20261006120248.147654-1-hch@lst.de>
 <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
 <20261008123724.GA22096@lst.de>
 <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
 <2007f03b-2c76-4c36-a0bd-0ce99d1a01a2@linux.dev>
 <20261012121736.GE29954@lst.de>
 <8894307f-1042-497c-9c16-3fc1312486fb@linux.dev>
Content-Language: en-US
In-Reply-To: <8894307f-1042-497c-9c16-3fc1312486fb@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_033059_120456_0C8F7191 
X-CRM114-Status: GOOD (  15.36  )
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

On 10/12/26 15:39, John Garry wrote:
> On 10/12/26 13:17, Christoph Hellwig wrote:
>> On Mon, Oct 12, 2026 at 09:42:04AM +0100, John Garry wrote:
>>> And now we seem to have a conflict, as Christoph wants block size > IOVA
>>> rcache limit but you find it may cause this soft lockup.
>>>
>>>> 2. Another NVME with mdts=5 (maximum data transfer size = 128KB)
>>>>     2.1 The issue does not reproduce regardless of the 'bs' 
>>>> configuration
>>>> 3. The condition '128 KB' is identified because the IOMMU scalable 
>>>> IOVA mechanism supports a maximum transfer size of 128 KB.
>>>> 4. IOMMU pass-through mode does not trigger the issue with the 
>>>> 'mdts=10' nvme disk.
>>>> 5. The issue only appears with high-core-count servers
>>>>     5.1 Reproduced servers: 448-core server and 384-core server
>>>>     5.2 Non-reproduced server: 128-core server
>>>
>>> How long does it take for the lockup to trigger? Pretty quickly, I 
>>> guess.
>>>
>>> Does changing the number of CPUs affect throughput (before the 
>>> lockup)? Are
>>> you using just a single disk?
>>
>> If the iova cache locks up under a perfectly normal workloads it
>> is broken. 
> 
> 
>> We really need to fix the code there.
> 
> Sure, but it would help to first fully understand the conditions to fix it.

BTW, @Adrian, it would be good to run your test with the IOMMU in strict 
mode as well, just to give an idea if there is a problem there as well.

