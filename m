Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FC4CED243
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 06:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKclSGBj7zSj0as7l6NBIcq8feE1HY9Hy5PhcZcnymc=; b=VBVDHRWxNsS2IVo8bI0Ga46NR2
	Qc4PW7Ri6Zpnluy3uVtDGSVyzH7gw0qcoSVYOQ7f3Zb6MgSVknEk2nNRTFQRmZUocdPhzL2fch8FU
	zBDzu6jJzESjOmIchh59XOQCxanY68d2W26CC3w2tOALwSsQswHzwvU7bJkBOnuXu1eaAggCUCFdk
	29C0fBd6i4esxvQHP445mzYVt35cYymDkaGuxIlaSlgVZYqTxJRbD2lFEChjjCiPDE/oYKNtfrifT
	myK5wcjpBazD5WKJZ2HSQy3VwgNbLD7AaIKn2i5RFgofjnyN2CWDmTAh2IbaU6H4UEh02hN8sFhI9
	KZyOqu4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLFDd-0000000HUi9-2NDm;
	Tue, 18 Nov 2025 06:29:37 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLFDb-0000000HUhf-0SHA
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 06:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763447375; x=1794983375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NMsOTA1DMJ5iERcAl/pml2D6iYbp4MdUF6qfsG/xYvM=;
  b=M9jZ+UO9mInVTh0Lkq22saZraecZhVAdd9DnkKz8iHonUaMRaludp3UA
   nc3BRx8RYacXraP2oZFdq+qrjaZA4i0YqQfsWoLNXHWxDwYz1+TyxavSB
   xAewxb+WTSoHCGD0jw0itv12zKbkwM0QKpwvcov+hzX9rkSE9y4zTUKK5
   1Cq5ZIbse7hwHBgq6KudV4Ru4dINWZbtPewFcIcgKrVc3SKAVOI2mh1/Q
   +5M6LfWIZn23uyV5pRuKztL90vzKXgFveVDlRpAQhuAP1Sn3yxLeVi7S/
   6xXuogoNGladtxQAyyXL4z3+Bmj2uNU8QVGpKsVXZIYkBmstMf60cK/f5
   Q==;
X-CSE-ConnectionGUID: FvTzC1vZRnmm1EKvvJgGFw==
X-CSE-MsgGUID: aVLHEdNUSbG0JlI1/6vJWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69329995"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69329995"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 22:29:34 -0800
X-CSE-ConnectionGUID: IV4Gw64wTteTnz/8Ll8CNg==
X-CSE-MsgGUID: EbEOfi6kSRy4agmjdcOZcw==
X-ExtLoop1: 1
Received: from guowangy-mobl.ccr.corp.intel.com (HELO [10.124.242.244]) ([10.124.242.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 22:29:31 -0800
Message-ID: <da1d6b4e-038c-48dc-830d-5eadb3ac943f@intel.com>
Date: Tue, 18 Nov 2025 14:29:20 +0800
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
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_222935_192891_CFC92A90 
X-CRM114-Status: GOOD (  13.07  )
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
>>> They still should share same L3 cache, and cpus_share_cache() should be
>>> true when the IO completes on the CPU which belong to different L2 with the
>>> submission CPU, and remote completion via IPI won't be triggered.
>> Yes, remote IPI not triggered.
> 
> OK, in my test on AMD zen4, NVMe performance can be dropped to 1/2 - 1/3 if
> remote IPI is triggered in case of crossing L3, which is understandable.
> 
> I will check if topo cluster can cover L3, if yes, the patch still can be
> simplified a lot by introducing sub-node spread by changing build_node_to_cpumask()
> and adding nr_sub_nodes.

Do you mean using cluster as "NUMA" nodes to spread CPU, instead of two 
level NUMA-cluster spreading?

BR
Wangyang

