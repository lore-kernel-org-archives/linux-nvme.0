Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBEAC36018
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=baVKLeM7WHBLlQh+WgHqVI3rFznl0sitR4T0Nxcrdc4=; b=uk3ualGfjqgFH7qwlJm4lof91P
	wlP9WNhubN5R7juxguDVwsCh2eZM8xrFR+F+0+3TyUJqIrx4wUqdpdSlPdboiwnOgDYku9IYlsrYX
	mX+bAio+u8Whum7bQZ6tnz/aCB+oKB7rp42XwEuEW9KbiO0KK9iSjM3f/zzT9UIVHfZXDqs6B53hZ
	2bwPsfLssNwBtbiY0Ky3PFHqobk9fupxS3xJtHoZVdNkUorIAg2vvBa3AF86UYVx66rnc1f3t+b5D
	qVKqHbUrNEGHGSfIu1flGA4RXDhI8H0SHmvXz39NKU0kZwkpH/3ClD8jGk5QBJIR/b50ZgkUEo530
	hPnl8+Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1rZa-00000001f7n-00yM;
	Mon, 07 Apr 2025 18:51:54 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1qMK-00000001Nhl-3oyo
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 17:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744047249; x=1775583249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wwJBiJeKkSPe6kcf4zOW6RqX05gQTd0yHo0lgGGty/s=;
  b=nfjajgKqM17jsxSZtF+RYPmzEeY6LQK5x9Caq+v4Fzt12sv8kNj80aZj
   Jfds6m0rW5Y8uq0uwVih/ii7qtomyPcFzh3fsytja+hE+NJ5DXrba15Jc
   HooKZo/l9vgpNAb/tAjEyFi2fpBtoT7Y1vKIoFKQ8OhD94gd76O0mg8b0
   LvpXcjZMTSf6BD0JJ//ngdZ7tik6732kOpe8Ni/lw2pO+GkC4yco4xEy8
   UTBUxQMEtt3Wt0xbalDszyCWuj4rLOAFN0cu8sohQKv1JRilQpALUSWCM
   BcM992P3rRD2lkquaytiRBX5ixvwwy1+5C+Iwpqo5wlgU1zQjyEZswC94
   w==;
X-CSE-ConnectionGUID: 4rhuz4aCQHirY2bRpxb0QA==
X-CSE-MsgGUID: /I9GfvYVTha6Rt6TmXmZDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="48158726"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="48158726"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 10:34:08 -0700
X-CSE-ConnectionGUID: H031O1ksQHmNW5uZ5M7Kcw==
X-CSE-MsgGUID: ftI/Cg1sSWy8xCyT3BwvIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="133223000"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Apr 2025 10:34:07 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1qMF-0003el-2z;
	Mon, 07 Apr 2025 17:34:03 +0000
Date: Tue, 8 Apr 2025 01:33:16 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [linux-nvme:nvme-6.15 3/4] drivers/nvme/host/core.c:4302:5: warning:
 'CONFIG_NVME_MULTIPATH' is not defined, evaluates to 0
Message-ID: <202504080139.KuphZ8ZZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_103408_962889_ACD7E504 
X-CRM114-Status: GOOD (  15.98  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.15
head:   9e270930d683ff0207fed7f303988a7ad63ddfcb
commit: a98aa32696a1a19814a2f97853400b28622c6a8f [3/4] nvme: re-read ANA log page after ns scan completes
config: riscv-randconfig-002-20250408 (https://download.01.org/0day-ci/archive/20250408/202504080139.KuphZ8ZZ-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 92c93f5286b9ff33f27ff694d2dc33da1c07afdd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250408/202504080139.KuphZ8ZZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504080139.KuphZ8ZZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/core.c:4302:5: warning: 'CONFIG_NVME_MULTIPATH' is not defined, evaluates to 0 [-Wundef]
    4302 | #if CONFIG_NVME_MULTIPATH
         |     ^
   1 warning generated.


vim +/CONFIG_NVME_MULTIPATH +4302 drivers/nvme/host/core.c

  4254	
  4255	static void nvme_scan_work(struct work_struct *work)
  4256	{
  4257		struct nvme_ctrl *ctrl =
  4258			container_of(work, struct nvme_ctrl, scan_work);
  4259		int ret;
  4260	
  4261		/* No tagset on a live ctrl means IO queues could not created */
  4262		if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE || !ctrl->tagset)
  4263			return;
  4264	
  4265		/*
  4266		 * Identify controller limits can change at controller reset due to
  4267		 * new firmware download, even though it is not common we cannot ignore
  4268		 * such scenario. Controller's non-mdts limits are reported in the unit
  4269		 * of logical blocks that is dependent on the format of attached
  4270		 * namespace. Hence re-read the limits at the time of ns allocation.
  4271		 */
  4272		ret = nvme_init_non_mdts_limits(ctrl);
  4273		if (ret < 0) {
  4274			dev_warn(ctrl->device,
  4275				"reading non-mdts-limits failed: %d\n", ret);
  4276			return;
  4277		}
  4278	
  4279		if (test_and_clear_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
  4280			dev_info(ctrl->device, "rescanning namespaces.\n");
  4281			nvme_clear_changed_ns_log(ctrl);
  4282		}
  4283	
  4284		mutex_lock(&ctrl->scan_lock);
  4285		if (!nvme_id_cns_ok(ctrl, NVME_ID_CNS_NS_ACTIVE_LIST)) {
  4286			nvme_scan_ns_sequential(ctrl);
  4287		} else {
  4288			/*
  4289			 * Fall back to sequential scan if DNR is set to handle broken
  4290			 * devices which should support Identify NS List (as per the VS
  4291			 * they report) but don't actually support it.
  4292			 */
  4293			ret = nvme_scan_ns_list(ctrl);
  4294			if (ret > 0 && ret & NVME_STATUS_DNR)
  4295				nvme_scan_ns_sequential(ctrl);
  4296		}
  4297		mutex_unlock(&ctrl->scan_lock);
  4298	
  4299		/* Requeue if we have missed AENs */
  4300		if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
  4301			nvme_queue_scan(ctrl);
> 4302	#if CONFIG_NVME_MULTIPATH
  4303		else
  4304			/* Re-read the ANA log page to not miss updates */
  4305			queue_work(nvme_wq, &ctrl->ana_work);
  4306	#endif
  4307	}
  4308	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

