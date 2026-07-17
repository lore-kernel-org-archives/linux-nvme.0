Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3605AC44514
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2026 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLqnuNiLT/gp5UpA9MlMC64Vcg5C1tuFHFN8X2dJeCY=; b=pa8XCLMKLj0gmG1XE/CUS7+her
	qFN/KxqvoL9lfZU609vPXaLR2Mo9j3OGtGgB+55Nk0qlXYnPlkxzA3TSYT28EZfxCH7M7Sl4UNyr7
	HyMxz5usYbCdr1EOSxOG6TbGLx8/WDil/RtnvO0KoCa2WDmwH9F3lg2eSLJjrVO8efbHfs6264n9b
	vucHCoMDwVIS0xXDHauQSWmsUFX+QWrZk0Qz2XZELGKjMGwCo0AupEnmGg8lWALPy3lXbmOah4Rsp
	JyXvx0PFNGX+yNhfFt3nX4fcBgwv07HndBT/q6XIsUTvLUsq+j0OLvIk0DbgCkNSzAif4pD9pRE30
	3gQ66dmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkdaP-00000001Yqv-2hZj;
	Fri, 17 Jul 2026 08:06:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkdaN-00000001YqI-2voB
	for linux-nvme@bombadil.infradead.org;
	Fri, 17 Jul 2026 08:06:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PLqnuNiLT/gp5UpA9MlMC64Vcg5C1tuFHFN8X2dJeCY=; b=X4SRCAJyEpZR/UkX7CC6kzLgBX
	9sKnRqME/9pdAZpDrZzvh9Kypv29r4gmCdBsf+hsJXKTi7I/PrhA0xQ1dqMH/oalKcdmoYabMXfFK
	+jWs6xP1WAbuo/xGefZH2zoFn9VvOmzGfuDWVRGvmrAnR2W4gD63ENvRLW5Bx3D7jQtvnaDSIRAe0
	4UvW/jd+iMOdzn5kcP6AYQA2xy72DFFUqq9bsE49OAlazWpj+wres9cFSKWYyVAMOpAITd4OWUGUi
	PHJJxhB616Jmz/oD0BIiysP9fHqMpcaV6m2cE1JlXmPa3HRlNHex3i6wmvvYqhBFsbcnpEG7RSrdb
	8Vv+m57g==;
Received: from mgamail.intel.com ([192.198.163.12])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wkdaK-0000000EdxK-0WbK
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jul 2026 08:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275576; x=1815811576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4vzXwRe1sO9hTpu1SsWylPhaKJq6rEbUfjP1I0vj/Bo=;
  b=HuvhH1Qg45I3nPiCjRNNRG0bNoKnCIJfuK2FK4EHFfgDuPoeLTR49mzJ
   sO7k2Co7qO7epck5o5muqnSR4/UUpevO35N7+p02CAnZbQ4OCVLe7jcOs
   gq0JLRttlUgj+qRxR0/9W4iz++mFnBRj4jEH8kLGbRk05T1pa68NUiBml
   nIgphPq04r70ncJStNRMdR6tIUv4Oft9aaAlwK3R1HheYcPfiNqP8lxZJ
   UvCbP4BwWoYIXSvDO8Q+yfENJwPPRuc7byfJfvnDufdlgdli4spGIC+oC
   7s4qBXs3mQKmi6Ua/lASlqvlUVNljuiQnV61UdS/lLcdsz+Nc1/JgIhb7
   Q==;
X-CSE-ConnectionGUID: ug1WKNnCRgWi0SXijknkFA==
X-CSE-MsgGUID: 2nJ36+GKR2e6+WLE6wJ6rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="88768120"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="88768120"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:06:07 -0700
X-CSE-ConnectionGUID: ix2ZlVKQRbObXWP3zLOIIg==
X-CSE-MsgGUID: RfWHFxinT1SzBz2RhedF+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="255569536"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:06:05 -0700
Date: Fri, 17 Jul 2026 11:06:02 +0300
From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To: "Zeng, Jun1" <jun1.zeng@intel.com>
Cc: Keith Busch <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Cao, Gang" <gang.cao@intel.com>,
	"Jin, Jun I" <jun.i.jin@intel.com>, "Hu, Yong" <yong.hu@intel.com>,
	"Fang, Liang A" <liang.a.fang@intel.com>
Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Message-ID: <alniatQyhRigGk8K@ashevche-desk.local>
References: <20260715075703.15578-1-jun1.zeng@intel.com>
 <20260715075703.15578-2-jun1.zeng@intel.com>
 <allEmTmXCFosxIOr@kbusch-mbp>
 <DM4PR11MB5375D7EECD0C888146CA2BFEB7C62@DM4PR11MB5375.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5375D7EECD0C888146CA2BFEB7C62@DM4PR11MB5375.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_090616_636341_09668D44 
X-CRM114-Status: GOOD (  17.81  )
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

On Fri, Jul 17, 2026 at 04:10:08AM +0300, Zeng, Jun1 wrote:
> Hi Busch, 
> Thanks for your reply. The main reason for implementing this in kernel space
> is the lack of a unified, deployable component in user space to support this
> feature. You see that there are sheer number of OS distributions. This will
> require separate adaptations for each, usability might be compromised,
> and-most importantly-ongoing maintenance and updates would be difficult.
> Meanwhile, nvme driver in kernel space is providing these unified
> capabilities for different kinds of usage.  For the point of using
> atomic_long_inc in cqe polling we can discuss to do it in a proper way.

You need to stop top-posting!

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org> 
> Sent: Friday, July 17, 2026 4:53 AM
> To: Zeng, Jun1 <jun1.zeng@intel.com>
> Cc: axboe@kernel.dk; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org; Shevchenko, Andriy <andriy.shevchenko@intel.com>; Cao, Gang <gang.cao@intel.com>; Jin, Jun I <jun.i.jin@intel.com>; Hu, Yong <yong.hu@intel.com>; Fang, Liang A <liang.a.fang@intel.com>
> Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
> 
> On Wed, Jul 15, 2026 at 03:57:03PM +0800, Jun Zeng wrote:
> > Add adaptive interrupt coalescing to improve IOPS for high-throughput 
> > workloads. Monitor IO pressure periodically and enable/disable 
> > coalescing automatically based on IOPS, queue depth, and inflight IO thresholds.
> > This feature is enabled by default, can be controlled through debugfs 
> > variable during runtime.
> 
> Can't you do all this from user space? You'd maybe need the blk-mq debugfs to get access to the individual hctx dispatch numbers, but maybe that's okay?
> 
> The atomic_long_inc where you placed it is especially harmful to polled queues.

-- 
With Best Regards,
Andy Shevchenko



