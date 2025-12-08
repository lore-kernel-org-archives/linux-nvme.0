Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B450D1CDC6
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Dec 2025 02:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kl1NMCtZ2Jsf9Or9+XsKcM+aoIigdMHQaw+fiv4O1UQ=; b=Wnpt5vMSq/W3nibLftHn1E+Etz
	T8IZEPWqZMikq6YTFdwS1PrSAZ8KTxsK1RHc4qLPG7LnaOVT4ZWcl/O5apXZ1DJy6m6673IhACzgh
	74J1lEoE0VDnG0ezrSemgShOjpewxAD6AsPo4S51pHpOXWt4ww7a3rNJ64hDkDACIeb5xvTE7uJUJ
	peB5UYd0EnXjnysjWmhn+cuvdCQ0qnf2uWFA2sXf8e/laftzKJxbXos8lYD5g6Ev1B9Z5L0MHSkT7
	qwHh8+MukDot7pY8OedmTtlHkoXP6gRcjuEBDAWDIRUBFAwHRzLzyiYllpopGt5ZtYX7ca+qlR4np
	eiZLy50A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSRHs-0000000CV8h-1f46;
	Mon, 08 Dec 2025 02:47:44 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSRHp-0000000CV8G-2PLN
	for linux-nvme@lists.infradead.org;
	Mon, 08 Dec 2025 02:47:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765162061; x=1796698061;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=6TwHcb5iUovQX1XFCXHnFY38ZruK56VM+5PnT7qnu20=;
  b=jlxYSQnwk5nAkZxzetA7E9U9SlwhBs1zkIZLkGEfUDJSnJagDeEvmvGr
   kCuz18Dc8w77ZQmJhhSDHXDkbM8RuFXwv70f3jLm5MvliHyAkRSPP9elr
   x/ik2oTqQBcC/Ffe+WnoB5rDnV7Oj1T+HxDS7o5xoYHIvu2vh2ipQzker
   OQsI3dLoHvFgaO+85E/uwLk30nquYB+GYCOxLZFvXUdhlZQTuCvDjNVdt
   Vb6cNsP7nXDfoIWYPyRiDXBiSOSeCUml+PHtubG/8thItnJSgeV151veY
   tUz660l01qNOqdQaRpdow42f6iKVaH19OgwWldSrN+GYmykSmEWgqy/Yy
   Q==;
X-CSE-ConnectionGUID: KXkBFZegSqyiqe3gZtHCgA==
X-CSE-MsgGUID: 5etq6RQNQ4qTpteWeVJM3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="70957769"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="70957769"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 18:47:40 -0800
X-CSE-ConnectionGUID: uJPi9MaPTbeYe7fO5XbNjw==
X-CSE-MsgGUID: aPr5tsLvTxWcHxRb5YKL8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="195848648"
Received: from unknown (HELO [10.238.3.27]) ([10.238.3.27])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 18:47:36 -0800
Message-ID: <585538f9-10b8-4da9-8566-179fa789f4ab@intel.com>
Date: Mon, 8 Dec 2025 10:47:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, Dan Liang <dan.liang@intel.com>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
 <aRKssW96lHFrT2ZN@fedora> <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
 <aRMnR5DRdsU8lGtU@fedora> <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
 <aRU2sC5q5hCmS_eM@fedora> <da1d6b4e-038c-48dc-830d-5eadb3ac943f@intel.com>
 <aR0i2f91VGv47swo@fedora> <7ec85f26-25fa-4c77-9e46-347261723d95@intel.com>
Content-Language: en-US
In-Reply-To: <7ec85f26-25fa-4c77-9e46-347261723d95@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251207_184741_698371_74CD2096 
X-CRM114-Status: GOOD (  26.48  )
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

On 11/24/2025 3:58 PM, Guo, Wangyang wrote:
> On 11/19/2025 9:52 AM, Ming Lei wrote:
>> On Tue, Nov 18, 2025 at 02:29:20PM +0800, Guo, Wangyang wrote:
>>> On 11/13/2025 9:38 AM, Ming Lei wrote:
>>>> On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
>>>>> On 11/11/2025 8:08 PM, Ming Lei wrote:
>>>>>> On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
>>>>>> They still should share same L3 cache, and cpus_share_cache() 
>>>>>> should be
>>>>>> true when the IO completes on the CPU which belong to different L2 
>>>>>> with the
>>>>>> submission CPU, and remote completion via IPI won't be triggered.
>>>>> Yes, remote IPI not triggered.
>>>>
>>>> OK, in my test on AMD zen4, NVMe performance can be dropped to 1/2 - 
>>>> 1/3 if
>>>> remote IPI is triggered in case of crossing L3, which is 
>>>> understandable.
>>>>
>>>> I will check if topo cluster can cover L3, if yes, the patch still 
>>>> can be
>>>> simplified a lot by introducing sub-node spread by changing 
>>>> build_node_to_cpumask()
>>>> and adding nr_sub_nodes.
>>>
>>> Do you mean using cluster as "NUMA" nodes to spread CPU, instead of two
>>> level NUMA-cluster spreading?
>>
>> Yes, I think the change may be minimized by introducing sub-numa-node for
>> covering it, what do you think of this approach?
>>
>> However, it is bad to use cluster as sub-numa-node at default, because 
>> cluster
>> is aligned with CPUs sharing L2 cache, so there could be too many 
>> clusters
>> for many systems in which one cluster just includes two CPUs, then the 
>> finally
>> calculated mapping crosses clusters inevitably because nr_queues is
>> less than nr_clusters.
>>
>> I'd suggest to map CPUs sharing L3 cache into one sub-numa-node.
>>
>> For your case, either adding one kernel parameter, or adding 
>> group_cpus_cluster()
>> API for the unusual case by sharing single code path.
> 
> Yes, it will make the change simpler, but no matter using cluster or L3 
> cache as sub-numa-node, as CPU core count increase, there is potential 
> risk that nr_queues < nr_sub_numa_node, which will make CPU spreading no 
> affinity at all.
> 
> I think we need to keep two level NUMA/sub-NUMA spreading to avoid such 
> regression.
> 
> For most platforms, there is no need for 2nd level spreading since L2 is 
> not shared between physical cores and L3 mapping is the same as NUMA. I 
> think we can add a platform specified configuration: by default, only 
> NUMA spreading is used; if platform like Intel Xeon E or some AMD 
> platform need second level spreading, we can config it to use L3 or 
> cluster as sub-numa-node for 2nd level spreading.
> 
> How does that sound to you?

Hi Ming,

Hope you're doing well.

Just wanted to kindly follow up on my previous email. Please let me know 
if you have any further feedback/guidance on the proposed changes or if 
there’s anything I can do to help move this forward.

Thanks for your time and guidance!

BR
Wangyang


