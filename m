Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98681C001DF
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Oct 2023 11:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yu881yYXyoibZGlqhfa0c14Aaqd+EE343VwkGJoLvm4=; b=s7osGqZ8vJTtriyGF82knvAJH5
	ydNsCUMt000zIOHhHj64nJzXtBPCK1EqrSuL1C7TnMuyKrRcajVqo7ro6Ui0n/vaWno2L8GtzvzW/
	KphyRjAihZRxIRzRubCglhLLnbmWGo794loeWOEreZA5GJBzclAzgHuzxNJ7LLCbParnmY3oi/pFe
	R9vTUbOtzGBkMeGigxbWwiuNlV93RKRitWOZKkPyws1eFzczPb5As+CeliB2Jk4gNCHfInZT5m1k1
	AAGXq8nAub7d5qi81GDV2FXqzxToyaYrDfe3nXmfJjHkAZ4ag36l645FhZuOe1UJX98HO1TutTRjF
	rmbFTUlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quX07-005QMf-0r;
	Sun, 22 Oct 2023 11:52:11 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quX00-005QLy-2w
	for linux-nvme@lists.infradead.org;
	Sun, 22 Oct 2023 11:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697975524; x=1729511524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BdVZ+C8tN+qekt7Hl3QUHfu9nPna5/5VggjFolJCjy8=;
  b=lR7TCoswjoIWClFqHlhxnkRRtO4yIPttIDlnZLWtJR85RzFYdKEZihoi
   QoJHJF4nn8NnoQdS66+k72asauP06MLh1oxgC1IRBYimpPIBugJCLN7zR
   N30ECw4Vr9CszNK1QRclS8ja9vRlaYQ3JtFcNgTY4duQwRe6EqMqZPjaW
   QmdQdI6uSh6/IclHeiRjC5UObFvGJKAPSNbz4z1WgSPMeRM4jrvhXorIV
   HCslWkwJ0hO8v66E0/PYRe99x1EhpxcGM/VDRbp2iq0VCfY6bNmUx6Tvo
   U4YlnVwPvkDjrWUzwqI/TdUmPwvxQJVzu+J2LgCL2zNjUYKnClySwBGOn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="385578989"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="385578989"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 04:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="792851290"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="792851290"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Oct 2023 04:51:54 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1quWzo-0005vq-0d;
	Sun, 22 Oct 2023 11:51:52 +0000
Date: Sun, 22 Oct 2023 19:51:16 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
	anuj1072538@gmail.com, gost.dev@samsung.com, mcgrof@kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v17 08/12] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202310221915.PYH9XadG-lkp@intel.com>
References: <20231019110147.31672-9-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019110147.31672-9-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231022_045205_023903_F7ACE4A5 
X-CRM114-Status: GOOD (  13.59  )
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

Hi Nitesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 213f891525c222e8ed145ce1ce7ae1f47921cb9c]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-and-sysfs-for-copy-offload-support/20231019-200658
base:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
patch link:    https://lore.kernel.org/r/20231019110147.31672-9-nj.shetty%40samsung.com
patch subject: [PATCH v17 08/12] nvmet: add copy command support for bdev and file ns
config: i386-randconfig-062-20231022 (https://download.01.org/0day-ci/archive/20231022/202310221915.PYH9XadG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310221915.PYH9XadG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310221915.PYH9XadG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/io-cmd-bdev.c:498:30: sparse: sparse: restricted __le16 degrades to integer

vim +498 drivers/nvme/target/io-cmd-bdev.c

   478	
   479	/*
   480	 * At present we handle only one range entry, since copy offload is aligned with
   481	 * copy_file_range, only one entry is passed from block layer.
   482	 */
   483	static void nvmet_bdev_execute_copy(struct nvmet_req *rq)
   484	{
   485		struct nvme_copy_range range;
   486		struct nvme_command *cmd = rq->cmd;
   487		ssize_t ret;
   488		off_t dst, src;
   489	
   490		u16 status;
   491	
   492		status = nvmet_copy_from_sgl(rq, 0, &range, sizeof(range));
   493		if (status)
   494			goto err_rq_complete;
   495	
   496		dst = le64_to_cpu(cmd->copy.sdlba) << rq->ns->blksize_shift;
   497		src = le64_to_cpu(range.slba) << rq->ns->blksize_shift;
 > 498		rq->copy_len = (range.nlb + 1) << rq->ns->blksize_shift;
   499	
   500		if (bdev_max_copy_sectors(rq->ns->bdev)) {
   501			ret = blkdev_copy_offload(rq->ns->bdev, dst, src, rq->copy_len,
   502						  nvmet_bdev_copy_endio,
   503						  (void *)rq, GFP_KERNEL);
   504		} else {
   505			ret = blkdev_copy_emulation(rq->ns->bdev, dst,
   506						    rq->ns->bdev, src, rq->copy_len,
   507						    nvmet_bdev_copy_endio,
   508						    (void *)rq, GFP_KERNEL);
   509		}
   510		if (ret == -EIOCBQUEUED)
   511			return;
   512	
   513		rq->cqe->result.u32 = cpu_to_le32(0);
   514		status = errno_to_nvme_status(rq, ret);
   515	err_rq_complete:
   516		nvmet_req_complete(rq, status);
   517	}
   518	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

