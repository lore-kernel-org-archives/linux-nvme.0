Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C335C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/i5j0JIKU/WeSetkq6A/Up5UoGhxAwBlxfJmWWWn++o=; b=C1oM39KE2AJer8QP1Mk3qqq+A1
	jnHqRM6dr04iP1SVCYMFEV6TjZM2pTZNDN1eIyU9fD4S7H63XoKdcHTZ9zWLX140qJz4yN9t/lw2b
	3/W0uhwLcS/xhw+uYbIhSXzuUdeeKsm0WHar4F4SgJOQo0sb006xb3fIGMISjnOKrBgWJUUgkj8tN
	MqR/lcMcs1n+up/Ku7sOK2eXSrET80y2tI78cDIYiNjE4P8W5FMs1JacVBjO2v4rZvpJtFxpkyiTY
	Ld3lMNyQqccds5sHbe4UFtN1cn/5mwfjUjDeMVKKv0IH8ue/2twz8bpfuHkX8RaKMcYe4OuKBd6KI
	QNbJNT/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAvsB-00AwXK-1G;
	Wed, 06 Dec 2023 17:39:47 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAvs7-00AwV0-1N
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 17:39:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701884383; x=1733420383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ra06s2wat/gRp2NTt+vmqIMOkgGactMT0z9RIX4ie/8=;
  b=Zjt7Qtl1cwVMeP2HrhPA5SyelhsBr+CQOoLW4nixuoQAbkVXy7w8BV89
   NyxpSE0PZOgFLGGZ9PHTF+EX/ZaEUajnbbb6VQhS8tV3SkdWm8ebWGx5S
   P0iIIvGVKlZw5UlaHZHONy2mBwyHAIOPey4SC+++F9ausCXObkP9Sb05t
   zwTB9zwfvwE9dzOp2p/mMrxgmANrW+kDI7p/08Tx21bieyDQCfbOyKS/5
   lpRm8l6WWuCCcgU4f5qbbhfTl65x07pSBsCIDnceujOX1t2RxrUkjWxiu
   MCk6Qayo9PENuQP7KwymgPUpdeaPz9d4QARbZkIfweVOAaExkFaL2Z8cC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1197926"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1197926"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 09:39:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1102910109"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1102910109"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Dec 2023 09:39:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAvrw-000BCl-0u;
	Wed, 06 Dec 2023 17:39:32 +0000
Date: Thu, 7 Dec 2023 01:38:01 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <202312070134.P5lZMJCN-lkp@intel.com>
References: <20231206081244.32733-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-4-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_093943_484754_3100D07F 
X-CRM114-Status: GOOD (  15.50  )
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231207/202312070134.P5lZMJCN-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312070134.P5lZMJCN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312070134.P5lZMJCN-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/host/core.c: In function 'nvme_update_ns_info_generic':
>> drivers/nvme/host/core.c:2034:47: error: passing argument 1 of 'nvme_mpath_revalidate_paths' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2034 |                 nvme_mpath_revalidate_paths(ns->head);
         |                                             ~~^~~~~~
         |                                               |
         |                                               struct nvme_ns_head *
   In file included from drivers/nvme/host/core.c:25:
   drivers/nvme/host/nvme.h:945:64: note: expected 'struct nvme_ns *' but argument is of type 'struct nvme_ns_head *'
     945 | static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
         |                                                ~~~~~~~~~~~~~~~~^~
   drivers/nvme/host/core.c: In function 'nvme_update_ns_info_block':
   drivers/nvme/host/core.c:2109:47: error: passing argument 1 of 'nvme_mpath_revalidate_paths' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2109 |                 nvme_mpath_revalidate_paths(ns->head);
         |                                             ~~^~~~~~
         |                                               |
         |                                               struct nvme_ns_head *
   drivers/nvme/host/nvme.h:945:64: note: expected 'struct nvme_ns *' but argument is of type 'struct nvme_ns_head *'
     945 | static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
         |                                                ~~~~~~~~~~~~~~~~^~
   cc1: some warnings being treated as errors


vim +/nvme_mpath_revalidate_paths +2034 drivers/nvme/host/core.c

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

