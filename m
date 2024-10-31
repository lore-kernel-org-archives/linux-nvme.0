Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8000CE68954
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 04:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2BGM5mwVEPOZsllz75s+fdZ8BIPzREUYuIL5+x8x3so=; b=XNlDrT/EM1pfzY+lwx3hqMgEKn
	CsJW0fwJqYtyZAPlAwAwLUcnkbiepzrPh+EBB7O246sgYNFSWiQWsOQYCCVKpr5ukwHHe2Xurek81
	b2pnkX1+s70qXG2rjHzu+Z6tiKVbO2VDtOStIUxJhAK4inboS+NfgdPQb+WO0gZez0PXGRNZxnS/h
	LBDx0rg8u0o/xwVZYwyCseCUDPNBDg+Lj9FCqBILrX2E+AT9ETsgpTJTg50l9wCD8/lkFYePy6bku
	7S1IsPy0QKGnAaQUOMkurwvnrO+bq/JllepKiYFoYtoVCuDv9KwGecsl1UU5CNnq5tFrQEQAuthiJ
	q6lcJSVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Msp-00000002W5O-45Bf;
	Thu, 31 Oct 2024 04:34:07 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Msm-00000002W4Q-3CCT
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 04:34:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730349244; x=1761885244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VUkj7APm42ytkCv5hyJJUWMrjq2Ht8Itvcvvp3DRwr0=;
  b=NMqJRuFoDtGnU7+BBeKB5roSCtTVpvDSG8kf7jUgYjPTZRNussGTBdkp
   smmVxRchOgHFbEUk3yBAHWao9c0hNwhT4Xly8LRwiOgAF3W4QkY+ApsxS
   fKApsY4YSJHYBmqMTdkj3KwyZ4DTAz376GR5hBBMhigmhSozAHM1hM251
   gOq2gWIEYg6do5kmip1QTYiWFxX0WLZKrRumeA9U3tKaVdI7g3AphCV6N
   n9SMji8a977bdHo+jTXu2dhyxnGWOLyFhUvZwsRMoR26z2n/P9qtcSn/A
   XRqBitNJsik4Eg2MdHpvd+5kshQXyky8xz/zIwJGZKZQD7l8g43vxzpPt
   g==;
X-CSE-ConnectionGUID: AGNkGFfHRXuNG7PmnmEWIw==
X-CSE-MsgGUID: UBz70REMSB6HaaO55frHpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52631569"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52631569"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 21:33:58 -0700
X-CSE-ConnectionGUID: buv4+dYoTP+C97Nj5efliw==
X-CSE-MsgGUID: Rb1baIvVQLiVBWa/sKFkIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="82168572"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 21:33:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6MsZ-000ffK-1M;
	Thu, 31 Oct 2024 04:33:51 +0000
Date: Thu, 31 Oct 2024 12:33:01 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, martin.petersen@oracle.com,
	asml.silence@gmail.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com, vishak.g@samsung.com, anuj1072538@gmail.com,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v6 03/10] block: modify bio_integrity_map_user to accept
 iov_iter as argument
Message-ID: <202410311228.zl84IPP6-lkp@intel.com>
References: <20241030180112.4635-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030180112.4635-4-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_213404_912960_B2E5A425 
X-CRM114-Status: GOOD (  11.91  )
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

Hi Kanchan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[cannot apply to brauner-vfs/vfs.all mkp-scsi/for-next jejb-scsi/for-next linus/master v6.12-rc5 next-20241030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/block-define-set-of-integrity-flags-to-be-inherited-by-cloned-bip/20241031-021248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20241030180112.4635-4-joshi.k%40samsung.com
patch subject: [PATCH v6 03/10] block: modify bio_integrity_map_user to accept iov_iter as argument
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20241031/202410311228.zl84IPP6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410311228.zl84IPP6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410311228.zl84IPP6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/blk-integrity.h:6,
                    from block/bdev.c:15:
>> include/linux/bio-integrity.h:104:12: warning: 'bio_integrity_map_user' defined but not used [-Wunused-function]
     104 | static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
         |            ^~~~~~~~~~~~~~~~~~~~~~


vim +/bio_integrity_map_user +104 include/linux/bio-integrity.h

   103	
 > 104	static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
   105	{
   106		return -EINVAL;
   107	}
   108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

