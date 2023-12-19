Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339A5C46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=orxAIyWhuVgGdw1xbJq7tqvevAkUgomNjBIlb/irL0k=; b=3uK18AxgNHh0xEOiM6vtPJkq1x
	BUV2ehPVIgxEHSa2xu0460x0l73jHkR7HVgDFZFAKSSGyG6NptyKgIZ/6T9Vh9EOHEWOQ9hIIF18P
	blz05T2ExzHjYxF14cTpOZDYzsFyiqizAM5zKEiJ0x8dkIq5WfB8JNbEhe6hVXBgnEm6qOokO/Q8i
	4xZSJo4fHXIs0utBERZWGRGQFItyUvCu5uxGvQS06RXBVl9+qnL8h81bPQXpllNO4wfqKXF0cPYVX
	KFba35gPLaPj+QPXR1y7cicN5+FpY16CQE+K9+QkjQUN9u5Jh6GIrmAm0LPZjD4uRCdo1TmT0W2Kv
	z58sOY4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFY74-00Df8v-1G;
	Tue, 19 Dec 2023 11:18:14 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFY70-00Df8Q-2m
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702984690; x=1734520690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o21DTEAWwM0e0dbAkfsavP1ZgY7Ic+y7ddHRBOQkmhU=;
  b=fWSmFi0/EOxzNcZvi0E3cQxK8hb6o6IWxKbFWhxnN7QPwmTYiykKEvW/
   81WduPLM3n5Ap8+Mu4//gUqCe/Y9s6LUkRedKYY0SXpxJCKtxXVGOdLyx
   7CuJ7jfw7NUDO8TRBJX5YxTprTwG03ToIBRVQ7NulBcSJmakYQ64LRhHN
   w9AxBzctsM0anLvFjKc2pkCcBOjnykKIoEtPB0Hm6+r2U08usM8bl8oKj
   LdXcBokuIm0i7tgkrer6ywwmzBUTwmv+kmf26wn6itKEQYy6yoRWbJJ+V
   JtvlO1zLYfzr6Hetk1vBFgwblVKlNuOmNizsPnvwqtepTOPNsn2vX6+3X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="481832821"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="481832821"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 03:18:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="804863597"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="804863597"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2023 03:18:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFY6o-0005EB-2Q;
	Tue, 19 Dec 2023 11:17:59 +0000
Date: Tue, 19 Dec 2023 19:17:22 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association
 path
Message-ID: <202312191845.lwrs1kbh-lkp@intel.com>
References: <20231218153105.12717-16-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-16-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_031810_949595_762D7099 
X-CRM114-Status: GOOD (  13.84  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linux-nvme/nvme-6.8]
[also build test WARNING on linus/master v6.7-rc6 next-20231219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvmet-fc-remove-unnecessary-bracket/20231219-003117
base:   git://git.infradead.org/nvme.git nvme-6.8
patch link:    https://lore.kernel.org/r/20231218153105.12717-16-dwagner%40suse.de
patch subject: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association path
config: i386-randconfig-013-20231219 (https://download.01.org/0day-ci/archive/20231219/202312191845.lwrs1kbh-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312191845.lwrs1kbh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312191845.lwrs1kbh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/fc.c: In function 'nvmet_fc_put_tgtport_work':
   drivers/nvme/target/fc.c:253:2: error: implicit declaration of function 'nvmet_fc_tgtport_put'; did you mean 'nvmet_ctrl_put'? [-Werror=implicit-function-declaration]
     nvmet_fc_tgtport_put(tgtport);
     ^~~~~~~~~~~~~~~~~~~~
     nvmet_ctrl_put
   drivers/nvme/target/fc.c: At top level:
>> drivers/nvme/target/fc.c:259:13: warning: conflicting types for 'nvmet_fc_tgtport_put'
    static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
                ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/fc.c:259:13: error: static declaration of 'nvmet_fc_tgtport_put' follows non-static declaration
   drivers/nvme/target/fc.c:253:2: note: previous implicit declaration of 'nvmet_fc_tgtport_put' was here
     nvmet_fc_tgtport_put(tgtport);
     ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/nvmet_fc_tgtport_put +259 drivers/nvme/target/fc.c

c53432030d8642 James Smart   2016-12-02  244  
c53432030d8642 James Smart   2016-12-02  245  
c53432030d8642 James Smart   2016-12-02  246  static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
9d625f7792875e James Smart   2018-02-28  247  static void nvmet_fc_fcp_rqst_op_defer_work(struct work_struct *work);
20d5f3b830ab45 Daniel Wagner 2023-12-18  248  static void nvmet_fc_put_tgtport_work(struct work_struct *work)
20d5f3b830ab45 Daniel Wagner 2023-12-18  249  {
20d5f3b830ab45 Daniel Wagner 2023-12-18  250  	struct nvmet_fc_tgtport *tgtport =
20d5f3b830ab45 Daniel Wagner 2023-12-18  251  		container_of(work, struct nvmet_fc_tgtport, put_work);
20d5f3b830ab45 Daniel Wagner 2023-12-18  252  
20d5f3b830ab45 Daniel Wagner 2023-12-18  253  	nvmet_fc_tgtport_put(tgtport);
20d5f3b830ab45 Daniel Wagner 2023-12-18  254  }
c53432030d8642 James Smart   2016-12-02  255  static void nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
c53432030d8642 James Smart   2016-12-02  256  static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
c53432030d8642 James Smart   2016-12-02  257  static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
c53432030d8642 James Smart   2016-12-02  258  static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
c53432030d8642 James Smart   2016-12-02 @259  static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
c53432030d8642 James Smart   2016-12-02  260  static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
0fb228d30b8d72 James Smart   2017-08-01  261  static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
0fb228d30b8d72 James Smart   2017-08-01  262  					struct nvmet_fc_fcp_iod *fod);
a96d4bd867129e James Smart   2017-10-27  263  static void nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc);
47bf3241064498 James Smart   2020-03-31  264  static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
47bf3241064498 James Smart   2020-03-31  265  				struct nvmet_fc_ls_iod *iod);
c53432030d8642 James Smart   2016-12-02  266  
c53432030d8642 James Smart   2016-12-02  267  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

