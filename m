Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55EECA5537
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sS7ReRR/M+OImPRFQ++q8S1uJWMB6MyvXTQVu7buiEA=; b=LPwJbh+dHEQB2r6h6pt9iLCVBK
	2pg6lxTIIdvYhGXXL94FouVEG0C6qZ1rdrXH4WPd9vgDN4Agd1lk5DV36n1s1siDyH6QbBEMwUTcc
	qvTE6diTGUMqLCzQvJrGZU0wpiK5AABOacNBh8rx/SiwcMCYN2HPt6sckBSaJULanV0+By/bt9ki5
	y4IbYPTEg0lY7PPRXiIA7GknKyyAVI6ZWrxhJc2HJtDmMxVAOvlY/tB3qa0/OduCjTdOmKH/mVohv
	rUPW79nrSaCl2lOpXiPx7tU300jA/OOJI3SPVu9Vc/xiATb0z+1A38HA7Y8qv6FVyPuGhUss/7LXD
	2oTmWj5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgSOA-006IRc-2j;
	Wed, 13 Sep 2023 16:06:50 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgSO7-006IQp-2s
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 16:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694621207; x=1726157207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EGfEOxdAYf5EgE3oBsesna+TMXHSoZpHq3Y5tKMSCQE=;
  b=ay5zoZ2IthH5qeM82oPnMmdRGHcopNaxajqprryqXbf2kr5SzM+/XkTZ
   35URMkrGERBd6X+BemhIaWNmNQif0jAlsQcy9isG3UQkWOxVOgZ6Wwu4V
   HB+LFSnTDFY3v6Vjrd4LVpWrnMusC9ctLmcM3hv3LPRK//+/xNzk3xCUQ
   2wOazM3INIq+Wo0PbocIrziWMpxPEeyc+iBfuBiEIZRUdGivF4QuFK0l9
   xOdjtbkdLPT72KdP7a6QFhRoaRjsQRhAGYCNFEcrtPKQnD3rCEzhoeAqB
   fjbrVZvm2uT06cqcsIm8XnAPtUuRO71SUIpYoylw7CdocAQsK0n+GcxJn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378616290"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378616290"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 09:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="917879675"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="917879675"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2023 09:04:24 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgSLl-0000HR-36;
	Wed, 13 Sep 2023 16:04:21 +0000
Date: Thu, 14 Sep 2023 00:03:25 +0800
From: kernel test robot <lkp@intel.com>
To: Ping Gan <jacky_gam_2001@163.com>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, ping_gan@dell.com,
	jacky_gam_2001@163.com
Subject: Re: [PATCH 2/4] nvmet: Add polling queue task for nvme target
Message-ID: <202309132330.9Vr4qPji-lkp@intel.com>
References: <84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_090648_005877_43877C86 
X-CRM114-Status: GOOD (  10.92  )
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
patch link:    https://lore.kernel.org/r/84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001%40163.com
patch subject: [PATCH 2/4] nvmet: Add polling queue task for nvme target
config: x86_64-randconfig-121-20230913 (https://download.01.org/0day-ci/archive/20230913/202309132330.9Vr4qPji-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309132330.9Vr4qPji-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309132330.9Vr4qPji-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/polling-queue-thread.c:72:29: sparse: sparse: symbol 'nvmet_pqt_data' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

