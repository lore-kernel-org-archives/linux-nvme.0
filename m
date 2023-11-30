Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4895DC4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 04:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w0KOADUH9NZnEK+ld4BG3lgSQ9rCRftE4mWtys2c7gk=; b=GBX9pGegxx/tx0Jn6J1qWOBWjc
	nupsPQbnz8B4mUxXCJ1xQY0X0ySARCmybwpVEG6vx8bhF7lp3KH4w79KlFVxDjFr3u5Im1tgQqK7D
	/J1Q4Zvmwt63N2NQDCNHsEw9HupQhD+1BIVDKlS8mtNMgbUHzrsWX2fd9ZtUUD5oWkyaR0/MPE8hF
	mGR3RJ7wy7Zf6oyr0nelDS5MQYtUdmmYKDdFRcGeIY59kWDhvApr2YexfO6yz9oK7+kNFBzAw9a6Q
	IKl4ogS5kzgA4c2+uBrhdwdgV9imjtbAheJYxWIhscQc8RtygLCkTh4PS6/oG4Y2oKzL+fWLr5+rD
	76SAYotg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8YGh-009skt-2L;
	Thu, 30 Nov 2023 04:03:15 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8YGe-009sj7-2Y
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 04:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701316992; x=1732852992;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lv3eW2TOZ55jN7KZ/f4TbMkgEF+ITNbNvPTU0G0/IEs=;
  b=BjFLOAkpO8YuumXsQ6SAFNJlD1DI846uPXf0HpaDy/1pje9zO/LpulCv
   bKidR7lXbu5IpD82eC+Irynz3dkCX8RsulusY+rH9+C6oOWZb5pAS4CgD
   rrFfTixkB+N95sCLr95x1IvUAVRTVht7mIbYqJrxrFuuGkzNTX6KS9hWY
   Xz3f7l2BUU4+V3+9Gm5aXUREAR9cTyK2OhwDkGnzSJ0QgCAFiIaF/czTJ
   2Vm6i4C7mOIAVH7FUlWJMxDeR06b5ahsUghmRZJk3fxoNQcOQX3yTUiFV
   wsERnZF3sxplfs+CAqbzDOETFHkjoF8OSddJEB/ZGVoZCOIzfjW4Sz+NQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="393009067"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="393009067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 20:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="913063269"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="913063269"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2023 20:03:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8YGW-0001Jw-0m;
	Thu, 30 Nov 2023 04:03:04 +0000
Date: Thu, 30 Nov 2023 12:02:54 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: [linux-nvme:nvme-6.7 5/6] drivers/nvme/host/rdma.c:987:47: error:
 incompatible pointer types passing 'struct nvme_rdma_ctrl *' to parameter of
 type 'struct nvme_ctrl *'
Message-ID: <202311301141.jPWaYfLH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_200312_851157_DDBF8780 
X-CRM114-Status: GOOD (  11.61  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.7
head:   b6cbe703db447a22f70caa0ee9cf616ac26cdc37
commit: 822d50c036c6af2e6a42b45b2e63cb02d6233c2b [5/6] nvme: ensure reset state check ordering
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231130/202311301141.jPWaYfLH-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311301141.jPWaYfLH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311301141.jPWaYfLH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/host/rdma.c:987:47: error: incompatible pointer types passing 'struct nvme_rdma_ctrl *' to parameter of type 'struct nvme_ctrl *' [-Werror,-Wincompatible-pointer-types]
           enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
                                                        ^~~~
   drivers/nvme/host/nvme.h:390:70: note: passing argument to parameter 'ctrl' here
   static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
                                                                        ^
   drivers/nvme/host/rdma.c:1063:48: error: incompatible pointer types passing 'struct nvme_rdma_ctrl *' to parameter of type 'struct nvme_ctrl *' [-Werror,-Wincompatible-pointer-types]
                   enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
                                                                ^~~~
   drivers/nvme/host/nvme.h:390:70: note: passing argument to parameter 'ctrl' here
   static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
                                                                        ^
   drivers/nvme/host/rdma.c:1135:48: error: incompatible pointer types passing 'struct nvme_rdma_ctrl *' to parameter of type 'struct nvme_ctrl *' [-Werror,-Wincompatible-pointer-types]
                   enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
                                                                ^~~~
   drivers/nvme/host/nvme.h:390:70: note: passing argument to parameter 'ctrl' here
   static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
                                                                        ^
   drivers/nvme/host/rdma.c:1170:22: error: incompatible pointer types passing 'struct nvme_rdma_ctrl *' to parameter of type 'struct nvme_ctrl *' [-Werror,-Wincompatible-pointer-types]
           if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
                               ^~~~
   drivers/nvme/host/nvme.h:390:70: note: passing argument to parameter 'ctrl' here
   static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
                                                                        ^
   drivers/nvme/host/rdma.c:1953:22: error: incompatible pointer types passing 'struct nvme_rdma_ctrl *' to parameter of type 'struct nvme_ctrl *' [-Werror,-Wincompatible-pointer-types]
           if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
                               ^~~~
   drivers/nvme/host/nvme.h:390:70: note: passing argument to parameter 'ctrl' here
   static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
                                                                        ^
   5 errors generated.


vim +987 drivers/nvme/host/rdma.c

   984	
   985	static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
   986	{
 > 987		enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
   988	
   989		/* If we are resetting/deleting then do nothing */
   990		if (state != NVME_CTRL_CONNECTING) {
   991			WARN_ON_ONCE(state == NVME_CTRL_NEW || state == NVME_CTRL_LIVE);
   992			return;
   993		}
   994	
   995		if (nvmf_should_reconnect(&ctrl->ctrl)) {
   996			dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
   997				ctrl->ctrl.opts->reconnect_delay);
   998			queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
   999					ctrl->ctrl.opts->reconnect_delay * HZ);
  1000		} else {
  1001			nvme_delete_ctrl(&ctrl->ctrl);
  1002		}
  1003	}
  1004	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

