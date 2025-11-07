Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3108CCFA05
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Nov 2025 03:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TMmeW0kKNC5Z7LZKOD5sk6mCP07ar7XKcOfHhnE5s1E=; b=Kq75GRTrOa8Eb2aqtP4mUC1IA4
	3HbCd5hgyExp/D+mDUSjpm0ytxUa0aVIlcS+BftKf+0sv2c/yGjlkEKhnemQO0mE2PoMwS68Xbe6A
	VN7HMzO4G1T9QxJn/Om/L3MgtJBUBXHJAncrEdLFvXJVSOlF5XC9cvuKzQ3JajxaSjelO4XdbHNtm
	SnCOaghWl/p0W4McE+4TzGG5KKxiKzORLbaVcpAZ4tgMdcNUnbUT++k87zzIDs1pvWihn8Fimlh72
	R4kQHsgwiKp0hhPgk2FnBLT9AzJ3nQX3QCCoHIbByipXTEEL/dk0mut9G2KN++iF8WUhzamLjoE5p
	UdC655mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHCzm-0000000Gc7M-2D66;
	Fri, 07 Nov 2025 03:18:38 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHCzj-0000000Gc71-3GTW
	for linux-nvme@lists.infradead.org;
	Fri, 07 Nov 2025 03:18:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762485515; x=1794021515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=co3D5bCb1NX6D4M8Dv/GU45fZxnLdO//HvOQOwmnBcA=;
  b=Vz1JOvgRdJPMXS755DARpRvJPoKntPqZ7tBcXdIG70LDeUm2qYBmHGL8
   NOSmYldKzwyHPqRRvykptduJhX0Kc+mTf3zbSpk5xzKvphvyqUn2SexOE
   7wePcSKu1jZ4A1klK++bt7fLReXyejDTLF5/84xZzswKTfyZkk/6UJkFJ
   6hNPLtsdN2sB/IlWqs32NYxWr1iswI9Jl1ydZwKLDcqjXM/xntZAY+mps
   agM9lrF9x8PiZm0v601VKZob8NnfGZeK05EsRA/URTKKSYfbBK9zC/VGl
   wa9tNM4tGjKJpWf4WcJ/3y26ZhwI0yPelKNeSzPhPeTlvYi3ld4sC8vDN
   A==;
X-CSE-ConnectionGUID: sfmlRIOFS2eG65fNa/67Ng==
X-CSE-MsgGUID: bgN1hwJTRKGyip/habM5tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64334021"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="64334021"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 19:18:35 -0800
X-CSE-ConnectionGUID: v6iMZdAXQC2eCAAjusf8hQ==
X-CSE-MsgGUID: ZAMaWgOaQ9ix8OmGhqlTWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="187184741"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 06 Nov 2025 19:18:31 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHCzc-000Udk-30;
	Fri, 07 Nov 2025 03:18:28 +0000
Date: Fri, 7 Nov 2025 11:17:52 +0800
From: kernel test robot <lkp@intel.com>
To: Fengnan Chang <changfengnan@bytedance.com>, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	asml.silence@gmail.com, willy@infradead.org, djwong@kernel.org,
	hch@infradead.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH v2 1/2] block: use bio_alloc_bioset for passthru IO by
 default
Message-ID: <202511071021.3YIvZw6u-lkp@intel.com>
References: <20251107020557.10097-2-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107020557.10097-2-changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_191835_857834_61D96BCB 
X-CRM114-Status: GOOD (  10.31  )
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

Hi Fengnan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4a0c9b3391999818e2c5b93719699b255be1f682]

url:    https://github.com/intel-lab-lkp/linux/commits/Fengnan-Chang/block-use-bio_alloc_bioset-for-passthru-IO-by-default/20251107-100851
base:   4a0c9b3391999818e2c5b93719699b255be1f682
patch link:    https://lore.kernel.org/r/20251107020557.10097-2-changfengnan%40bytedance.com
patch subject: [PATCH v2 1/2] block: use bio_alloc_bioset for passthru IO by default
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20251107/202511071021.3YIvZw6u-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511071021.3YIvZw6u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511071021.3YIvZw6u-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: block/blk-map.c:365 function parameter 'rq' not described in 'bio_copy_kern'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

