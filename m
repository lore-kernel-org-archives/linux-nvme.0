Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE00DC4167D
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Oct 2023 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ou/xA1rORme3Xmd4F2L60VqmIO8/pZQqWcD+Iq7bsk=; b=hvwjwQV748Bz+p2zDiCgoD9vT6
	v5AZ3RvLwaDEOMK0XGLjGbh7o7voUa+TTSlBF4lWZ39kHPtdcthqGU407uLZZqk4ptBGvSf9KYfF7
	vfRe5Y09FPd19NmO6s70uILn5Mhi5N4XC9CbWLobtWr2q8FanrYTTULmHm+qvJ2brNcYhg+p36nRo
	lzE24teiHERFEp+0imG7/k1lFQpHzBa5ZHrGKUHck+0+IEqBhVoswyBoQsvGCNd2fqEY17w0b8tbe
	vvvq+rkgHQ8kljAMVhxpQo6zJL5P1st8BPTlHJctTLa1qxbUDmm49NE7dX4MiKHVLY/MRoDKTa2nr
	OuvEAN0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxcOp-004H7a-0n;
	Tue, 31 Oct 2023 00:14:27 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxcOm-004H6Q-1h
	for linux-nvme@lists.infradead.org;
	Tue, 31 Oct 2023 00:14:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698711264; x=1730247264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kmk6KxUWFitEDciuF9oDB5RU0GkS5ElP0kWrFDqc2hQ=;
  b=WOf5uzfGMBJG0vzuiS+HiR5DMKj8BtvNBmBdwmtsPb4oN0FdTXCp4o4Y
   IgbFFUyVffA/Edd/24tDs8KVVmO0WO6GSP953Moqy6f3zNljd3PXWuAEK
   W7Sk7aSRW7NrRkg2LrkwPt2dbzjFyg5LnqXgkdo2N79X3G6cuHZhVOsnZ
   UdLaWVcZu8VOtEbXyTE7D7ooc2JmEGnzzxV/56hQ6pIyWOA/fH6JiP9Gc
   oQuOafs1QLdl4C43s05DgTEEAn+yaBSSoyF2uARfjjrB26bPJOL/XLJxh
   fCyPvkvHDXMWgsGkgsRC8jMeZqQgrM8sookNl4GxCzGT+2ZphIdgEYirP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="373236073"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="373236073"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 17:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1007586475"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="1007586475"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Oct 2023 17:14:17 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qxcOd-000Dg2-0P;
	Tue, 31 Oct 2023 00:14:15 +0000
Date: Tue, 31 Oct 2023 08:13:52 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
	hch@lst.de, joshi.k@samsung.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <202310310704.l4FwoJDd-lkp@intel.com>
References: <20231027181929.2589937-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027181929.2589937-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_171424_608573_3B37D693 
X-CRM114-Status: GOOD (  17.38  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.6 next-20231030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/block-bio-integrity-directly-map-user-buffers/20231028-022107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20231027181929.2589937-2-kbusch%40meta.com
patch subject: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231031/202310310704.l4FwoJDd-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310310704.l4FwoJDd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310310704.l4FwoJDd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/bio-integrity.c:215:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!buf)
               ^~~~
   block/bio-integrity.c:255:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   block/bio-integrity.c:215:2: note: remove the 'if' if its condition is always false
           if (!buf)
           ^~~~~~~~~
   block/bio-integrity.c:204:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +215 block/bio-integrity.c

   195	
   196	static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
   197					   int nr_vecs, unsigned int len,
   198					   unsigned int direction, u32 seed)
   199	{
   200		struct bio_integrity_payload *bip;
   201		struct bio_vec *copy_vec = NULL;
   202		struct iov_iter iter;
   203		void *buf;
   204		int ret;
   205	
   206		/* if bvec is on the stack, we need to allocate a copy for the completion */
   207		if (nr_vecs <= UIO_FASTIOV) {
   208			copy_vec = kcalloc(sizeof(*bvec), nr_vecs, GFP_KERNEL);
   209			if (!copy_vec)
   210				return -ENOMEM;
   211			memcpy(copy_vec, bvec, nr_vecs * sizeof(*bvec));
   212		}
   213	
   214		buf = kmalloc(len, GFP_KERNEL);
 > 215		if (!buf)
   216			goto free_copy;
   217	
   218		if (direction == ITER_SOURCE) {
   219			iov_iter_bvec(&iter, direction, bvec, nr_vecs, len);
   220			if (!copy_from_iter_full(buf, len, &iter)) {
   221				ret = -EFAULT;
   222				goto free_buf;
   223			}
   224		} else {
   225			memset(buf, 0, len);
   226		}
   227	
   228		/*
   229		 * We just need one vec for this bip, but we need to preserve the
   230		 * number of vecs in the user bvec for the completion handling, so use
   231		 * nr_vecs.
   232		 */
   233		bip = bio_integrity_alloc(bio, GFP_KERNEL, nr_vecs);
   234		if (IS_ERR(bip)) {
   235			ret = PTR_ERR(bip);
   236			goto free_buf;
   237		}
   238	
   239		ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
   240					     offset_in_page(buf));
   241		if (ret != len) {
   242			ret = -ENOMEM;
   243			goto free_bip;
   244		}
   245	
   246		bip->bip_flags |= BIP_INTEGRITY_USER;
   247		bip->copy_vec = copy_vec ?: bvec;
   248		return 0;
   249	free_bip:
   250		bio_integrity_free(bio);
   251	free_buf:
   252		kfree(buf);
   253	free_copy:
   254		kfree(copy_vec);
   255		return ret;
   256	}
   257	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

