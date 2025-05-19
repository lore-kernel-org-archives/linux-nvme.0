Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA5FC2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W931bp1PPLRgzrkrjIEqYJSl+uLP/cGORmasuEDeRcs=; b=zGvb4Q9usHcYIl2FKuvZdtTwmQ
	IBU8CFjq1o5YKVXMeUsTpC9I/GB16/26GDnZr0L0uwWFKqM5+D43KpxBldkiaF/z5rMeDPJxfH+e6
	Z+b9vznXNvT1QOETQFX76uomQkYClDciPbypLfGJPDfuOL+nifIJDXhXLE4r0Un4HpJgwl8PwNUpp
	PV27TOW37Kn3ChVDdUYJkI0LNYrDfX2jTaZWeOt7IXAILFmWgywvMlJpdWyvCT54Gp8QF5ncTrLns
	mKSPFSpJhZ01aU7z+A2+v0yetIG+p3vQUl9miKipZQmgzG+o/yqv5x6o+S9RyCxEx8Jd+G6isof5u
	hxQqXB8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH9GX-0000000Amc3-2jtD;
	Mon, 19 May 2025 22:47:25 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH9GU-0000000AmaV-1QLF
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 22:47:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747694843; x=1779230843;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bE25ZW6R+38LiKtAjLTYEWSDzeFbUDGDztlxBqqw/VY=;
  b=FTqTfD3bEM3eOPIP5YVe2RxHJUJHr+ROQixT2v8aYC6cwzVcg9M0t89X
   NdxjiJqz51cDKoHG+XWSg6KClpu+WKp0nYWsBWkE96KtyJvrS8JiM3sq7
   iH85DGfUafOIQjsIRzJQtAnK7TWo5mQgS15OpA+MMdV8q/s03pmzh4wlQ
   TiOZzgHKJvPF7uU87YcnuHrrmHDOPVWvD3HIaJIQbynCZpeA1aJbko5yO
   46laKywDKtnx3ai04+f7+rokFlBCnnWTysUy1r/cWwjlNe26qJvkYsK53
   /+oB/W7k/Q2TfEG2kxJ3W7mi+qRGRVDq+/x+Q8gn6l0Dxs1hx3K6vJKNY
   g==;
X-CSE-ConnectionGUID: eZiW9CkmREC3tWvi3GoUIA==
X-CSE-MsgGUID: XzedGoMNRvOuKqPFhtJduw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49764440"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49764440"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 15:47:21 -0700
X-CSE-ConnectionGUID: pAV0NJbsQES7NBX6G693Sw==
X-CSE-MsgGUID: htEGmzKDTQS85YRkyrvNvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="176621208"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 May 2025 15:47:19 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uH9GP-000Lxq-18;
	Mon, 19 May 2025 22:47:17 +0000
Date: Tue, 20 May 2025 06:47:04 +0800
From: kernel test robot <lkp@intel.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: [linux-nvme:nvme-6.16 40/42] drivers/nvme/host/multipath.c:13:6:
 sparse: sparse: symbol 'multipath_always_on' was not declared. Should it be
 static?
Message-ID: <202505200655.rD3it4Yp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_154722_410881_90F6ADCF 
X-CRM114-Status: UNSURE (   8.62  )
X-CRM114-Notice: Please train this message.
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

tree:   git://git.infradead.org/nvme.git nvme-6.16
head:   fc9c5b746e651c57ea8b8d702659db8f2e9847b2
commit: 01e5e7a813c4deafdb4b18ce6623bd693c4d0a57 [40/42] nvme: introduce multipath_always_on module param
config: powerpc64-randconfig-r123-20250520 (https://download.01.org/0day-ci/archive/20250520/202505200655.rD3it4Yp-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250520/202505200655.rD3it4Yp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505200655.rD3it4Yp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/multipath.c:13:6: sparse: sparse: symbol 'multipath_always_on' was not declared. Should it be static?

vim +/multipath_always_on +13 drivers/nvme/host/multipath.c

    11	
    12	bool multipath = true;
  > 13	bool multipath_always_on;	/* default is flase */
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

