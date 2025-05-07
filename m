Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE03C3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cytfc2tUiWTIFOmvtWx+7Th69ywC6dGDXMyMQ35eBb0=; b=DEQvC/Fbpv/yo1kjNlzwoboIJX
	UM7N03oOsktJtn0H2Qmimz+3i05bBsMvkWlRWHSRZYbeeCoVQscPuQtK4febnfJw9VwdNyu7kUSLZ
	kKeLyzLZAIG1uNX4I3B425+F7sCP9/8t8OgUHRYMJJW66fIZBgpTIeGyRyjD6wdaHMpq+g8drALuE
	lAa680Li9VX9AFEc5lnA3QZE629uQUAhsPBW8ZlTISXn7oP/9jjdZPauQfdNloRhySUnIavVgDJsc
	IWm+bLXtSqQ6RBjIGclbMPjqk7fZqhEGT7gzm49LBINO04XTetoolEL/4Ru5b2kBuQtoA5AwOx8RH
	AFxkByag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCcOs-0000000F9kq-3gEj;
	Wed, 07 May 2025 10:53:18 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCcLD-0000000F9Iv-2Jt6
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 10:49:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746614971; x=1778150971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EaQLm/18zqp2g3Ts6r0JH+BLe1TiNJ5zMltPned8co8=;
  b=KmJpJT8KGn3hBdN58GDdQ5EMS6j0MJO9TEyzUJMEKPsbI/9xt+JS97Up
   lVOKjqd0s4gwuiJjWsEqDCd1xPTpb3kiSIUXJXhlefnStK+W3uP9K/NGn
   o4Xko1zY7E2u8DYlMEJYeg7j64YbBei+qCCtJytgiYBxPYAlx6pxCWCt9
   MwrHOu+mS2aBGFRQ3pf5xGzykA+Z9iyqDDbmgzAUy1G5T0VNw4CnoB8EB
   A0jwNcFvebL/oa3GRC7HKQFaOlDvSPoy5REZJYKV72gdYvNUJmut39gs/
   zEL3+Kk5Tu39K9XB0NKU9ezgDD9qJKoUrcGBbK1Q276wgNHKsrl6h59X9
   w==;
X-CSE-ConnectionGUID: tFjGcmjpTLCWSm7tPh02/w==
X-CSE-MsgGUID: wZ+rZYvkQ0+FUJjewRJReA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59689749"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="59689749"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 03:49:24 -0700
X-CSE-ConnectionGUID: oQ3XKjOGR0Snh74Td8oS/w==
X-CSE-MsgGUID: QMNFj8zyTc2FS47nqQuxuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="141043207"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 May 2025 03:49:22 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCcL0-0007dN-0d;
	Wed, 07 May 2025 10:49:18 +0000
Date: Wed, 7 May 2025 18:48:48 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v5 09/14] nvmet-fcloop: allocate/free fcloop_lsreq
 directly
Message-ID: <202505071848.zYLh3Kvb-lkp@intel.com>
References: <20250423-nvmet-fcloop-v5-9-3d7f968728a5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-nvmet-fcloop-v5-9-3d7f968728a5@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_034931_602258_938A5283 
X-CRM114-Status: GOOD (  11.26  )
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

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3d7aa0c7b4e96cd460826d932e44710cdeb3378b]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvmet-fcloop-track-ref-counts-for-nports/20250423-212643
base:   3d7aa0c7b4e96cd460826d932e44710cdeb3378b
patch link:    https://lore.kernel.org/r/20250423-nvmet-fcloop-v5-9-3d7f968728a5%40kernel.org
patch subject: [PATCH v5 09/14] nvmet-fcloop: allocate/free fcloop_lsreq directly
config: x86_64-randconfig-r131-20250426 (https://download.01.org/0day-ci/archive/20250507/202505071848.zYLh3Kvb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505071848.zYLh3Kvb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071848.zYLh3Kvb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/fcloop.c:297:19: sparse: sparse: symbol 'lsreq_cache' was not declared. Should it be static?

vim +/lsreq_cache +297 drivers/nvme/target/fcloop.c

   295	
   296	/* SLAB cache for fcloop_lsreq structures */
 > 297	struct kmem_cache *lsreq_cache;
   298	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

