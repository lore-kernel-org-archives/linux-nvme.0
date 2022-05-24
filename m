Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149B6C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 02:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ut8uxf9ivUvt/gLa6rp7oBYs/RHXKPvWhsUI2PbZo8Q=; b=FsGK+mf93h4cc8VYNgj+AZPXJH
	rUP/PGid5rAMBwaR98Rl4jvQkZ4do5hCErLRRQfJUUK9rZBB92VBu4woOKV5AunDjB+hxHHWgb9yW
	RS33vLM07GvYK4fACKCx3w0yAQpUvrcI2/1WdXPFwbL+BsLwe3mJ9c+WGpoJs1dtH9//kWuaaYtcJ
	fHs0TIb39WNcL4ARZGhaXJSSUHXA2Ax/XFvtIhjnJ4+PW0NKZ+zruRMio9yKYEY1dKujMFAY3xPO7
	Ukf0Iu4LtXVeKeamvZJ96T89ip8omiLjkPAELNggKy/cVj5EnbOBk+Ldtp5lWidG6295G20Ce+IHK
	7j2KKA9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntKTu-006azC-2i; Tue, 24 May 2022 02:41:10 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntKTp-006ayT-WD
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 02:41:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653360065; x=1684896065;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lTs7Zyfz3kf22iAirsP5H5EozMNgDf/N+TMetMeGLo0=;
 b=UFjuzKb/aKhwQ3VKq6zh1Iar/YXZsMZeyjklpQTI5lRimnNhAHNIuTnU
 pY/DQHYk0t3VJdwsp1TfPdI3iFrhHrqV9bzuncW6HQ5ix4lE4xMPo4AM0
 W1mRDf8ifp+bajUmdtTP5A4xUh+iSO8oGNlVMfvpF8bGkJyK62p5gT4IC
 RRy2jgZw8Ru77b8bKRN7Q9M58Q1BIAcB9QeLgMDx+Z+tNLUHt8qy+3Q7D
 F0J3xtFXDbjcrId/22ocObLZ6tLgyjwKKUXRs0oB4wR/IqrCRr6uuxYhy
 Ky+dFbtfn+FXwuJpf/E5NI9BfrCiABGuBgVu/3L8JAjge7+vmIQF/IIQj g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273525886"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; d="scan'208";a="273525886"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 19:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; d="scan'208";a="629681386"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 23 May 2022 19:40:59 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1ntKTi-0001eu-Jk;
 Tue, 24 May 2022 02:40:58 +0000
Date: Tue, 24 May 2022 10:40:50 +0800
From: kernel test robot <lkp@intel.com>
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk, hch@lst.de,
 snitzer@redhat.com, damien.lemoal@opensource.wdc.com, hare@suse.de,
 Johannes.Thumshirn@wdc.com
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org,
 linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 dsterba@suse.com, jiangbo.365@bytedance.com,
 linux-kernel@vger.kernel.org, gost.dev@samsung.com,
 linux-block@vger.kernel.org, jaegeuk@kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 5/7] null_blk: allow non power of 2 zoned devices
Message-ID: <202205241034.izkLMTcH-lkp@intel.com>
References: <20220523161601.58078-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523161601.58078-6-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_194106_092400_B2151C2D 
X-CRM114-Status: GOOD (  10.51  )
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

Hi Pankaj,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on device-mapper-dm/for-next linus/master hch-configfs/for-next v5.18 next-20220523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220524-011616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: hexagon-randconfig-r045-20220523 (https://download.01.org/0day-ci/archive/20220524/202205241034.izkLMTcH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3d3c81da0adbd40eb0d2125327b7e227582b2a37
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220524-011616
        git checkout 3d3c81da0adbd40eb0d2125327b7e227582b2a37
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__hexagon_umoddi3" [drivers/block/null_blk/null_blk.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

