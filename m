Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A29C10F04
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=at5An6UfpWQtTbzVDuKsbTpyyR5t5fhUh7chRvIp0zQ=; b=SfA8KeTsjcwDJrtpugC4IiSn/f
	iUctvQoo6k2nfNXONSC0dythYleUyjemcfnC4Qi0EAblT0WFOb7tM7nR0wkCtkZygk7zAliibAIXG
	irK2klExitLdPhAVqJUj1hSWVxu1cpMP/TMWSaCNHPHDoVojmIHI+8jY+xZuPZ/X1WoSJNYzSMo+z
	syKZKxr3Vx/CoMuzLDtPXgKdEg79rk/O8PFm6fBJgrOjyqW/RfiV1pp8KGI3dPGBxnTUZj4bh8MBU
	Gw0tHGu3V6FphS4GhLncIkDcHgJr7w/ymcG3fKkxwmffQY7HkM2iyaQwoISxODIMPo+iT/KsRiMu5
	NA/C2PhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAvs8-00AwWf-2w;
	Wed, 06 Dec 2023 17:39:44 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAvs5-00AwV0-2R
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 17:39:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701884382; x=1733420382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6qUUe2xtYsDJmk4A2enE0E39kQrqq5EhD6/nWGNeU2c=;
  b=nmPes3llAcPgI+dci/lKo3RyCpL6NHlpUWfrc18EVCR70giE+JGUKb82
   8OgSULc1S3xehGO8+7hPx170dZxlhydIGUgQPFM9Xji/QzFW7+wjzDjaS
   2vQek1mkRGP2eUbh/AOsQXsV8Rxdi3KJo4dYZl62E4Ib+Dknlja1WZVft
   NUrhgpZoNFkUquSNHa6voRqkam0iRiXtF/nZXMGVd5sNaOFoJDUri9GGF
   IOOvB5hi21pkiy4J7tR3g5Uy5LN42GM8sDSUzdxVIBcO24u8KjWmWEKbc
   kP2zTTJ5M3UpIINuT5sZSoMpG48EM8PSRrBXyqfpms+kzYrBjAh+ApURR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1197919"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1197919"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 09:39:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1102910094"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1102910094"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Dec 2023 09:39:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAvr1-000BCg-1Q;
	Wed, 06 Dec 2023 17:38:55 +0000
Date: Thu, 7 Dec 2023 01:38:02 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <202312070119.ThsAOHuk-lkp@intel.com>
References: <20231206081244.32733-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-4-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_093941_808295_9CC5DC03 
X-CRM114-Status: GOOD (  12.83  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7-rc4]
[also build test ERROR on linus/master next-20231206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-lookup-ctrl-from-request-instead-from-namespace/20231206-161455
base:   v6.7-rc4
patch link:    https://lore.kernel.org/r/20231206081244.32733-4-dwagner%40suse.de
patch subject: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
config: i386-buildonly-randconfig-003-20231206 (https://download.01.org/0day-ci/archive/20231207/202312070119.ThsAOHuk-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312070119.ThsAOHuk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312070119.ThsAOHuk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/host/core.c:2034:31: error: incompatible pointer types passing 'struct nvme_ns_head *' to parameter of type 'struct nvme_ns *' [-Werror,-Wincompatible-pointer-types]
                   nvme_mpath_revalidate_paths(ns->head);
                                               ^~~~~~~~
   drivers/nvme/host/nvme.h:945:64: note: passing argument to parameter 'ns' here
   static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
                                                                  ^
   drivers/nvme/host/core.c:2109:31: error: incompatible pointer types passing 'struct nvme_ns_head *' to parameter of type 'struct nvme_ns *' [-Werror,-Wincompatible-pointer-types]
                   nvme_mpath_revalidate_paths(ns->head);
                                               ^~~~~~~~
   drivers/nvme/host/nvme.h:945:64: note: passing argument to parameter 'ns' here
   static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
                                                                  ^
   2 errors generated.


vim +2034 drivers/nvme/host/core.c

  2022	
  2023	static int nvme_update_ns_info_generic(struct nvme_ns *ns,
  2024			struct nvme_ns_info *info)
  2025	{
  2026		blk_mq_freeze_queue(ns->disk->queue);
  2027		nvme_set_queue_limits(ns->ctrl, ns->queue);
  2028		set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
  2029		blk_mq_unfreeze_queue(ns->disk->queue);
  2030	
  2031		if (nvme_ns_head_multipath(ns->head)) {
  2032			blk_mq_freeze_queue(ns->head->disk->queue);
  2033			set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
> 2034			nvme_mpath_revalidate_paths(ns->head);
  2035			blk_stack_limits(&ns->head->disk->queue->limits,
  2036					 &ns->queue->limits, 0);
  2037			ns->head->disk->flags |= GENHD_FL_HIDDEN;
  2038			blk_mq_unfreeze_queue(ns->head->disk->queue);
  2039		}
  2040	
  2041		/* Hide the block-interface for these devices */
  2042		ns->disk->flags |= GENHD_FL_HIDDEN;
  2043		set_bit(NVME_NS_READY, &ns->flags);
  2044	
  2045		return 0;
  2046	}
  2047	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

