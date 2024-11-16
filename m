Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8985ED68BF6
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2024 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IDfLd+BaMfEj3prF7vdnofwRzo66wZtnSH2VB762vn0=; b=NO4S92aN23wZqGbOUDF4aFtgpq
	Fc1he80uhWJDSHvppfHG12ToAJWRbU4LFlkH0EVBKJhBkeQBjGEkq263ujI4YhV4SGLcb0I6pmSpN
	hIJPCK3TPFtTCEDmo3mUjXcRQS+XYc8PSuEc1BSMDku8nOvq0LdVfYIYIRbhyvdkOBkc+2VoQL5jr
	4tkIbFScXusV6X6pDJOA3rwRLmGcbQ9ADsRZp+a+ZpK0YJ1eg5qLoPp5EzX+SnpIJUyJyORZtdN0B
	J90pEYrgAEh9LORVycDioQveSqEDk3GGcIIYGiUlsNJmIOq5mJe+z/87CfKzTAV+JZrQ7mxgAGV6p
	oLD4HF+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tCRw2-00000006NwB-3ouX;
	Sat, 16 Nov 2024 23:10:34 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tCRvv-00000006Nt0-2qmN
	for linux-nvme@lists.infradead.org;
	Sat, 16 Nov 2024 23:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731798628; x=1763334628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J8TdKlbufzk8/hb67F60g16aY7BksH2lDSQzP/7KGb0=;
  b=DH12xK7E0+YEvkWg8RqUAYMqwB2hGNOfOcKZgdaI4cFMMJ8KqqymbioL
   lTazIKIZfeiZMdGVTbYNaxOg39B6azH8Mx+w/k1KvQr7nXtlih4/hctvh
   bzhv9TircqLhUJJWb6Bx2HSRQ+ByYvZkSsZt/FBst+w1gQnp1uuVEYYWl
   fXPbTWuO3a6EW5JkrlsHWhyxGOhUW8alqUoQ03TWvFZMxQ2B6E2pGesgG
   ySEGRitxTnz7E3L+NAJXRctqKzufBLmTMFflA7IzI5v+s0OlbjuMpG8M3
   RrVrnxxJ1uVC2JCqG7fUQ1S8VcnT+rrJfz1xHV7uDLZxtsS7q9mVyb5Nx
   A==;
X-CSE-ConnectionGUID: Qi2cw1RzRMOYrSbELguIGg==
X-CSE-MsgGUID: RH+CtPmLRTenvW0SIwCqng==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="19388881"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="19388881"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 15:10:22 -0800
X-CSE-ConnectionGUID: 18+FoBMjQe2kvuLxiyxaXA==
X-CSE-MsgGUID: x4jbkL5oTsSTSFJ0eVCDHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="89284449"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 16 Nov 2024 15:10:17 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCRvi-00019x-2o;
	Sat, 16 Nov 2024 23:10:14 +0000
Date: Sun, 17 Nov 2024 07:09:45 +0800
From: kernel test robot <lkp@intel.com>
To: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk
Cc: oe-kbuild-all@lists.linux.dev, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <202411170724.GLZyWdlD-lkp@intel.com>
References: <20241114104517.51726-7-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114104517.51726-7-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241116_151027_765008_A0DC04D8 
X-CRM114-Status: GOOD (  10.68  )
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

Hi Anuj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on next-20241115]
[cannot apply to brauner-vfs/vfs.all mkp-scsi/for-next hch-configfs/for-next linus/master jejb-scsi/for-next v6.12-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anuj-Gupta/block-define-set-of-integrity-flags-to-be-inherited-by-cloned-bip/20241114-193419
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20241114104517.51726-7-anuj20.g%40samsung.com
patch subject: [PATCH v9 06/11] io_uring: introduce attributes for read/write and PI support
config: arc-nsimosci_hs_smp_defconfig (https://download.01.org/0day-ci/archive/20241117/202411170724.GLZyWdlD-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411170724.GLZyWdlD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411170724.GLZyWdlD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   io_uring/rw.c: In function 'io_prep_pi_indirect':
>> io_uring/rw.c:305:38: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |         if (copy_from_user(&pi_attr, (void __user *)pi_attr_addr, sizeof(pi_attr)))
         |                                      ^
   io_uring/rw.c: In function 'io_prep_attr_vec':
   io_uring/rw.c:321:38: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     321 |         if (copy_from_user(attr_vec, (void __user *)attr_addr, attr_vec_size))
         |                                      ^


vim +305 io_uring/rw.c

   298	
   299	
   300	static inline int io_prep_pi_indirect(struct io_kiocb *req, struct io_rw *rw,
   301					      int ddir, u64 pi_attr_addr)
   302	{
   303		struct io_uring_attr_pi pi_attr;
   304	
 > 305		if (copy_from_user(&pi_attr, (void __user *)pi_attr_addr, sizeof(pi_attr)))
   306			return -EFAULT;
   307		return io_prep_rw_pi(req, rw, ddir, &pi_attr);
   308	}
   309	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

