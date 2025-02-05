Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F840C02192
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Ifq6uKGUTWcB0cNc6TMuaNxJkrmPEShpTQe1dqqGGg=; b=YSbxrHoxxUETZxFlzNA2J061lw
	8I+Cwv89GjjXiv4BkgBJGmkOydpplDSzMjzX8mPRYZyzLxKfwF5SnP1E4Cz+OuHkqihc7lVLD6UVa
	JRaOdieZ2PW/2E6vbbBRAAMmR9AK8op08yw0JOuGN32vKGjddFUi4lUQlU2dTgOntdgslTwSoE3vc
	R+tllvjqBfQS/PXWtpvjbAu5/rAFVJGfcT7WpPyYmO5JTuTOH+ydXEqioVEsGQbA5DopfoGp5F3MU
	GbCjdelsIkysBz2vq7wZ1Aumm3+IZ8llXVfE5nTaeLUMVCDzhh+Scn67SeJdwv1KehE1cn59fBGiv
	bJigNrXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfaEz-00000002Wh6-0JOr;
	Wed, 05 Feb 2025 07:54:33 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfaEw-00000002Wgk-2ncC
	for linux-nvme@lists.infradead.org;
	Wed, 05 Feb 2025 07:54:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738742071; x=1770278071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X2hlbfos53+4cHlM6vapV+xkKrspJUB9EmieEGYsqk8=;
  b=feQ69naonAqWdGxz38Olh89FSZg2M8qw2MjqDeoThRpMdObyuA3Kshl1
   TEvEGt8H04qjUv/kgX7EnSYe0Ne5M+AjIrvyL50i3xh5iJh7vWwa3YC6E
   QRLptnO4W2GO4papWPywKnhwlPRAWrgvp5dvVo0LYJRXkiEFnUaHSniIE
   K3ZwnkmVwdvgONeYCPLmqdNQtDqqP/lXcdHccPn/THxrVNAMRLx3RDhJT
   oWcdvlCNi/dxyjwjASvXLQf/wodEre0AYvPixa6u0EITvDEVj1fBBfknu
   WQYn2lm9AwHf72MCikwCZVx7jMeTvy1UE3wlSQZ5RRQwIPehn3LiAkZk0
   g==;
X-CSE-ConnectionGUID: YR3MxMTkSmCVBHWOI6Z84g==
X-CSE-MsgGUID: 6/wdNNDaS7KP1mNDoh7UUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38996521"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="38996521"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 23:54:28 -0800
X-CSE-ConnectionGUID: 8Ypj8xm/TimAxOF5tP8ypQ==
X-CSE-MsgGUID: chAO3RCvQpKvyidZSr6Ztg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114892203"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 23:54:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tfaEn-00000008PxK-1ras;
	Wed, 05 Feb 2025 09:54:21 +0200
Date: Wed, 5 Feb 2025 09:54:21 +0200
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
Subject: Re: [RFC PATCH 0/3] Add an option for devices to skip SWIOTLB
 pre-copy on read.
Message-ID: <Z6MZLWRv1hC8uLo1@smile.fi.intel.com>
References: <20250204233630.3407878-1-jxgao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204233630.3407878-1-jxgao@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_235430_784005_CE300C46 
X-CRM114-Status: GOOD (  14.39  )
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

On Tue, Feb 04, 2025 at 11:36:27PM +0000, Jianxiong Gao wrote:
> Removes an extra memory copy that occurs during IO read
> operations through the SWIOTLB. During high throughput
> read workloads, this extra copy is causing a lot of stress
> on the SWIOTLB.
> 
> With high performance devices, for example NVMe devices,
> the device will be overwriting the entire buffer.

Is this really guaranteed? I can imagine surprise power cut or
hotplug event, for example, just in the middle of the transfer.

> In such cases the entire pre-copy is redundent, only to slow down
> the overall bounce buffering.
> 
> We propose to add a full_buffer_write flag to the
> device_dma_parameters flag. When the flag is set the pre-copy
> can be omitted to boost performance.

-- 
With Best Regards,
Andy Shevchenko



