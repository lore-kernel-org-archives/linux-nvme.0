Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2D7C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Mar 2024 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uG0TdqNYUCssXrDNY2b8j4dwgy4hA/UI3mRR62fNIQ4=; b=axt2Ja5ilJdNYWiIIqOcbp7KYy
	OZSFADz3srG1tbnmrOTKfeEpvMgLc+oqWgaoUuolTqYG16KXFeZ9C64d2VGAB0U2AIV4+n8frZTBz
	tHMW7YkSC3tXIXDo+YAMCYAwwTAIkQmNQhQLLL3/Q1phWsnJmCGkDtDkt08nzub5+wZ1j04q0Dw/z
	wKT1e5e+ud5FHsg/IiShrUWZZkyu89/usQe3GyCwFgWuiDBGqKxicy3Q09G9HuIeGsqJq2kACmTPH
	5Qe0DhJ592k3WTrvmT2xcEVfXbaXYGx+lN5+J8+A5ItRpIf8tiCBkesFSCfRILOVtWL3aH1Z2Cpbn
	qSgKMnpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpXdh-0000000ASY8-49ce;
	Wed, 27 Mar 2024 18:04:41 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpXde-0000000ASWd-2hKE
	for linux-nvme@lists.infradead.org;
	Wed, 27 Mar 2024 18:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711562679; x=1743098679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xWB8XWxCZgb2qItt9Xl6ufQrSL6nG/2L7TcBeUeBOXU=;
  b=VtbYowk/pIlWH8ilSSlCBvd4rBH+agCtisAOgL8p9by9FeHRbNMZLwUI
   LGxMBSx4ylM+Yu97JX/gV02L+lqyse6QpFwSMF6ZpuzQqMlFYkm+GkLsp
   tMQ/2meB9opmerKy6nnHqlnUSLXgHtN+WA1BYQRKi6JGtNje/4HA17ZwY
   OdbvNYyQSt1kGxlpo3sndsqD6InBRuTU6XPJPbC+iTq63QxQB0ZCHevOR
   Bi+bg+YZhELcnhaPdn8VCmYT8NzjZY8dxLidlOqdzy1zMRTCTH5EBhsEh
   Ni2FAUdtfEA9vzVkA2fbtT8vecNbsjSD/hQjxUFqHhZ39m4j+6DDJ6Sr4
   g==;
X-CSE-ConnectionGUID: HgK20aJHSne5fTDgPjM6EA==
X-CSE-MsgGUID: h4rDePKMSFGgqG/6eap17w==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6542643"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6542643"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16411980"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 Mar 2024 11:04:35 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpXdZ-0001Ln-0x;
	Wed, 27 Mar 2024 18:04:33 +0000
Date: Thu, 28 Mar 2024 02:03:55 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 1/2] block: track per-node I/O latency
Message-ID: <202403280137.o1GjQ6cI-lkp@intel.com>
References: <20240326153529.75989-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326153529.75989-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_110438_934483_ABAF215A 
X-CRM114-Status: GOOD (  12.27  )
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
[also build test ERROR on linus/master v6.9-rc1 next-20240327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/block-track-per-node-I-O-latency/20240326-234521
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240326153529.75989-2-hare%40kernel.org
patch subject: [PATCH 1/2] block: track per-node I/O latency
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240328/202403280137.o1GjQ6cI-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403280137.o1GjQ6cI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403280137.o1GjQ6cI-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/blk-integrity.h:5,
                    from block/bdev.c:15:
>> include/linux/blk-mq.h:1240:15: error: unknown type name 'in'
    1240 | static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
         |               ^~
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for 'blk_nodelat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nodelat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^~


vim +/in +1240 include/linux/blk-mq.h

  1233	
  1234	#ifdef CONFIG_BLK_NODE_LATENCY
  1235	int blk_nodelat_enable(struct request_queue *q);
  1236	void blk_nodelat_disable(struct request_queue *q);
  1237	u64 blk_nodelat_latency(struct request_queue *q, int node);
  1238	int blk_nodelat_init(struct gendisk *disk);
  1239	#else
> 1240	static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
  1241	static inline void blk_nodelat_disable(struct request_queue *q) {}
> 1242	u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

