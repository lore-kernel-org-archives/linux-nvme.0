Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F3CC02192
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 08:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcpOHGY9qTI2Wwgx3iKtWTxmk/183Ht/qkL/46VsLys=; b=m91CQrtF+5bOoLOjU/TcrO3VLh
	vfVdyGbnI2g5GtD18/tS3J5Jr/nRpfXUvijFcpj4KzHStx47bY1j3jLTXElPEAEqldWPTapD8obH4
	m2FeGD2IvAZ06oWp7iyrF4eLStlFKj85B9hGfqrrdsp2KYIY/2vjSaimrG1g/WEAEs90/3BvN2DsL
	yJfjQfnGfNmfDWuPfO355gAJZC3oT0fnNHTtMmsv3YzR8Eqre3oBTfBDZ3cMjtMghUq+Fbw9QM3o9
	PTPMLqKK+VKuIw9IxCpe3ImxEkukVMZriGsjRDqxzl3IeQJWrcNBovCJZN25tBnwAKNIslIkuWHvX
	FltVlgow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfaMB-00000002XOK-0CEA;
	Wed, 05 Feb 2025 08:01:59 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfaM8-00000002XO0-222V
	for linux-nvme@lists.infradead.org;
	Wed, 05 Feb 2025 08:01:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738742516; x=1770278516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VBluYxTvUntHJ3RXOgHBoml70dm3Qp8DZGEmWaTqk8M=;
  b=m+2LNgZhcM08oukBgNOADcsCwFC5Tkk/SHYKnM9167jVT5MZEvAo4i2o
   i+8TCpb0wcIiWjW1f+UU6aIZM1HULbt3BczxMtHnpSwK0tyMvbRVmLnuS
   Oj/30+JcOCcmUIbFMrSxTVfMqCBPEIk5IWYP2bbxxKdpoe+Z6Vc3nSyYq
   i6CRE1BoZQmwoVkc5hwZA1jFyad7tK3E1mWN72rSaPMQppSwqI4S6ujXN
   nlQlvqDwHL+GEkPYU5MPVyPw9XEgY42z5tWV6drAi8ta/9nvGrPIC8HaW
   17vYt/mikA283sUpv5FgWJ3m2jSx9/CCyslw4T5gPuihoogmX1XnsVGl7
   w==;
X-CSE-ConnectionGUID: Zs7GfwgRQMeVI9SlUHu5ug==
X-CSE-MsgGUID: KfOcD8sQRduYsH2Lj1k3mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38528926"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="38528926"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 00:01:55 -0800
X-CSE-ConnectionGUID: Nosr9nPrSyyGKBeyrjdQOQ==
X-CSE-MsgGUID: aJkEa+JRQteUXnUwfEPZPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110680426"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 00:01:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tfaM0-00000008Q4Y-0ehG;
	Wed, 05 Feb 2025 10:01:48 +0200
Date: Wed, 5 Feb 2025 10:01:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jianxiong Gao <jxgao@google.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Robin Murphy <robin.murphy@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ryan Afranji <afranji@google.com>, linux-nvme@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/3] add full_buffer_write flag to struct
 device_dma_parameters
Message-ID: <Z6Ma625UFfFw_uY1@smile.fi.intel.com>
References: <20250204233630.3407878-1-jxgao@google.com>
 <20250204233630.3407878-2-jxgao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204233630.3407878-2-jxgao@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250205_000156_663861_930D5681 
X-CRM114-Status: GOOD (  15.27  )
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

On Tue, Feb 04, 2025 at 11:36:28PM +0000, Jianxiong Gao wrote:
> When devices write to a buffer, some devices are guaranteed to
> overwrite the entire buffer. These devices may benefit from such
> behaviors by reducing the need to pre-condition the original
> buffer. For example when bouncing data through swiotlb, the buffer
> is forced to be synced before the device writes to it. For devices
> that we know for sure overwrites the entire buffer, this flag can
> be utilized to eliminate the extra copy on every IO bounced
> through the swiotlb.

...

> struct device_dma_parameters {

>  	 * a low level driver may set these to teach IOMMU code about
>  	 * sg limitations.
>  	 */
> +	bool full_buffer_write;
>  	unsigned int max_segment_size;
>  	unsigned int min_align_mask;
>  	unsigned long segment_boundary_mask;

Have you run `pahole`? Please, share the results.

-- 
With Best Regards,
Andy Shevchenko



