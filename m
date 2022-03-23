Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61218C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sfcWyCkIwg+zACqdMumX7KAu+39bvminaHhG5AUNUR0=; b=EurP40gon6nHbtiwo2bE1BHNCQ
	3MuZG/kkpaZshWQxK50XG6OoWz2GoN3MjTNv9AVDe9C31JbcEKhfzYNtGNh+hf497MbbGYU1u2zTG
	RVRoCikokaawypAWoZhooCqhjKMYDL+RtnKgE4o+5nBaSZEPt1sUcTOyx7MuboPk1sOm4TAuqPTF2
	pscKR83lTBebQh1Hk7jfuydKzq3WkdcU6hfeivgZKMKBAx5LEUfXigiI4jf6eeS0pAAk8I2oQgwM3
	4yB16qSRqE8ECk7DaZoG+rQfA9LBRn298qGCwnfYWFn+vzHilUpR4u8StOfIdj3Y2p4v3GdefPuxa
	F7rflUrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXAkL-00F5kW-Qq; Wed, 23 Mar 2022 23:50:33 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXAkI-00F5jW-6x
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 23:50:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648079430; x=1679615430;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=A6t7g6nFUBEakBsJRGwxGJ/1XhOsHkieF2ErY2Jv++M=;
 b=C3+abRfO46xjrSNsn8RJ/R7DlH5ijCByoLTzMXLt/4nGdcgONcLvx0eI
 g00CmUABV8lXmpf60LGGha1UUzV8WMMNoNvl5aMuWH0CyGsg3Vq52qF+v
 Fx1zxol8xsKOvn/dMQBzJrooZ/vrthPhZOe/HZ2KgHv19JNExcR+UogLX
 53lirwbkMrJO+hfdqp23JIdK9z5Np7TyvVZz30wb9Ywb8gAaO/HEwo5kk
 jEC4Tv+XKtT2SnxI2xvOh6PGZ+cBWxYsRL0yBRkdid03rfQtdqOB20nX+
 s3hmbG0VvPFaHWU7lQCVbrP6+CVMHkeEC5yqpZgDSUEySKlKP/gVlTUgl A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="238853293"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; d="scan'208";a="238853293"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2022 16:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; d="scan'208";a="501191203"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga003.jf.intel.com with ESMTP; 23 Mar 2022 16:50:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nXAkE-000KU1-GT; Wed, 23 Mar 2022 23:50:26 +0000
Date: Thu, 24 Mar 2022 07:49:26 +0800
From: kernel test robot <lkp@intel.com>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [linux-nvme:nvme-5.18 6/6] drivers/nvme/host/nvme.h:858: multiple
 definition of `nvme_mpath_update';
 drivers/nvme/host/core.o:drivers/nvme/host/nvme.h:858: first defined here
Message-ID: <202203240715.lM0ACDqk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_165030_294563_DC523F1E 
X-CRM114-Status: GOOD (  12.54  )
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

tree:   git://git.infradead.org/nvme.git nvme-5.18
head:   d50c992edf10b95d2034097405c94fecfbe1ef7f
commit: d50c992edf10b95d2034097405c94fecfbe1ef7f [6/6] nvme-multipath: fix hang when disk goes live over reconnect
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220324/202203240715.lM0ACDqk-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-5.18
        git checkout d50c992edf10b95d2034097405c94fecfbe1ef7f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   ld: drivers/nvme/host/ioctl.o: in function `nvme_mpath_update':
>> drivers/nvme/host/nvme.h:858: multiple definition of `nvme_mpath_update'; drivers/nvme/host/core.o:drivers/nvme/host/nvme.h:858: first defined here
   ld: drivers/nvme/host/constants.o: in function `nvme_mpath_update':
>> drivers/nvme/host/nvme.h:858: multiple definition of `nvme_mpath_update'; drivers/nvme/host/core.o:drivers/nvme/host/nvme.h:858: first defined here
   ld: drivers/nvme/host/trace.o: in function `nvme_mpath_update':
>> drivers/nvme/host/nvme.h:858: multiple definition of `nvme_mpath_update'; drivers/nvme/host/core.o:drivers/nvme/host/nvme.h:858: first defined here
   ld: drivers/nvme/host/fault_inject.o: in function `nvme_mpath_update':
>> drivers/nvme/host/nvme.h:858: multiple definition of `nvme_mpath_update'; drivers/nvme/host/core.o:drivers/nvme/host/nvme.h:858: first defined here
--
   In file included from drivers/nvme/host/core.c:25:
>> drivers/nvme/host/nvme.h:856:6: warning: no previous prototype for 'nvme_mpath_update' [-Wmissing-prototypes]
     856 | void nvme_mpath_update(struct nvme_ctrl *ctrl)
         |      ^~~~~~~~~~~~~~~~~
--
   In file included from drivers/nvme/target/loop.c:13:
>> drivers/nvme/target/../host/nvme.h:856:6: warning: no previous prototype for 'nvme_mpath_update' [-Wmissing-prototypes]
     856 | void nvme_mpath_update(struct nvme_ctrl *ctrl)
         |      ^~~~~~~~~~~~~~~~~


vim +858 drivers/nvme/host/nvme.h

   804	
   805	#else
   806	#define multipath false
   807	static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
   808	{
   809		return false;
   810	}
   811	static inline void nvme_failover_req(struct request *req)
   812	{
   813	}
   814	static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
   815	{
   816	}
   817	static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
   818			struct nvme_ns_head *head)
   819	{
   820		return 0;
   821	}
   822	static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
   823			struct nvme_id_ns *id)
   824	{
   825	}
   826	static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
   827	{
   828	}
   829	static inline bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
   830	{
   831		return false;
   832	}
   833	static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
   834	{
   835	}
   836	static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
   837	{
   838	}
   839	static inline void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
   840	{
   841	}
   842	static inline void nvme_trace_bio_complete(struct request *req)
   843	{
   844	}
   845	static inline void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
   846	{
   847	}
   848	static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
   849			struct nvme_id_ctrl *id)
   850	{
   851		if (ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA)
   852			dev_warn(ctrl->device,
   853	"Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
   854		return 0;
   855	}
 > 856	void nvme_mpath_update(struct nvme_ctrl *ctrl)
   857	{
 > 858	}
   859	static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
   860	{
   861	}
   862	static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
   863	{
   864	}
   865	static inline void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
   866	{
   867	}
   868	static inline void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
   869	{
   870	}
   871	static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
   872	{
   873	}
   874	static inline void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
   875	{
   876	}
   877	#endif /* CONFIG_NVME_MULTIPATH */
   878	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

