Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C056EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0BcuSWVKGwxQX5sO4/8oBQsGuMHI7tRarDcbR+sCQcE=; b=L1YT7yaxU7DMqAuxYKYm7Mc4yG
	z5Lm1QD9VukGl56DetogyLqRR01DDb+QTLPI+NBTFpmZtq6HZ3fnGHGxBFSvWeKVSLOqs4H8h+ph1
	v/DlDlyQW7ipuJ+I67uTk2Zf8lpp9G8d5JVJF1K26VmLbQ57UF5hgNLy0X7SCkOd6uykVWqaPAt3Z
	t67lzsFk3rf7i04ayXSA5IzzarVYhptU3s73k2cJTQ2mk+cI2we+EyfsjR1V4xCeJEfTbiuS148Be
	knQUSPm+CQKM0A9oSkTDRNj2mV3zv5MxEOeg3H1XVt5vVMIRZqMh8cf1Hy0qdhSgwebwM1gISC+9J
	SLbOggmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKOAu-007xzL-Ib; Wed, 16 Feb 2022 17:33:08 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKOAq-007xyR-W1
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 17:33:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645032784; x=1676568784;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Tp796F2JoFURxdX0IZ0PFFI34QtX8HFQm+Ho15A8Dqg=;
 b=Qv8oua8WE4Aa9gPeuJ46d5TqANvwW+oLtF3nPYo/237AjSZbIYoJ+eBL
 ivxeNTlIArjGTSpP5B0kVm2ggOJ2eF5pIy905q7jvPfbRQ/3/d/+CLNQY
 zlwOFSdDb68aP8B3NFSSwhou/1JwTSfkaC2+7ok+dz1Ucb79JsIgOOJNp
 APIC8dw3hKl4pX4QZfoTu43PIaT5IT2TVaeHnonasaZ3j1O7hhvZzvBGE
 Rud4KfdEJN1oHkJa9kRq1pZl76igMXef46sBTCANljA2thTtrNbx5MLGR
 dWW2YBvPAP/OnlWNglCkFMesWxeYo+JF9Kp7rOaEKpdH9IABth+yxDUkO Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="234213184"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; d="scan'208";a="234213184"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2022 09:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; d="scan'208";a="636618932"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 16 Feb 2022 09:32:45 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nKOAX-000Azi-4C; Wed, 16 Feb 2022 17:32:45 +0000
Date: Thu, 17 Feb 2022 01:31:58 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: kbuild-all@lists.01.org, kbusch@kernel.org,
 markus.bloechl@ipetronik.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Message-ID: <202202170106.0gjJs3bN-lkp@intel.com>
References: <20220216150901.4166235-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216150901.4166235-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_093305_115018_9D43878E 
X-CRM114-Status: GOOD (  14.74  )
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

Hi Christoph,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on ceph-client/for-linus xen-tip/linux-next device-mapper-dm/for-next linus/master v5.17-rc4 next-20220216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christoph-Hellwig/block-fix-surprise-removal-for-drivers-calling-blk_set_queue_dying/20220216-231057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: nds32-allnoconfig (https://download.01.org/0day-ci/archive/20220217/202202170106.0gjJs3bN-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/97d6b5e4c96fcbf1dc26120c918dd1baca987188
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christoph-Hellwig/block-fix-surprise-removal-for-drivers-calling-blk_set_queue_dying/20220216-231057
        git checkout 97d6b5e4c96fcbf1dc26120c918dd1baca987188
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/blk-core.c:296: warning: expecting prototype for blk_set_disk_dead(). Prototype was for blk_mark_disk_dead() instead


vim +296 block/blk-core.c

8e141f9eb803e20 Christoph Hellwig 2021-09-29  287  
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  288  /**
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  289   * blk_set_disk_dead - mark a disk as dead
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  290   * @disk: disk to mark as dead
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  291   *
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  292   * Mark as disk as dead (e.g. surprise removed) and don't accept any new I/O
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  293   * to this disk.
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  294   */
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  295  void blk_mark_disk_dead(struct gendisk *disk)
8e141f9eb803e20 Christoph Hellwig 2021-09-29 @296  {
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  297  	set_bit(GD_DEAD, &disk->state);
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  298  	blk_queue_start_drain(disk->queue);
8e141f9eb803e20 Christoph Hellwig 2021-09-29  299  }
97d6b5e4c96fcbf Christoph Hellwig 2022-02-16  300  EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
aed3ea94bdd2ac0 Jens Axboe        2014-12-22  301  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

