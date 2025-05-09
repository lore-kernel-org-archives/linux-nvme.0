Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92D2C3ABBC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ywYiET4odNQZ9+5hacg0Kn3JVHrmt/HxwQeuYgAX+SU=; b=v/BNYR60mWeBo05qiZtu3BxuaA
	ZkTAKFsqB8IzBFxxoyxLU+ykYBoqOVVLsF/FSZCWA7fy/d/OMnNGYLAr4y1Qa3w+Xe0XIZD0BW9qr
	moWGY93QTFGsisObEGiv1Rn4iDWJrxZ4LyBFQ1sGV8TkF1zprBiMLxJgFe8CwJLEZ6OzR1NPBPOF/
	i4FeFCmHDWq3kcH/Mg/GIRo8G6bj5XGiWC/qDT0LBVvqhCGYVhrkVklqdghmDYyBtzDaK/7uUqEk3
	9pQcXoRFFi+qk7KvnWXRsHY1kt0w5N/94sFvbctOzEQYpvm+EcBQv8gYLgMWs8+CjZE/uJ+ynJHBx
	iMCqebnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDJuM-0000000359O-0ha3;
	Fri, 09 May 2025 09:20:42 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDJVK-000000030Ee-1u7L
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 08:54:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746780890; x=1778316890;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oepDtHzajxH/jtKxGYRJsypIYPhpsvGjOf7cGD1TEyY=;
  b=LyvzAsRYEr8UvmKqGbMquKgbDkyqVvqKU9gtstSr+gTqA1T1yeGJqjh8
   Hn/2VNSrt6WWYmLokmVqgMaNf6jE9wqdcfEd6iRrwHcgitsp6UwZo9R91
   zs9dDmGyFF8y4WzRSdiPEolXyGczT9oBUzB9gsVfz8kBTRU13xlXi2Wts
   yoSXBnVUKbRAt8CMWhyx9dDueFDsrncdJfDDbaXYgSuwk2D2n+osY68ND
   qoJjIYV39cEmp0P38WVhyWxONugVJ+wSGHmak0/U5yiJrTNFsuCu+FsBF
   RRdwEW0dkgN9fF5bJo3HoPwoHxbjbcPG86IlBb1Pyl+1x8MIRBBZf8nN+
   g==;
X-CSE-ConnectionGUID: eyR/oqOBSQ2J+MWv7Zpkjw==
X-CSE-MsgGUID: yHz3GnLRQ5O5PPhkIfY5aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="47708657"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="47708657"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:54:50 -0700
X-CSE-ConnectionGUID: xLlKLPs9S2yw7cHFFTC1/g==
X-CSE-MsgGUID: 5gtTs8nWQpqsgidedIDJrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="141334172"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 May 2025 01:54:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDJVF-000BqR-2n;
	Fri, 09 May 2025 08:54:45 +0000
Date: Fri, 9 May 2025 16:54:02 +0800
From: kernel test robot <lkp@intel.com>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [linux-nvme:nvme-6.16 11/14] drivers/nvme/target/core.c:1018:10:
 warning: variable 'ret' is uninitialized when used here
Message-ID: <202505091619.QFU1fxsd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_015450_503059_040D6E4E 
X-CRM114-Status: UNSURE (   9.91  )
X-CRM114-Notice: Please train this message.
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

tree:   git://git.infradead.org/nvme.git nvme-6.16
head:   a0136c6ac4a9aba90a47b9c691bc299a113b5259
commit: 206372d7c565174e6b8289dac03077b23b8369c9 [11/14] nvmet: support completion queue sharing
config: s390-randconfig-002-20250509 (https://download.01.org/0day-ci/archive/20250509/202505091619.QFU1fxsd-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505091619.QFU1fxsd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505091619.QFU1fxsd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/target/core.c:1018:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
    1018 |                 return ret;
         |                        ^~~
   drivers/nvme/target/core.c:1015:9: note: initialize the variable 'ret' to silence this warning
    1015 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +1018 drivers/nvme/target/core.c

  1012	
  1013	int nvmet_sq_init(struct nvmet_sq *sq, struct nvmet_cq *cq)
  1014	{
  1015		int ret;
  1016	
  1017		if (!nvmet_cq_get(cq))
> 1018			return ret;
  1019	
  1020		ret = percpu_ref_init(&sq->ref, nvmet_sq_free, 0, GFP_KERNEL);
  1021		if (ret) {
  1022			pr_err("percpu_ref init failed!\n");
  1023			nvmet_cq_put(cq);
  1024			return ret;
  1025		}
  1026		init_completion(&sq->free_done);
  1027		init_completion(&sq->confirm_done);
  1028		nvmet_auth_sq_init(sq);
  1029		sq->cq = cq;
  1030	
  1031		return 0;
  1032	}
  1033	EXPORT_SYMBOL_GPL(nvmet_sq_init);
  1034	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

