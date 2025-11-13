Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F38CD4F2F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 03:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sXVxEkC2SrvW/29DUrKKVjixfWisM3bDkzJFniqaOIk=; b=SZAd5e7kZ6n+NzO+2pmFV4RJ7i
	tylvlQgmMeodqfaGMOPTMwDFsqSziHUbqis+ZBX+d1H8GHwUMqBAT/n+nubL6ZJ7NOBjx5VWdINGp
	isEMZKVHnSkSkgB9b5/z3NIYLvtuWMOkpq8g1FaM30JvPMud+BuqoNNalFjazXMQCcxLDkusZQHTe
	RV6+AkBK8/mYrpM1Tw1JZsWK9LvLYkEMP71/SB5/3fAxsY8q8AQSvnZZ1D9mYynDC3Up3X5UeCze2
	gCIGSB5njW0wzh8AXpwFZ+jd23OfFuFP7kBzKxJZ6ish/6aLjvFIRhrA7dI4MDjBT/mULhoZJsdG2
	cAEgSSOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJO4i-00000009qMQ-1Nqg;
	Thu, 13 Nov 2025 03:32:44 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJO4f-00000009qLk-43LJ
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 03:32:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763004762; x=1794540762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nW8dYWJRACfO9SxIG8/7eN3wi1ZlRG3WcV3UoKJDPTM=;
  b=hPjChoR+bB1cTwcgZkkxGQkeTDkEg7xrGO5hE50J+dUkPusF/ftqHYhK
   Gnk86Rc9PU3Ivj0iyiReNcz79P/SeRdz10bawA10xgA8jZqo7npI0FymA
   G6Sa6doCen5Y0Aym81MfsWhiPqLUGmbSG/n8krpIVoC125SbzlMxsPWJJ
   JX2xBbNpCikEZWzfxzpjF67RYkTA0ViwUubauaieNOD+aMiqcBe8k2vZz
   AnED/shpSNysLOxNuVWdhleKDi1jt+ENM574PytC4PM+s9pNmajuq9gq+
   y23SQGBLFm+gVepjKT3xKfxH8TqnxJHWKRmty4WttsjvX1UWcmtB/gFX4
   Q==;
X-CSE-ConnectionGUID: PHrBvv8QTIia03xksyCJxA==
X-CSE-MsgGUID: KX3F2nrcTrmqol35WPZ6rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68943552"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="68943552"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 19:32:41 -0800
X-CSE-ConnectionGUID: O1uxeBX2Sa+cL9lsKqBhsA==
X-CSE-MsgGUID: s7OouAHqR/OR+ATVTBdb+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="193512952"
Received: from unknown (HELO [10.238.2.7]) ([10.238.2.7])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 19:32:38 -0800
Message-ID: <2ca29d50-88c4-4f4a-afc6-4b79700004e3@intel.com>
Date: Thu, 13 Nov 2025 11:32:34 +0800
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
 <aRU2sC5q5hCmS_eM@fedora>
Content-Language: en-US
From: "Guo, Wangyang" <wangyang.guo@intel.com>
In-Reply-To: <aRU2sC5q5hCmS_eM@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_193242_017581_5F3C89EA 
X-CRM114-Status: GOOD (  12.44  )
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

On 11/13/2025 9:38 AM, Ming Lei wrote:
> On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
>> On 11/11/2025 8:08 PM, Ming Lei wrote:
>>> On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
>>>> On 11/11/2025 11:25 AM, Ming Lei wrote:
>>>>> On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
>>>>>> As CPU core counts increase, the number of NVMe IRQs may be smaller than
>>>>>> the total number of CPUs. This forces multiple CPUs to share the same
>>>>>> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
>>>>>> performance penalty can be observed on some platforms.
>>>>>
>>>>> Can you add details why/how CPU cluster isn't aligned with IRQ
>>>>> affinity? And how performance penalty is caused?
>>>>
>>>> Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share the
>>>> L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 IRQs to
>>>> dispatch. The existing algorithm will map first 7 IRQs each with 4 CPUs and
>>>> remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may have cross
>>>> cluster issue. For example, the 9th IRQ which pinned to CPU32, then for
>>>> CPU31, it will have cross L2 memory access.
>>>
>>>
>>> CPUs sharing L2 usually have small number, and it is common to see one queue
>>> mapping includes CPUs from different L2.
>>>
>>> So how much does crossing L2 hurt IO perf?
>> We see 15%+ performance difference in FIO libaio/randread/bs=8k.
> 
> As I mentioned, it is common to see CPUs crossing L2 in same group, but why
> does it make a difference here? You mentioned just some platforms are
> affected.

We observed the performance difference in Intel Xeon E platform which 
has 4 physical CPU cores as 1 module (cluster) sharing the same L2 
cache. For other platforms like Intel P-core or AMD, I think it's hard 
to show performance benefit with L2 locality, because:
1. L2 cache is only shared within 2 logic core when HT enabled
2. If IRQ pinned to corresponding HT core, the L2 cache locality is 
good, but other aspects like retiring maybe affected since they are 
sharing the same physical CPU resources.

BR
Wangyang

