Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9CFCA5535
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o+XD2TZrxKS1GI6PCDJPqlHbxIKVvHbsh+8GhW5v1to=; b=n1UQesySnOdnPKBPGnZ72BK7D5
	p1BWfUNyJ61+QdhZ1Ce0IWeTVW/shKXH6lj/XmpQU49kd8Biy/TmU5mev+mYuXBvNOQ/ehoEiwrqS
	JvngJjqZS9ftP9pw85TaTrAMcdvaamsmgCH9c1FaqfHwOXzmi4/3uEZVA1ENVvzvavX911vSkuNF8
	NWvq2YDlbyxXje54bdVGyjlU6p8YOfLmuULuTTSoDYEcb5OWOlu9ft4/o76NR5abi0h0sLbtja1OF
	T6mlyNAKzVgulFAT1sxXKIS7pNowU7fEnPQsJKq3PXT/PC3eX9Ox50kUitjeGiGXSJ5U636r7iAvp
	gUj6K+ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgMx7-005ObW-10;
	Wed, 13 Sep 2023 10:18:33 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgMx4-005OYu-1K
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 10:18:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694600310; x=1726136310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SHP0nIGBAt4mtaptQJxzxBO3GPdpuwYHV4f9icbzzAo=;
  b=UgzxW8AOeEqCOeKn7/Psnr4MoQu/rm9RunIO9x6uxDZdtRKgrEoIskKV
   I+TrqUXeP8hwC/cJQzKkxsNr2ZlXcKy3WcXwW0N2SLw22jmgu1KfZvFkQ
   DzKciOfzYf/oVMx5gxi50UDcEWQoZTHsAUigiLYi5Keup1nr62JQ39hsy
   +4nf3mDLDP6CyxYeZQTS4uXrEFegUKywLFgSoNLwqNtZj4QvJNNCbPXUt
   BBIB8U/vCEw6hdAcT2x+DEfiJVij1ljI/An5qfME9C2Wt9DM2fLU1E7e5
   ogInY7eIjAIUIquxYI7a7nI3Yn4acJPufRE+98D1Y6B7PM5oMVAVCYqcP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="445058222"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="445058222"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="814171608"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="814171608"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 03:18:23 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgMwt-0000O9-0y;
	Wed, 13 Sep 2023 10:18:19 +0000
Date: Wed, 13 Sep 2023 18:17:54 +0800
From: kernel test robot <lkp@intel.com>
To: Ping Gan <jacky_gam_2001@163.com>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, ping_gan@dell.com,
	jacky_gam_2001@163.com
Subject: Re: [PATCH 4/4] nvme-core: Get lowlevel disk for target polling
 queue task
Message-ID: <202309131858.YUV19V9E-lkp@intel.com>
References: <006b6aefe94d73ee64931c769af4a908616439ad.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006b6aefe94d73ee64931c769af4a908616439ad.1694592708.git.jacky_gam_2001@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_031830_496733_D3D63E6B 
X-CRM114-Status: GOOD (  14.22  )
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

Hi Ping,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.6-rc1]
[also build test WARNING on linus/master next-20230913]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Gan/nvmet-Add-nvme-target-polling-queue-task-parameters/20230913-164112
base:   v6.6-rc1
patch link:    https://lore.kernel.org/r/006b6aefe94d73ee64931c769af4a908616439ad.1694592708.git.jacky_gam_2001%40163.com
patch subject: [PATCH 4/4] nvme-core: Get lowlevel disk for target polling queue task
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230913/202309131858.YUV19V9E-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131858.YUV19V9E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131858.YUV19V9E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/multipath.c:375:22: warning: no previous prototype for 'nvme_mpath_get_bdev' [-Wmissing-prototypes]
     375 | struct block_device *nvme_mpath_get_bdev(struct block_device *bdev)
         |                      ^~~~~~~~~~~~~~~~~~~


vim +/nvme_mpath_get_bdev +375 drivers/nvme/host/multipath.c

   373	
   374	//for polling queue task to get lowlevel block device
 > 375	struct block_device *nvme_mpath_get_bdev(struct block_device *bdev)
   376	{
   377		struct nvme_ns_head *head = bdev->bd_disk->private_data;
   378		int srcu_idx;
   379		struct nvme_ns *ns;
   380		struct block_device *ret = NULL;
   381	
   382		if (!multipath)
   383			return NULL;
   384		srcu_idx = srcu_read_lock(&head->srcu);
   385		ns = nvme_find_path(head);
   386		if (likely(ns))
   387			ret = ns->disk->part0;
   388		srcu_read_unlock(&head->srcu, srcu_idx);
   389		return ret;
   390	}
   391	EXPORT_SYMBOL_GPL(nvme_mpath_get_bdev);
   392	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

