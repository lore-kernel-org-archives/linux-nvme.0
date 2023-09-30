Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5CCE77373
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Sep 2023 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZNNgaKCom4xR/u7GhHclH/TWHpQBpqO4lzM+mq1TPR8=; b=O04Gv7CFCq4FYF5nZbkkU923u8
	xB/5cu7vP4JwaSnIpKejsh3XdJkcLK+HS7dxTw2NgPR7Vagti6oiFhl80FBOYVNUGdAAzH4KINSuz
	i8ETznoDbz9O5oN+dWkX3+BqVNpaF57WqVWGx2WdKP1LE+rAH4UZA5wTEpEnTnQG69bDKmZ4NY0Gs
	QdAZMorOXg7W/R1yZysjdykUZ5vZS/B+DZ5+OmIYGoCzAnXgSP2mOem25Oirhemrd8Szp8Hb82QXt
	LZXjle0BMlfOephthZJkr4gndOrqClBNgHeeqshDvAsBhHMveszkR883GKEJo2yrX8shHwY5HkBf0
	JneE6QkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmaDb-009bgi-29;
	Sat, 30 Sep 2023 13:41:15 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmaDT-009bey-24
	for linux-nvme@lists.infradead.org;
	Sat, 30 Sep 2023 13:41:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696081267; x=1727617267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uLZqwADgpJ9WWjDEC/o1UYcaaGs8VGqI4kgPdR63JWQ=;
  b=gT2vF9Uk1aWdb+Fio2scos+R7ftg7oSfHddMPSr182mXGp2luWXT/egN
   zXPhbjtxlAyFO1DnM4A0TCa68dDaQmyzHn+3iDjxjiA0wXDzXed1yQlOQ
   w1BilNkhlJV9Rk6tucTTj6XA6UForOnvi6T0QEhj2bzDKxnX+ixwggjUn
   P22XTlymBkgs9/++L6FbY5tT2Auk8XbwEeB05WFD8V7A22/LDQ7CHrVdR
   arykqQG2DeSwtr7KIHQI/kWjHKpyF9Kw8S8nNlxtc5UZkDppFBqx6NBGU
   uuF15Y1adxIPGcYiirQOjVX2iPIVadACvWEcc8oCYXqHGVxW3RGv88w8w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="381326003"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="381326003"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 06:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="743695319"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="743695319"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2023 06:40:56 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qmaDG-0004B9-0r;
	Sat, 30 Sep 2023 13:40:54 +0000
Date: Sat, 30 Sep 2023 21:40:30 +0800
From: kernel test robot <lkp@intel.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 09/21] block: Add checks to merging of atomic writes
Message-ID: <202309302100.L6ynQWub-lkp@intel.com>
References: <20230929102726.2985188-10-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-10-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230930_064107_692032_AF12DBC9 
X-CRM114-Status: GOOD (  11.85  )
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

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on xfs-linux/for-next]
[also build test ERROR on axboe-block/for-next mkp-scsi/for-next jejb-scsi/for-next linus/master v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Garry/block-Add-atomic-write-operations-to-request_queue-limits/20230929-184542
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20230929102726.2985188-10-john.g.garry%40oracle.com
patch subject: [PATCH 09/21] block: Add checks to merging of atomic writes
config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20230930/202309302100.L6ynQWub-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309302100.L6ynQWub-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309302100.L6ynQWub-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __moddi3
   >>> referenced by blk-merge.c
   >>>               block/blk-merge.o:(ll_back_merge_fn) in archive vmlinux.a
   >>> referenced by blk-merge.c
   >>>               block/blk-merge.o:(ll_back_merge_fn) in archive vmlinux.a
   >>> referenced by blk-merge.c
   >>>               block/blk-merge.o:(bio_attempt_front_merge) in archive vmlinux.a
   >>> referenced 3 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

