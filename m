Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F5ECFD31C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I2QjR4dd4sV1VpcI1WjnUD06gV+tHlSOl5rkvWO1k/w=; b=257Lx6q6wMcLmjGG0sft+EnGv8
	ZNVEWTIJ1ypupPDOZBH8l+G9DzvMc9poQcHW2y/lQrd8WrJfO1BucFfbdVmYuWN0Na9XBP6wOFDqN
	y4BICD4ddXRzeaZkdA4jdgp23tZKgBva/ZmAUtwNf9UXUNLmgrUOx0Y+IVEg9a3AeadLK0+rZSHq4
	OaLDeH80fTDAfvi9mtSl0HjZ8oYE7KU8LRcllGY4tEXfThafGEf82dwC9D04LO8uLPB/BVlAZB6xz
	A/dxRaniuqLaWRmppQysUwsd7PK57HkVcVpWWy2NEegH3uLaSbVwgUdxZXi7ig+i4OMglYl3o7B9l
	WjF0JYdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNRSk-0000000BFhu-2vOK;
	Mon, 24 Nov 2025 07:58:18 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNRSi-0000000BFhJ-1s4p
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 07:58:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763971096; x=1795507096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ae5tX+v5RROh+5aoVNw1pnY6DIZTMmbqs28uiQWG/8c=;
  b=Zk+LcMQFtzmUGloTLYdqyrWyOriMlVTXhdl+pP0YTfg+T7HljWY4HdKi
   4w+Is5nFou9wK9M4epbxYJPGiXNpkcRdctI+VZhFqzmswL0zWsI0GuAHX
   e7fZS5OdaG69bXmF3FEd1TXWkU/dbsIngqUUdEmr/CjxYA2WXO49myYi/
   s2YFlBus99rh3udJdohHob8H4Z4LPdxUdCLdTVgu9AGZHD2GYoIQWZRVt
   yd3PGaVONli2Nkmbh5QK6vi0mAa8XGwIb4whW/cyMvcopuxd8mqXfcxjE
   92NVq98o8FjJzk9TxeR0AUV2lU0TmzCfVqZlVNZ5R+mKJ9xNmS/js275G
   A==;
X-CSE-ConnectionGUID: v/Bgg3HIReWuWaOFD7EDwA==
X-CSE-MsgGUID: FJjztHJhQEGN5kydDNI3Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65857415"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="65857415"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 23:58:16 -0800
X-CSE-ConnectionGUID: v2GhJ8LmTGKX2i6H1+66kw==
X-CSE-MsgGUID: zeRrEEwyQDuIfIET5XUXwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="222913548"
Received: from guowangy-mobl.ccr.corp.intel.com (HELO [10.124.242.244]) ([10.124.242.244])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 23:58:12 -0800
Message-ID: <7ec85f26-25fa-4c77-9e46-347261723d95@intel.com>
Date: Mon, 24 Nov 2025 15:58:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
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
 <aR0i2f91VGv47swo@fedora>
Content-Language: en-US
From: "Guo, Wangyang" <wangyang.guo@intel.com>
In-Reply-To: <aR0i2f91VGv47swo@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_235816_505111_BA94DD48 
X-CRM114-Status: GOOD (  22.62  )
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

On 11/19/2025 9:52 AM, Ming Lei wrote:
> On Tue, Nov 18, 2025 at 02:29:20PM +0800, Guo, Wangyang wrote:
>> On 11/13/2025 9:38 AM, Ming Lei wrote:
>>> On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
>>>> On 11/11/2025 8:08 PM, Ming Lei wrote:
>>>>> On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
>>>>> They still should share same L3 cache, and cpus_share_cache() should be
>>>>> true when the IO completes on the CPU which belong to different L2 with the
>>>>> submission CPU, and remote completion via IPI won't be triggered.
>>>> Yes, remote IPI not triggered.
>>>
>>> OK, in my test on AMD zen4, NVMe performance can be dropped to 1/2 - 1/3 if
>>> remote IPI is triggered in case of crossing L3, which is understandable.
>>>
>>> I will check if topo cluster can cover L3, if yes, the patch still can be
>>> simplified a lot by introducing sub-node spread by changing build_node_to_cpumask()
>>> and adding nr_sub_nodes.
>>
>> Do you mean using cluster as "NUMA" nodes to spread CPU, instead of two
>> level NUMA-cluster spreading?
> 
> Yes, I think the change may be minimized by introducing sub-numa-node for
> covering it, what do you think of this approach?
> 
> However, it is bad to use cluster as sub-numa-node at default, because cluster
> is aligned with CPUs sharing L2 cache, so there could be too many clusters
> for many systems in which one cluster just includes two CPUs, then the finally
> calculated mapping crosses clusters inevitably because nr_queues is
> less than nr_clusters.
> 
> I'd suggest to map CPUs sharing L3 cache into one sub-numa-node.
> 
> For your case, either adding one kernel parameter, or adding group_cpus_cluster()
> API for the unusual case by sharing single code path.

Yes, it will make the change simpler, but no matter using cluster or L3 
cache as sub-numa-node, as CPU core count increase, there is potential 
risk that nr_queues < nr_sub_numa_node, which will make CPU spreading no 
affinity at all.

I think we need to keep two level NUMA/sub-NUMA spreading to avoid such 
regression.

For most platforms, there is no need for 2nd level spreading since L2 is 
not shared between physical cores and L3 mapping is the same as NUMA. I 
think we can add a platform specified configuration: by default, only 
NUMA spreading is used; if platform like Intel Xeon E or some AMD 
platform need second level spreading, we can config it to use L3 or 
cluster as sub-numa-node for 2nd level spreading.

How does that sound to you?

BR
Wangyang

