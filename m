Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC550CCFA18
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 05:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cqYeQ0wP1112bBun9AwAZSV3cTwEG+JSM9WBGtRm9hg=; b=n64ev0VD7XrYcxo2fd7SWp4LP8
	tI7i5mz8lR+EiR6j9bHTOLgoDgGLn9VbYwqMa3jUjez7ccNDrs80MBEj4F84tTitSox9mVG+66sFc
	1ZXn/HrHawnlL3GEAVUidpWi13uxU68t4e42WDHuentY0F0WD5k/i/RC7jNTGxh/3jRVfnlDnlqTK
	/SSMBOjqvesUHmJ3THYWWxN8Uf22bXj1FbKhG4siLDjFuVITnaBFBG68R3ytIYGdKebLnbxi2V5Ur
	CO0adnPxpSD9mVhQk3G0FKIhczi3HwNu9/1suUxg7Ss9mDwK+crQ/FJuJOoyARnV7GV7+fCXmkexQ
	d0dAerGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIgyP-00000006Z4V-1hw9;
	Tue, 11 Nov 2025 05:31:21 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIgyN-00000006Z45-0T7W
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 05:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762839080; x=1794375080;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qmB23KBZam3+BYAe/TpOP+kDi8RzRSN2DKhHCUO1HcE=;
  b=QFf478hoo2aBo3jrikcO6eynm6GDM2cC2I7Jx8eYX2w4+xY8YTcudrc2
   OVnrio3twPV7X1LbstwC001GpXN4+Igrh3+iEMcY7+NjE+O5524xCF1+g
   asLsG6S3ixukh8hcccHJ4EQWkoSGfim+aay1h6JSkDQ9UvyG9XE+wxBfS
   28GEEunw+Mf5OluzcbYLzb++VIWvJaFZzustQ8ZPBshfFccLkMPhOUni8
   /sHml5gF36puoNyBqmfFxkYSCpiP4sjpgCccX1WPLH+bvw4TK+PO5UhGA
   Iwi+bbu7e+VEAOzoNCJZUoIwpTMovWhyXLYsP2BHTlwYW74+EO0HVby3c
   A==;
X-CSE-ConnectionGUID: D9Jr3JSxQh2Y3YFTjxxbLA==
X-CSE-MsgGUID: fgR9T2HaRQKXqihwMAUM8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64938310"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="64938310"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 21:31:18 -0800
X-CSE-ConnectionGUID: GpuEIhUYSumZNIgV9aF2cQ==
X-CSE-MsgGUID: W+UFF+FATv+zwiSXibzg0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="193870829"
Received: from unknown (HELO [10.238.2.7]) ([10.238.2.7])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 21:31:14 -0800
Message-ID: <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
Date: Tue, 11 Nov 2025 13:31:04 +0800
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
 <aRKssW96lHFrT2ZN@fedora>
Content-Language: en-US
From: "Guo, Wangyang" <wangyang.guo@intel.com>
In-Reply-To: <aRKssW96lHFrT2ZN@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_213119_221522_1D918646 
X-CRM114-Status: GOOD (  11.68  )
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

On 11/11/2025 11:25 AM, Ming Lei wrote:
> On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
>> As CPU core counts increase, the number of NVMe IRQs may be smaller than
>> the total number of CPUs. This forces multiple CPUs to share the same
>> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
>> performance penalty can be observed on some platforms.
> 
> Can you add details why/how CPU cluster isn't aligned with IRQ
> affinity? And how performance penalty is caused?

Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share 
the L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 
IRQs to dispatch. The existing algorithm will map first 7 IRQs each with 
4 CPUs and remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may 
have cross cluster issue. For example, the 9th IRQ which pinned to 
CPU32, then for CPU31, it will have cross L2 memory access.

CPU |28 29 30 31|32 33 34 35|36 ...
      -------- -------- --------
IRQ      8        9       10

If this patch applied, then first 2 IRQs each mapped with 2 CPUs and 
rest 9 IRQs each mapped with 4 CPUs, which avoids the cross cluster 
memory access.

CPU |00 01 02 03|04 05 06 07|08 09 10 11| ...
      ----- ----- ----------- -----------
IRQ  1      2        3           4


BR
Wangyang

