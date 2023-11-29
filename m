Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73488C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 02:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mv+hZbnh/u/1QMJo6rijRN+PP9v/nhD8vOBFsqqDLqQ=; b=HUT9lkqWDmHcF3qEzQ74i9lTWw
	ZRWq5LqXnSTFfKvQNXCbUkCkB/UcZZ8wMfFaQJrFl6SygVMokUaZ5TaPoEFKBQDAA3LqxgOVISMz8
	z1VRzJEVzYfrmt90Rotn3ievw3DRw0xnTQGcaJ1gCRCLJviaBS+OtZ+//W/gwp2VL0oo1rzYM7H15
	sXWxmhV8UxvcqEFZbKKaHBabgBLnu2uQLSMZWZ4hFkXbeYhizKSXzasxYA9XINd35ZjFMWJX+R/+U
	X2k7phKoNmNS1rFR0SK+ASYxC83B1mHs6tSyBJGxPb3q/aQO201393qJ489ikP1vkWccSE66eUFjB
	VJYthOzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8AWY-006rLN-3B;
	Wed, 29 Nov 2023 02:42:02 +0000
Received: from mgamail.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8AWW-006rKj-1k
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 02:42:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701225720; x=1732761720;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M2bYCJciScNEPbncnlv6k0be1UDv4lq1fpYG4fNzZjQ=;
  b=d5gXy9ebYUVG+kGmfu4kjFU5nFLxYoBkvXaZPQ+Q3bNXELxYwGzCqOff
   ylpUiDWcyRbRG9dwwEroLEeEn1XljPo6Q4/d8xF/I7zD4e9AP3kKOY6EI
   FNpwWu/Nc1te69EQd8PCaFStvYeTUPDmPBJFGtcWqVs0tar/VMe9s78LU
   cRFMmfZ+8jUsJA70+huiyTJu4yWvwqSF6df/7zzEIgh99zB5BJ3XqvFcn
   0vG8Z9qgV7B5VDC2U3pfhhegscJI8gt+ARKA7tX9BAAs35se8vAjOzPzN
   VXdNsIaGU4TaFMRcZjhde6uhKvwHD8U76Grf6kUrrwpkNTl13tfLwyN+N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="395897433"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="395897433"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 18:41:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="768749609"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="768749609"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2023 18:41:50 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8AWJ-0008SB-2h;
	Wed, 29 Nov 2023 02:41:47 +0000
Date: Wed, 29 Nov 2023 10:38:00 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [linux-nvme:nvme-6.7 5/6] drivers/nvme/host/rdma.c:987:47: error:
 passing argument 1 of 'nvme_ctrl_state' from incompatible pointer type
Message-ID: <202311290724.uhn9SbbS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_184200_654794_659123B1 
X-CRM114-Status: GOOD (  14.55  )
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
config: i386-buildonly-randconfig-002-20231129 (https://download.01.org/0day-ci/archive/20231129/202311290724.uhn9SbbS-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311290724.uhn9SbbS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290724.uhn9SbbS-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/host/rdma.c: In function 'nvme_rdma_reconnect_or_remove':
>> drivers/nvme/host/rdma.c:987:47: error: passing argument 1 of 'nvme_ctrl_state' from incompatible pointer type [-Werror=incompatible-pointer-types]
     enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
                                                  ^~~~
   In file included from drivers/nvme/host/rdma.c:27:0:
   drivers/nvme/host/nvme.h:390:36: note: expected 'struct nvme_ctrl *' but argument is of type 'struct nvme_rdma_ctrl *'
    static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
                                       ^~~~~~~~~~~~~~~
   drivers/nvme/host/rdma.c: In function 'nvme_rdma_setup_ctrl':
   drivers/nvme/host/rdma.c:1063:48: error: passing argument 1 of 'nvme_ctrl_state' from incompatible pointer type [-Werror=incompatible-pointer-types]
      enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
                                                   ^~~~
   In file included from drivers/nvme/host/rdma.c:27:0:
   drivers/nvme/host/nvme.h:390:36: note: expected 'struct nvme_ctrl *' but argument is of type 'struct nvme_rdma_ctrl *'
    static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
                                       ^~~~~~~~~~~~~~~
   drivers/nvme/host/rdma.c: In function 'nvme_rdma_error_recovery_work':
   drivers/nvme/host/rdma.c:1135:48: error: passing argument 1 of 'nvme_ctrl_state' from incompatible pointer type [-Werror=incompatible-pointer-types]
      enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
                                                   ^~~~
   In file included from drivers/nvme/host/rdma.c:27:0:
   drivers/nvme/host/nvme.h:390:36: note: expected 'struct nvme_ctrl *' but argument is of type 'struct nvme_rdma_ctrl *'
    static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
                                       ^~~~~~~~~~~~~~~
   drivers/nvme/host/rdma.c: In function 'nvme_rdma_wr_error':
   drivers/nvme/host/rdma.c:1170:22: error: passing argument 1 of 'nvme_ctrl_state' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
                         ^~~~
   In file included from drivers/nvme/host/rdma.c:27:0:
   drivers/nvme/host/nvme.h:390:36: note: expected 'struct nvme_ctrl *' but argument is of type 'struct nvme_rdma_ctrl *'
    static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
                                       ^~~~~~~~~~~~~~~
   drivers/nvme/host/rdma.c: In function 'nvme_rdma_timeout':
   drivers/nvme/host/rdma.c:1953:22: error: passing argument 1 of 'nvme_ctrl_state' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
                         ^~~~
   In file included from drivers/nvme/host/rdma.c:27:0:
   drivers/nvme/host/nvme.h:390:36: note: expected 'struct nvme_ctrl *' but argument is of type 'struct nvme_rdma_ctrl *'
    static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
                                       ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/nvme_ctrl_state +987 drivers/nvme/host/rdma.c

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

