Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA317C87FD2
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Aug 2025 23:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UhxSGRO4TdZg/ehbpl9myWVADjcktJtBipSP4OltSuI=; b=qR2308wAhNOlUr44HfB5bZt2m7
	d4zrX9tchVuzRiX3wJfdpdjBCO2tJP9L8IBCoeW6atPZYYRUAm/NA4yI6LK6dw+gv5RN7zTKAt0Qn
	GiFHKqLiKyZ/PMuv7Py6QB1EM0XBwiT730SFUPDkbLOQS0bLV3/UmeH9oL2d6t/F2iMdzrEaFichm
	tdO8VtlGLhljaF0eIi9+zi0/0CQu1pWAjcM4w90LPY76bv5fSbKDLJ7rlzTbRuetJrfcaduvnOiMp
	iNxWtnW4jKCIZwaA7tcwTfAomeOF38sqsu8ZMgRIrbPtHBpeT//NZTjYzKB4x2P3l/H6dfZ+hmfh+
	Vr90MINA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiLOX-00000007xbn-1ZNY;
	Sat, 02 Aug 2025 23:12:05 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiLOR-00000007xbT-0ZQX
	for linux-nvme@lists.infradead.org;
	Sat, 02 Aug 2025 23:12:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754176320; x=1785712320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J8kmkc6Y6J6DlHjbF2pMDHETrUO3O1dG6KMFJF1BrhI=;
  b=iAka2TTMIxop60DIKUuqDr33sK25o01qCA772icHfJ8jkcvPJgS+85Cg
   +jtx1nwfqxRnFmddLTC0bmnJMijo0taqEHmTTzXnNKWhzx1jQoGv2shC1
   /ch4gPLsXRrMVUWbOTzUo2fKykPgdnkNGL1Bp/XjseopJe/g5O23L47i6
   8BNQ/4ollQ073o27mNelhsOkOGnjPsPOpn4q6NqK5Eia5nKVuR8IgG9Qy
   KVVo+SMVFyYMXhRb9KBFAVq/WgEGeJl29DXvAmTcWZ5AJM2JVUlgPfp/c
   cC9If2jMUUxn169UEWv4Kfvw/++TgxZ8Pq40LLb7GEeDO8u1gG0SNWa2p
   A==;
X-CSE-ConnectionGUID: JOx8LtUfT8SZ1azNvhDcWw==
X-CSE-MsgGUID: E/mHKPQGRgKSRsTeA5LBtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="67933627"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67933627"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 16:11:56 -0700
X-CSE-ConnectionGUID: wFtY3sCrS1SgLDt3sFAuXg==
X-CSE-MsgGUID: 9e9MmVThTU+KGBsCfkksVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="169155890"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 Aug 2025 16:11:52 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiLOI-0005eG-1c;
	Sat, 02 Aug 2025 23:11:50 +0000
Date: Sun, 3 Aug 2025 07:11:29 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 6/8] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <202508030710.X3P9snty-lkp@intel.com>
References: <20250731150513.220395-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731150513.220395-7-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250802_161159_238507_0A654777 
X-CRM114-Status: GOOD (  11.38  )
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
[also build test ERROR on linus/master next-20250801]
[cannot apply to linux-nvme/for-next hch-configfs/for-next v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/blk-mq-dma-introduce-blk_map_iter/20250731-230719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250731150513.220395-7-kbusch%40meta.com
patch subject: [PATCHv4 6/8] blk-mq-dma: add support for mapping integrity metadata
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250803/202508030710.X3P9snty-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250803/202508030710.X3P9snty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508030710.X3P9snty-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-mq-dma.c:18:27: error: no member named 'bi_integrity' in 'struct bio'
      18 |                 iter->iter = iter->bio->bi_integrity->bip_iter;
         |                              ~~~~~~~~~  ^
   block/blk-mq-dma.c:19:27: error: no member named 'bi_integrity' in 'struct bio'
      19 |                 iter->bvec = iter->bio->bi_integrity->bip_vec;
         |                              ~~~~~~~~~  ^
   2 errors generated.


vim +18 block/blk-mq-dma.c

     8	
     9	static bool __blk_map_iter_next(struct blk_map_iter *iter)
    10	{
    11		if (iter->iter.bi_size)
    12			return true;
    13		if (!iter->bio || !iter->bio->bi_next)
    14			return false;
    15	
    16		iter->bio = iter->bio->bi_next;
    17		if (iter->is_integrity) {
  > 18			iter->iter = iter->bio->bi_integrity->bip_iter;
    19			iter->bvec = iter->bio->bi_integrity->bip_vec;
    20		} else {
    21			iter->iter = iter->bio->bi_iter;
    22			iter->bvec = iter->bio->bi_io_vec;
    23		}
    24		return true;
    25	}
    26	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

