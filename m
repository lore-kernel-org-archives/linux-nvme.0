Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B167FC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j5PxPNd55omfVM8Q4ZXAEu0BrfItRWLHwIYHkN92cy0=; b=d0HbeX51zm7aqdip0pRpqgH7GM
	+oDZqhiZefv902geoBNafpy1s9F4lxZupy+3NX1rKCBUSvATPQX58YdGe+4DjqTnpIAzzoqWcV6S1
	PQV2Ijq06T902pvzl0NKmg/rXBKbl5iDV3Pq28mFYJ84+P+MwybYgcsa/FPvvyVnItP+nXZjdM6oM
	zMMuDh7635kvUFfyHAO+jq+fdRUzt7labC+88S//0fltWKRGDtQaFrpp9602zIPDzPKS5RanYUSeK
	ipY3H/f+5Tk0er3aVLdrZlPYZrfo/5IRI60VOBe2WcpxkMNe71z5L6YbrZoMPqqIKYo2XaiK3x6sj
	sDn9/aAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFVUX-00DJZR-0M;
	Tue, 19 Dec 2023 08:30:17 +0000
Received: from mgamail.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFVUU-00DJYV-1g
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 08:30:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702974614; x=1734510614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TFvk/efFGED3uKW4jz6Wb+17MhEzSYGtlBq2AKXhvJ8=;
  b=T//b5ylYX4QQnZCNfglhIUmeL0oJDpZ4+/AIsS+jk0ImnZJanJk4YTwN
   KjXHrEz2XgKM7o8QRVFdNsaI3PED2pEhQaphwAmCuxBLQzsjyvZB5roUN
   eZ1YwNmO3mlJ6XjH7Mkh/nfKfTq8zocpikIxbdRbPr+M5vPPEa4IhPMiH
   3rrVHt5h8w2Hp63pdmzx9k62jm0TjthHHREH5lsrZPlZ2O+iyUTg7IiX+
   8R2Tjm5dzp6ZkTxIKrXmBIQhCI/6Do456g+/MbdEPigAqDfWFV1db7MF7
   XzLeQDdUew7Pz/Q+3ZNurvR3UohH8IoS7yA0tkVOXO5uXrbXmYif0U3yY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="375115825"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="375115825"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:30:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1023065694"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="1023065694"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 19 Dec 2023 00:30:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFVUK-000541-06;
	Tue, 19 Dec 2023 08:30:04 +0000
Date: Tue, 19 Dec 2023 16:29:41 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association
 path
Message-ID: <202312191634.ASof5mm8-lkp@intel.com>
References: <20231218153105.12717-16-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-16-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_003014_600534_D5A8A176 
X-CRM114-Status: GOOD (  13.80  )
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
[also build test ERROR on linus/master v6.7-rc6 next-20231219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvmet-fc-remove-unnecessary-bracket/20231219-003117
base:   git://git.infradead.org/nvme.git nvme-6.8
patch link:    https://lore.kernel.org/r/20231218153105.12717-16-dwagner%40suse.de
patch subject: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association path
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20231219/202312191634.ASof5mm8-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312191634.ASof5mm8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312191634.ASof5mm8-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/nvme/target/fc.c: In function 'nvmet_fc_put_tgtport_work':
>> drivers/nvme/target/fc.c:253:9: error: implicit declaration of function 'nvmet_fc_tgtport_put'; did you mean 'nvmet_ctrl_put'? [-Werror=implicit-function-declaration]
     253 |         nvmet_fc_tgtport_put(tgtport);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         nvmet_ctrl_put
   drivers/nvme/target/fc.c: At top level:
>> drivers/nvme/target/fc.c:259:13: warning: conflicting types for 'nvmet_fc_tgtport_put'; have 'void(struct nvmet_fc_tgtport *)'
     259 | static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/fc.c:259:13: error: static declaration of 'nvmet_fc_tgtport_put' follows non-static declaration
   drivers/nvme/target/fc.c:253:9: note: previous implicit declaration of 'nvmet_fc_tgtport_put' with type 'void(struct nvmet_fc_tgtport *)'
     253 |         nvmet_fc_tgtport_put(tgtport);
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +253 drivers/nvme/target/fc.c

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

