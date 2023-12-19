Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB75C46CA2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 06:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MBdIZTbORfHOJG1sntxDXCt629Q8sWOZHtypm0M6N4=; b=Y1SYVaxiNE4gw77BR3jEhQ5mta
	ThF2o0XurN5wPlP6KudS/lY0J48GA7UoVgCvmvPkGrAB9/e2ZreanL3lp6uPL8oOSov2/jJyfmN7r
	h/YfvxT5APBNNAePTlN90J7RpWDwEWVBIGGa5AjP5LaE69uh6b4ajyRBSwCZNWNpqjy3SYD4/432M
	D7vnKuMRrkorSbHghU6jWgYhITkgwxMw4ZyfMcq7AZSgEg4FGuDe/cYQjUh4lmuMD7P0xb33cxAD3
	Xx351CAltnN1Pxcg5E05PWNXbkcAX47V9w5IAUcZEqGiRKfw+mD8Isr2Figvhpwejmfg8QN8LKDUn
	yCpNDAsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFT9g-00CwZc-2u;
	Tue, 19 Dec 2023 06:00:36 +0000
Received: from mgamail.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFT9b-00CwYc-1d
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 06:00:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702965631; x=1734501631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KuZnLO475ngFLg9EV3A/3KeAGUlrMD5qDq4De+BpMew=;
  b=dm8z8e6Kk4OZaH8KaS7bdgSqMi07UN4u/3afIW9sQxQZ+1qzh4eK6/P2
   wmsKDtPvS6yhnzZAli3B2xOiidoxzZ1SbjlVOEqmST+tQiT6Wu23iBzec
   r/Ho445fraKK8LToYm8rXL1+LoR4aA56ZbFBpH9gIywHRIiA/ga108bXy
   LLybrZ4c3Y9s9KpdNWCRVuuPXLkUHcnuiP/QE2oFCHvY3/qsm7CNv/W0b
   I14MlFKGTl8C4upQ7M7DlQoG7OwRc5W6/5G2OJpq2x4TQjrMh1ccC/clI
   gIIPuTNR7Emb20/UEaEj93dJm5dj58rK6QEngLUyvZ6bzlfwxM9ztH1p/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="392785568"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="392785568"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 22:00:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="769108675"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="769108675"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2023 22:00:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFT9R-0004uu-0t;
	Tue, 19 Dec 2023 06:00:21 +0000
Date: Tue, 19 Dec 2023 14:00:12 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association
 path
Message-ID: <202312191347.7X0VJgnV-lkp@intel.com>
References: <20231218153105.12717-16-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-16-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_220031_564066_05A7CE3D 
X-CRM114-Status: GOOD (  14.15  )
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

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux-nvme/nvme-6.8]
[also build test ERROR on linus/master v6.7-rc6 next-20231218]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvmet-fc-remove-unnecessary-bracket/20231219-003117
base:   git://git.infradead.org/nvme.git nvme-6.8
patch link:    https://lore.kernel.org/r/20231218153105.12717-16-dwagner%40suse.de
patch subject: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association path
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231219/202312191347.7X0VJgnV-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312191347.7X0VJgnV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312191347.7X0VJgnV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/target/fc.c:253:2: error: call to undeclared function 'nvmet_fc_tgtport_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           nvmet_fc_tgtport_put(tgtport);
           ^
>> drivers/nvme/target/fc.c:259:13: error: static declaration of 'nvmet_fc_tgtport_put' follows non-static declaration
   static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
               ^
   drivers/nvme/target/fc.c:253:2: note: previous implicit declaration is here
           nvmet_fc_tgtport_put(tgtport);
           ^
   2 errors generated.


vim +/nvmet_fc_tgtport_put +253 drivers/nvme/target/fc.c

   244	
   245	
   246	static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
   247	static void nvmet_fc_fcp_rqst_op_defer_work(struct work_struct *work);
   248	static void nvmet_fc_put_tgtport_work(struct work_struct *work)
   249	{
   250		struct nvmet_fc_tgtport *tgtport =
   251			container_of(work, struct nvmet_fc_tgtport, put_work);
   252	
 > 253		nvmet_fc_tgtport_put(tgtport);
   254	}
   255	static void nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
   256	static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
   257	static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
   258	static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 > 259	static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
   260	static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
   261	static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
   262						struct nvmet_fc_fcp_iod *fod);
   263	static void nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc);
   264	static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
   265					struct nvmet_fc_ls_iod *iod);
   266	
   267	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

