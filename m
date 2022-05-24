Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19DCC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 19:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lDq8NmfPSveCUktQJzp0jtUPzMLoNyj7UOD90uM9Jzw=; b=bs6yPIpKITswxAqP83yL264jSX
	KfUhmcVmGLODBgMphjnyJE+WlcwHWIkIkOiWLb5sIOqH4T+DI+l6Q6lzAz9MkmfGtsDCZ0ICZ3XHN
	MBsB8fqfCaphlEDQUhCPK31F8ltno0kP8gACFn1mSPSuHoIhgJ8+jC5vsZe8V8AxxzXqE5K7sh2GU
	WH9po9sMC08gDRvn+chN1rwlZEEbsJmdFKBpfFA6/h+VbGC/+At+4ojTRWwHmZyr35oenjwqCeNPT
	QxXrFnUjuh8VCW2tll1whNTyoqcgniQi2xF6eo17CeK+aikFAQ/N5/oTfaePCa5ieg7Hyq9pMZp93
	QLBpdN3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntZtA-008ywp-EW; Tue, 24 May 2022 19:08:16 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntZt7-008yvi-KE
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 19:08:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653419293; x=1684955293;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=McrA50umS7uFNif0OKWyvZB3Gg9wX6U3OTSnaLvoS2o=;
 b=juKxr5pAfMlWmV0KtQA791/nj46fR6APcYHE+rfl1z0Y49HSczPQB8Yw
 2DaQg8ZugdOXLTZ3uimxtOifXri3pUaR8yxrA2IdxWCSysBpsiHWQq6fg
 8Ms+sBxf42X0RrN0O9sYQlYSsh0jMwMW9eNmKCK7bn6ToiIaBdAYPq0Br
 THkCSxum4vwp6ys1RqSCXBWEpxhpA8NpjCh2Hf+44XSSPLadncmaJTFVg
 Olbme10tnaAg1PlV4pBPOukOgBxf9Jim9bRQihZgpd58aF6m+e4RKRZiU
 lDZ2IUr3BYPvbMavZJ5gswBrcQuBYZZiYCh3TinuAA4M5y7+mxXlZTdSZ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273741312"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="273741312"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 12:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="630022328"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 24 May 2022 12:08:07 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1ntZt1-0002Mu-5D;
 Tue, 24 May 2022 19:08:07 +0000
Date: Wed, 25 May 2022 03:07:57 +0800
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
Message-ID: <202205250258.tP8p4wdJ-lkp@intel.com>
References: <20220523161601.58078-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523161601.58078-6-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_120813_721721_55AC2FE3 
X-CRM114-Status: GOOD (  11.42  )
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
[also build test ERROR on device-mapper-dm/for-next linus/master hch-configfs/for-next v5.18 next-20220524]
[cannot apply to linux-nvme/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220524-011616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220525/202205250258.tP8p4wdJ-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __umoddi3
   >>> referenced by zoned.c:89 (drivers/block/null_blk/zoned.c:89)
   >>>               block/null_blk/zoned.o:(null_init_zoned_dev) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

