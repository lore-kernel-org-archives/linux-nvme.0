Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7FACCFA1A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 03:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hypucH3nwi7sIRx4cO3BPgg/9v1vYBJciDfCLA2cc3A=; b=gvQ38a4GmDqtzvcG8CP5DE11Iz
	l2ag1zmbtazdbk69x9WVmTAuZ/bqOvlejYcpUAmi+/StkyFhlySmPSBS9r1SWbnJA3dTbwlyOdWQ2
	dskXY47BYjzzrzmeBNFIwI3OhBTimWrctSWPzJFmcuOuazwFSVzMtHq9a17cXKwCVC36JVjyNis0B
	SPcw4J5NQea+HZUwkISOkEGmok/l8fy4aBPPgeX5KEUMV6E4yx/erY2a7qtwOXQAnIirKzWyQ/dwi
	ZkYygcjEYO19HYoCMvukzuwkGzaR1oTbElNuvvXrzYiMgHiig+dTG1hjmSCBYzZFEmpUxOdMRfn+4
	s63SR8bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ18L-0000000839n-2xYi;
	Wed, 12 Nov 2025 03:02:57 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ18I-0000000839O-0WAN
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 03:02:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762916574; x=1794452574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0CzASL4FQtni4BE+5yAo9I0TqTLhNXvwqY61AaPkOZs=;
  b=gzbD2Tf3vr8NxFOl/PAhgdAEULOdWZ5gnxxl2TTxf7G6qW8Wtda8RA6C
   o3NV6vyyCnhCFH+MdnkSFkfC2fIKJQHCsyPXiM6thLQSjgdJD157//fED
   R12BDEyA7TY3KFureNEYC4orXdF8SfA1rEa2TnTHD4gwnbVPZMhY5gDH5
   fGr+lF/kdJ1sHSTOGv+sddD51my2iwgpq8eH2Z/ULo2bc3yOxshf7ZJKi
   5fxRmNowUZA57vfo0iRuHiZPHOfKIVtH7VQDz4ncYsE0mgy++idmy0KLl
   6WX6bjO7eqYgLwedBZywFoWqKWbIPvV0XcqropSFj9L6NvG8bauI0/xKo
   Q==;
X-CSE-ConnectionGUID: gh+csyV6T4qPmArpOf5VLg==
X-CSE-MsgGUID: cmf+wsVwQRaPEWpKz4pjBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="63981341"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="63981341"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 19:02:53 -0800
X-CSE-ConnectionGUID: vPPwIXwoShCC59bAM+JeaQ==
X-CSE-MsgGUID: mJrBIcSfTDGkGIwwzBS3AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="189531161"
Received: from unknown (HELO [10.238.2.7]) ([10.238.2.7])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 19:02:49 -0800
Message-ID: <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
Date: Wed, 12 Nov 2025 11:02:47 +0800
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
 <aRMnR5DRdsU8lGtU@fedora>
Content-Language: en-US
From: "Guo, Wangyang" <wangyang.guo@intel.com>
In-Reply-To: <aRMnR5DRdsU8lGtU@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_190254_178131_3AF70BB7 
X-CRM114-Status: GOOD (  13.52  )
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

On 11/11/2025 8:08 PM, Ming Lei wrote:
> On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
>> On 11/11/2025 11:25 AM, Ming Lei wrote:
>>> On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
>>>> As CPU core counts increase, the number of NVMe IRQs may be smaller than
>>>> the total number of CPUs. This forces multiple CPUs to share the same
>>>> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
>>>> performance penalty can be observed on some platforms.
>>>
>>> Can you add details why/how CPU cluster isn't aligned with IRQ
>>> affinity? And how performance penalty is caused?
>>
>> Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share the
>> L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 IRQs to
>> dispatch. The existing algorithm will map first 7 IRQs each with 4 CPUs and
>> remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may have cross
>> cluster issue. For example, the 9th IRQ which pinned to CPU32, then for
>> CPU31, it will have cross L2 memory access.
> 
> 
> CPUs sharing L2 usually have small number, and it is common to see one queue
> mapping includes CPUs from different L2.
> 
> So how much does crossing L2 hurt IO perf?
We see 15%+ performance difference in FIO libaio/randread/bs=8k.

> They still should share same L3 cache, and cpus_share_cache() should be
> true when the IO completes on the CPU which belong to different L2 with the
> submission CPU, and remote completion via IPI won't be triggered.
Yes, remote IPI not triggered.


BR
Wangyang

