Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E42C76195
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Mar 2023 02:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4lMEz8cHdD/yETbVgBUq0OmAARIaYRWGS5d2QodgBew=; b=R3/klvEiu544pXSH124uFh/6Jm
	j/VftTQ6NgYQ2QyvR24/47lS+oqrHfw9pG+AL8Cy7iOplHzkzwBqJJA9b6My869v9mthydjSc+/xU
	VdoYCqBHGvSqG0QnnEInNAPtrmRbYFDlMMyc9dmRnbpzZ/GFnOuJCAmD2Z2EEw/vaHvJFDNqNm7kq
	8r7iR+z9gX+AFszuvQfUbjZCTtE2sBigVkrP6gav/aSGIbmdEDx4efK8c6++yaRzNEd8hktdezOdD
	7gEXXPDlz91Rim38miVeIfHFIelauWF28QfVjVXZ1nsGIW6gjKVJ/oyxvbE3lij0EyFMJdnO5Z3JT
	YmPFazvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pftzZ-0060H4-0k;
	Sat, 25 Mar 2023 02:50:53 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pftzW-0060GA-2M
	for linux-nvme@lists.infradead.org;
	Sat, 25 Mar 2023 02:50:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679712650; x=1711248650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3zS3aSvOZAiP4KYujSTqHqth8DjUD9bjRP9v3MOj3Bw=;
  b=C8k7JYsYVP7N+gFTAVM5gTQtQOIVFcWaSb2YS1dbtHvyX3Tml+OReeg1
   MkFCjiOEU7DF7OyQcZ7gcTBllBiM4wYVeVUrxDQOmKD13WuiHWgaTSONF
   YrJlbxyo22/20oG4gexGVi1bSdoTnojtdUNEVVg2YETy2uuqDCB0gR2eI
   P5Ln2c5FbsibwRFTnrCU/oo6ltVPaHrWHsdpNd85c8vKpiag5a97gIvDu
   5p+6jtGPeJG4a+G1bzLLN4K5cHLWb2OLd1vZF7Rakk4lm36fSmu0SzDPw
   LbC35cQnAw9Snh/EGGU4qUCAZEB9+iatyytFRlYSaGOlDrtldR3JEB/Tn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="341498266"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="341498266"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 19:50:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="1012492338"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="1012492338"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2023 19:50:44 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pftzP-000FtD-2t;
	Sat, 25 Mar 2023 02:50:43 +0000
Date: Sat, 25 Mar 2023 10:50:12 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <202303251022.c5FPQHwt-lkp@intel.com>
References: <20230324212803.1837554-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324212803.1837554-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_195050_830877_7DA3D41D 
X-CRM114-Status: GOOD (  11.08  )
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

Hi Keith,

I love your patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[cannot apply to linus/master v6.3-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/nvme-use-blk-mq-polling-for-uring-commands/20230325-052914
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230324212803.1837554-2-kbusch%40meta.com
patch subject: [PATCH 2/2] nvme: use blk-mq polling for uring commands
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230325/202303251022.c5FPQHwt-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/62483898b54af99f656f5a16a65ff26940b817a8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Keith-Busch/nvme-use-blk-mq-polling-for-uring-commands/20230325-052914
        git checkout 62483898b54af99f656f5a16a65ff26940b817a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303251022.c5FPQHwt-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "blk_queue_exit" [drivers/nvme/host/nvme-core.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

