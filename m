Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4ECC25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 15 May 2024 04:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jwnhvFiK/obNrGnNp8acgv74uFStSFLGaSPfQ02w3KE=; b=viEK9Pd/e9aEUluQde7Wab4AOK
	sdsTRR1OK/aP/aNaIDq66u0y1XTTU2xps1HbwKCTBrrsRiVDy9Kv7u22zIyAp47zIjPNlTYidj6bs
	CYIjtsbo0T5GmXo4ysk5WuTXGprhpgNhuwkNnynBe0HtzE0bHBpdAHpvONFZHKG1NzUuYG1EwXb02
	6//alVfnJ74Jto+JUkihNNn+mpA74TWTMCb9iVrftxpYR7pIkkiMkVx/JpPEeLTM9JkK15B5pTcSt
	7KykSCqtOxnRJpGS8Cui+izZHTvU2rL4Zj0bVSoLEYabauJfYkWcop7QxHTb3D+CqZBirgDJiKRX0
	H4nmvAoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s76AL-00000000Pgl-1IsW;
	Wed, 15 May 2024 04:22:57 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s76AH-00000000Peg-3EtR
	for linux-nvme@lists.infradead.org;
	Wed, 15 May 2024 04:22:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715746974; x=1747282974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UfvTxTsJGM30yB6JUP6qcnmueYS7+adWFARHTPLXG/8=;
  b=HJ7ti+E4Sc+ZJ/wRDT7AnOW2DX/wdA/jY3VEFt7ylmGRgROSOlnJh/8/
   QaAm/maYYowv6e5p24eqflbDycGCEDx6SOhuCMfhYKXeNsRM992anXMii
   tV2II3mJxVZFt32Apg2IYB+nzEEyuDgiUWXBfetoYOYs9bkynqEMQHxMm
   myiJzRJnnEPmoOheMuEy3XaFY3GEpnU7Gl0dj3Sc0wCLBmYXku5bQu/CY
   WLp0DkUFwkyXpauOVOUQ8kS3TWf9LeW0plbDFxj2goVychj6CWo1Lt8ot
   kc7GPkkDJwV+l7urBhuToBt0i83ogztKqVlTMocPJvYOfEM+vamNWw0Z/
   g==;
X-CSE-ConnectionGUID: tRfWBt+PSKKwTd91OokGQg==
X-CSE-MsgGUID: P2ld5BI4Q/6ISk1rv8jUkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29292536"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="29292536"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 21:22:48 -0700
X-CSE-ConnectionGUID: UfaLV5ZhQmeGHhCIH1mdFA==
X-CSE-MsgGUID: 9m3SOfKSTjW4zDwa8XcXSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="68375794"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 May 2024 21:22:46 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s769j-000CQ9-1j;
	Wed, 15 May 2024 04:22:19 +0000
Date: Wed, 15 May 2024 12:21:30 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 4/6] block/bdev: enable large folio support for large
 logical block sizes
Message-ID: <202405151219.H2vlwtc0-lkp@intel.com>
References: <20240514173900.62207-5-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514173900.62207-5-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_212253_839444_A51D305F 
X-CRM114-Status: GOOD (  11.45  )
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

Hi Hannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.9]
[cannot apply to next-20240514]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/fs-mpage-avoid-negative-shift-for-large-blocksize/20240515-014146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240514173900.62207-5-hare%40kernel.org
patch subject: [PATCH 4/6] block/bdev: enable large folio support for large logical block sizes
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240515/202405151219.H2vlwtc0-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240515/202405151219.H2vlwtc0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405151219.H2vlwtc0-lkp@intel.com/

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

