Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64BAC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 21:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jheZMYcORyiVsqz0W30Qu6HZiy7qEPHLc5nz8KlBd50=; b=DW2ngCObqUlUlTS9NMAkEav5t5
	jFHaJWMGY4LYnyi3pQeqH5pLjiSVEXqbjxelJdy5P654if1P461wlr5u9PbfB6am0AczdtWGjYedJ
	bTv2nPLRjf5OKsCI1NGk3bgqWpg+nwWtjg3qDfyVwF/CEonrKzXC5G+5m2Ii+WmiLqCX3vesiGbt7
	acrvNVc9SYZVLZXUaCrkw2JqMsg25+ipBa/cD2HpKdPmncsNVnOcu+JPn9uQys7BowCMOlildmJWX
	Yn98xmu2qBlcdTWf2n9Mu6YOXnbG8QhAnJ4giCi+e6crRE37n4j2LJm3gznsyyxf9mGudWahSwZZR
	12C31ljA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK2y7-00000002n4S-2QgC;
	Wed, 19 Jun 2024 21:35:51 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK2y1-00000002n3k-3yOO
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 21:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718832946; x=1750368946;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IVLWGrQdrwxSxrECnzIWel80hY9K41v1LW8UYZES0Ag=;
  b=NiGTeYWS1ldApejzECdxd7IkOXKuMh/1gbQWjgMdl5TZ2C0k3M3O7C0o
   9TiCHM9hvRXY+iQe6+1wM1Chu/I8ryOvG77a+ApLhUQaOgK888A1mGFG5
   2sqg1Uf6WVG4ySsvNC+zkaqUKxglko1rSPqdIAs2zIF77x/BCmOse0h/u
   REbPkSC+Jf4JhEiDg0M/YqB3KKjx3CiO19+/NU+2F00J25wZbb5uQnvCQ
   aM6qnCLQWRBUefke2Vx3VpEEiiUv4xH+y9emVn/Cf5qNsrTdpJBHbHUGA
   aQP6etBTX9t4E2/ZexllVGP9Q8RzdGvMoVcFsUbCoRqmAh3mlGz3bqkHP
   A==;
X-CSE-ConnectionGUID: 5eDPLea1RMC/dVKK7FJGvw==
X-CSE-MsgGUID: ktP/k2FaREuX5IgC5Gr+aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15929789"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15929789"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 14:35:44 -0700
X-CSE-ConnectionGUID: t8AxtTr9RPKl7eP9/pZjIQ==
X-CSE-MsgGUID: /FZzdGeLRV2wsOOiZeqmfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="65278305"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Jun 2024 14:35:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK2xw-00071Q-1q;
	Wed, 19 Jun 2024 21:35:40 +0000
Date: Thu, 20 Jun 2024 05:34:59 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [linux-nvme:nvme-6.11 10/16] drivers/nvme/target/debugfs.c:16:15:
 sparse: sparse: symbol 'nvmet_debugfs' was not declared. Should it be
 static?
Message-ID: <202406200501.5DrFu8Fu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_143548_072479_9043C6A7 
X-CRM114-Status: UNSURE (   8.35  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.11
head:   30576c4bdf564c6afef97a6306e5aae7f2fd744b
commit: 7586ba95433d12335aa71bfc0ff61654a79797aa [10/16] nvmet: add debugfs support
config: mips-randconfig-r111-20240620 (https://download.01.org/0day-ci/archive/20240620/202406200501.5DrFu8Fu-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 78ee473784e5ef6f0b19ce4cb111fb6e4d23c6b2)
reproduce: (https://download.01.org/0day-ci/archive/20240620/202406200501.5DrFu8Fu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406200501.5DrFu8Fu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/debugfs.c:16:15: sparse: sparse: symbol 'nvmet_debugfs' was not declared. Should it be static?

vim +/nvmet_debugfs +16 drivers/nvme/target/debugfs.c

    15	
  > 16	struct dentry *nvmet_debugfs;
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

