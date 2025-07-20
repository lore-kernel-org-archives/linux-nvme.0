Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEC1C83F22
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jul 2025 22:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IE1z5wFc7sMp3I0oC7XMuk92StEojXGoS6GVVR0Qx9Y=; b=257Zwxybw4YtQwzCQWOOE+w33x
	Iocv7aooWASrFdHlLgA+TnrTbXdqFE8LV2gpYzrpAmejf60VNEQIHhLknDfl/hxXpMXXhLsakU52W
	WRhg/c9vhlM8hXSBd/5nY/tHwIA8yo/5husE1XAFKPWBz6B4EqLLFatallHBrYhQWTUb77WUU5mw8
	NB8kx9COPm6vRA2Jr0RdAVvBBa/hTrLgWXlInCvj6cSXJw29hyIeehuIvOD4cE99FkFx4bL009V/C
	rRxp24eJWtesEDBZ/Oau/DACTnHQgbsZ5J3rw9KmVvw7hbxzTLGxmxvq5kXmE856JI20K4tHo5oyQ
	aLCQwCpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udct8-0000000Fnmp-219T;
	Sun, 20 Jul 2025 22:52:10 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udct5-0000000Fnlz-0hRZ
	for linux-nvme@lists.infradead.org;
	Sun, 20 Jul 2025 22:52:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753051926; x=1784587926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KccA/LZ+ZXZ6XajYWAUE1auUyN/plqJfyfdq6P7YW1o=;
  b=jQ1atJOy1hXDUYrNDdW5yAEuH6jElCgT0c/XHZhd6PSxNN6B35fclarn
   tED6tyZdLF9iLGeOr9m4sBXrEB9m4FtFJbuTAssGpDwj46v0vOIQtBLQz
   aneSoKAUNkoOhZB1L9fKdXT8HCVAEpOE3x8dUr75x3bXfJa3jE6rWTSED
   xhIzg2TxKYjhxWqS76N34BV+qLNjozINEjpSxDGsR4z3ZveTPD6yjJFx3
   zrILl1gSwJ4THgYxF3glHr7o/W0XQpwlLHpRJboQevQkIKafrzY9G+UYR
   cY0krbPGJyuY1ZGFtobDlNDWmf8GGZEgKALxL1RT3vqk3rkrhqf+gKBka
   Q==;
X-CSE-ConnectionGUID: OWrv+vgpTMGQDnQtHQyQyw==
X-CSE-MsgGUID: FuZ1dPGiRBmOcl8MW0b36w==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="66327329"
X-IronPort-AV: E=Sophos;i="6.16,327,1744095600"; 
   d="scan'208";a="66327329"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 15:52:00 -0700
X-CSE-ConnectionGUID: 7+vZawjzRW+axfKtJ5xYhA==
X-CSE-MsgGUID: Uyth4+W/SeeVPMlU+gBWuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,327,1744095600"; 
   d="scan'208";a="159214763"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Jul 2025 15:51:59 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udcsu-000GLR-2I;
	Sun, 20 Jul 2025 22:51:56 +0000
Date: Mon, 21 Jul 2025 06:51:21 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
	leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <202507210629.vtm1boC0-lkp@intel.com>
References: <20250720184040.2402790-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-7-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_155207_247654_8753197C 
X-CRM114-Status: GOOD (  10.69  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[cannot apply to linux-nvme/for-next hch-configfs/for-next linus/master v6.16-rc6 next-20250718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/blk-mq-dma-move-the-bio-and-bvec_iter-to-blk_dma_iter/20250721-024616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250720184040.2402790-7-kbusch%40meta.com
patch subject: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity metadata
config: um-randconfig-002-20250721 (https://download.01.org/0day-ci/archive/20250721/202507210629.vtm1boC0-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250721/202507210629.vtm1boC0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507210629.vtm1boC0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: blk_rq_integrity_dma_map_iter_start
   >>> defined at dm-table.c
   >>>            drivers/md/dm-table.o:(blk_rq_integrity_dma_map_iter_start)
   >>> defined at dm-io-rewind.c
   >>>            drivers/md/dm-io-rewind.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: blk_rq_integrity_dma_map_iter_next
   >>> defined at dm-table.c
   >>>            drivers/md/dm-table.o:(blk_rq_integrity_dma_map_iter_next)
   >>> defined at dm-io-rewind.c
   >>>            drivers/md/dm-io-rewind.o:(.text+0x13)
--
>> ld.lld: error: duplicate symbol: blk_rq_integrity_dma_map_iter_start
   >>> defined at core.c
   >>>            drivers/nvme/host/core.o:(blk_rq_integrity_dma_map_iter_start)
   >>> defined at ioctl.c
   >>>            drivers/nvme/host/ioctl.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: blk_rq_integrity_dma_map_iter_next
   >>> defined at core.c
   >>>            drivers/nvme/host/core.o:(blk_rq_integrity_dma_map_iter_next)
   >>> defined at ioctl.c
   >>>            drivers/nvme/host/ioctl.o:(.text+0x13)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

