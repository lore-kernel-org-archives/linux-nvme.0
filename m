Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2B7C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 07:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfuThGDGl3pzEhutRq/A5avTd8fO4jRVxYCeL2hGLTI=; b=C+3+/WihJuDaCtOx5yAVdS+wR2
	e9WGP3VrQdKn6tpT+RRymYS36idcRZr407xEr+H+WtHF6IFq3kcgRqUVscvCcJ8S1XfCFDStfnkXm
	F9KLSwcrBCp1/19mFfraUs6PFekvyI3lftzMc9Ui6Wm7EDncVo+RH81kWKUe0g53UjUHGuP0aCO03
	ezqnGz51IpH3bUo7/xMaovReyYxAthgU8Kn+Rcigq/mUzLwmGW1j38+KbYOxof2sbtJyBpQ6DCiiJ
	XvGW46t75tI/MgdhDGDVuzw4OnWqWKGCBf9A7+ZPJmOSBgKLKxH9puJgsqtFabWZOP+AK6BwM/DEA
	ZLeD8vyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5gmw-00000007Qtl-0rLO;
	Sat, 11 May 2024 07:04:58 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5gmt-00000007Qsv-0P0R
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 07:04:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715411095; x=1746947095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yiz0h+TJ4V6Llm1CfE0BJLB5v4VhySio+M1awKypBAA=;
  b=VlfG+pyzz7JJXNCKbTUS3Ef7Q+/tZbfKWflY0xeh+WN7eS0SwcM/7Kv7
   YYoAsutENN4GeOaad4EQQxEJoN6XA5rdeXu7fchxz5R9nCC2ImiG3PMi7
   XEZ2vTrfNIw5EzigiVW8E/2whMl2dC+7hK/8IEtAdrU0iUxvkK0KJgfFf
   0PAJKC475fuoH4DKx0NO3EOu8I8UZatTEH5stywK5/rtM5I7GdhhbHoKD
   Pr2CKu/F/6QJNVIqazfIb4cbYc9D6WrVuiQzUtBu2o2vWuWBZthkFzTCr
   a5Cilet8vZvUDfxFuvph1plerStwSUp7p+J0beYa/03/0NjIztyvmQMJf
   Q==;
X-CSE-ConnectionGUID: el8EETzfTu6L6WjFPxfd0A==
X-CSE-MsgGUID: N3N1bBuJQS+GQpJIMcU+Ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="28925812"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="28925812"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 00:04:54 -0700
X-CSE-ConnectionGUID: yOylc/n3QNSnm1GO/I4eZg==
X-CSE-MsgGUID: pnGRZh0IQk6cjN4ddyq4KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="29958479"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 May 2024 00:04:52 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5gmn-00073X-0n;
	Sat, 11 May 2024 07:04:49 +0000
Date: Sat, 11 May 2024 15:04:38 +0800
From: kernel test robot <lkp@intel.com>
To: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/5] block/bdev: enable large folio support for large
 logical block sizes
Message-ID: <202405111438.WaVytRae-lkp@intel.com>
References: <20240510102906.51844-5-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-5-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240511_000455_175292_9865F4CF 
X-CRM114-Status: GOOD (  11.62  )
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

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.9-rc7]
[cannot apply to next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hare-kernel-org/fs-mpage-use-blocks_per_folio-instead-of-blocks_per_page/20240510-183146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240510102906.51844-5-hare%40kernel.org
patch subject: [PATCH 4/5] block/bdev: enable large folio support for large logical block sizes
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240511/202405111438.WaVytRae-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405111438.WaVytRae-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405111438.WaVytRae-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/bdev.c:145:2: error: call to undeclared function 'mapping_set_folio_min_order'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     145 |         mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
         |         ^
   block/bdev.c:163:3: error: call to undeclared function 'mapping_set_folio_min_order'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     163 |                 mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
         |                 ^
   2 errors generated.


vim +/mapping_set_folio_min_order +145 block/bdev.c

   133	
   134	static void set_init_blocksize(struct block_device *bdev)
   135	{
   136		unsigned int bsize = bdev_logical_block_size(bdev);
   137		loff_t size = i_size_read(bdev->bd_inode);
   138	
   139		while (bsize < PAGE_SIZE) {
   140			if (size & bsize)
   141				break;
   142			bsize <<= 1;
   143		}
   144		bdev->bd_inode->i_blkbits = blksize_bits(bsize);
 > 145		mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
   146					    get_order(bsize));
   147	}
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

