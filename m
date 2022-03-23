Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E381C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 23:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qKY/jprfKQE50v/XoScsfmFhtBmTiu0OwwFGlV69ta0=; b=bKrOYphmW4+n+qrPh66Zpd6swj
	PAjFqjkhF0S0LooU4qP/iv9gawFX2FW28G0As9hRyXleKM6ckRYXnmkf1I6GtQSjFwKrC2XjVIpfv
	D/jkTMy8FVSpYJS9SebOjSOFIfQ/HOs1TzITJC4ZrCgGlWuJAGnAZ1ZRe81QLu8rT6K4BYoWxrWxf
	9VwvpNo9rEsAGM2EJpDdSFfd+yd5/bzARPtb1O59jVm7GyVtCASTfTcTokmym17cmXtEwmzebLD4s
	adYbOj3eyWuSjtQKkZX/6iCf814Ifetn0JvpT91rINJafranyZJnRfNi7kpRL/hDmAcgNIwmHmK2D
	1dNjOLcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXAPy-00F2dJ-9N; Wed, 23 Mar 2022 23:29:30 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXAPu-00F2cy-KT
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 23:29:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648078166; x=1679614166;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=EOUR+MT2gMttY41QFuYZK8pIYgSC1+J2rDxc/1jWpdU=;
 b=hT2vFrSk/Pl0LwMQs9enuTisueL3PQA+0cJbV9Pe/NhBk8H9GpSpmeOw
 PuXTw++HTzNDr6Xo291fXysK+2SzpW4g4gSMfKPuZmY40vSU8w6YSJCBO
 kAmwYCa0NpSYW3aPzHk3imFubjS3NWkGy4gDCnqCFZ+lKJl3YEzj4HYHT
 agMUn9lbCNnJW/nTz26zRUzPzrdFtSAnCbH54+ZuSInVdq0h1h2eeUs92
 OmWH+N+M1kHfrAJxuamaoWB3LFJXAV/qoCXCOKEwGigkloxrnwwMGils3
 txOB/FxxtqMOztfIZpWqxZv04gtRTrUAcH7NCnJSKj9fJ7ALvbJt/Kq+h Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="283102167"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; d="scan'208";a="283102167"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2022 16:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; d="scan'208";a="649641847"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 23 Mar 2022 16:29:21 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nXAPp-000KTS-0p; Wed, 23 Mar 2022 23:29:21 +0000
Date: Thu, 24 Mar 2022 07:28:55 +0800
From: kernel test robot <lkp@intel.com>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [linux-nvme:nvme-5.18 6/6] ioctl.c:(.text+0xc2c): multiple
 definition of `nvme_mpath_update'; drivers/nvme/host/core.o:(.text+0x7a1c):
 first defined here
Message-ID: <202203240704.Udc8etzD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_162926_715997_7906B89F 
X-CRM114-Status: GOOD (  11.58  )
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
config: nios2-randconfig-r005-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240704.Udc8etzD-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-5.18
        git checkout d50c992edf10b95d2034097405c94fecfbe1ef7f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/core.c:25:
>> drivers/nvme/host/nvme.h:856:6: warning: no previous prototype for 'nvme_mpath_update' [-Wmissing-prototypes]
     856 | void nvme_mpath_update(struct nvme_ctrl *ctrl)
         |      ^~~~~~~~~~~~~~~~~
--
   nios2-linux-ld: drivers/nvme/host/ioctl.o: in function `nvme_mpath_update':
>> ioctl.c:(.text+0xc2c): multiple definition of `nvme_mpath_update'; drivers/nvme/host/core.o:(.text+0x7a1c): first defined here
   nios2-linux-ld: drivers/nvme/host/constants.o: in function `nvme_mpath_update':
   constants.c:(.text+0x0): multiple definition of `nvme_mpath_update'; drivers/nvme/host/core.o:(.text+0x7a1c): first defined here
   nios2-linux-ld: drivers/nvme/host/hwmon.o: in function `nvme_mpath_update':
   hwmon.c:(.text+0x3f8): multiple definition of `nvme_mpath_update'; drivers/nvme/host/core.o:(.text+0x7a1c): first defined here
--
   In file included from drivers/nvme/target/loop.c:13:
>> drivers/nvme/target/../host/nvme.h:856:6: warning: no previous prototype for 'nvme_mpath_update' [-Wmissing-prototypes]
     856 | void nvme_mpath_update(struct nvme_ctrl *ctrl)
         |      ^~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

