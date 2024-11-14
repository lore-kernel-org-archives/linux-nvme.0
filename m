Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFA7D637D5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 00:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=erI/zc7bmFCYO/JsDqRd8Vnh8h7PMHkGx4YLuGRoFzU=; b=jtKKQkMEdFV6/w01GcMxweJIAD
	RroDqtZ8eAGMxidriCdftp/LCyowil8lmQKt97/L08Qok//B9/tKqx/pk/9wru9pHqSD0JOKgwSgT
	aapQ9wnS49YeH03iK3vMbKBmzgMJ3KKLezLXlCVfpOtdeswPlHx907rFqpJAEeTjpREllPaHIK+Ee
	mW01R1yFl88VoxPeg+hkm1ZkRf4f4spwaP6s/1mrlCLM6OoXz07zqP075R4jXTMPLkqZ80JpGcUY4
	5aBMSHz0pebjhamcWvpn8kAa/4CKJ241plSCAerGy7z7+zYIaeA5t+1bM2yZbY0hL+bHUDGgAfQsF
	kX9drpuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBNrB-00000008MDD-1cL9;
	Thu, 14 Nov 2024 00:37:09 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBNr8-00000008MCZ-0hxr
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 00:37:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731544626; x=1763080626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wB+qdsF1zvcupnZAmiFUD2WPtTMEGPHMhe/Wu8Kaqzs=;
  b=eA0RmDrBTz9RYBFqiw84Rx++uQOocVLpVLI3FMuZGS4HICW89Qx1iJqc
   MepO24ZUvOxdnGs3OER3BzlicigCOYIYVHwvzwIw6kGJD4tCEnARF5k1L
   hpS+6a/xf1xo/6kHN7MNGrWpgkqSu5Hvzq3zdIiBXb+MPJ+q8VZRDx3xd
   LHvmaz10O2cnsdCbioD9iw8aVyJVgf4dhns1KOiky3BBinKQ2o9VI7H1B
   lDFmGcaMVV1HwqEyzk7fs/WIu6goI5HrTCvjHMOed4BVKDFV5R06DQxlv
   O/3I5Z/8tfALsjwQyycv3YRJ4m1LvnjpwKMmAq4WnkIcb0Dlv3rgv00aK
   A==;
X-CSE-ConnectionGUID: yNWhl723RMee+XfrXCSVRg==
X-CSE-MsgGUID: jWAyCkk+RZ2p7d+btF0IDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="56854499"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="56854499"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:37:03 -0800
X-CSE-ConnectionGUID: 81TFp5NzQkm+LjalFbFfOQ==
X-CSE-MsgGUID: evH2ReHqT962TEV9Fkg/eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="87791094"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Nov 2024 16:36:58 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBNqy-0000yP-07;
	Thu, 14 Nov 2024 00:36:56 +0000
Date: Thu, 14 Nov 2024 08:36:35 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
	storagedev@microchip.com, linux-nvme@lists.infradead.org,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v4 07/10] scsi: hisi_sas: use blk_mq_hctx_map_queues to
 map queues
Message-ID: <202411140822.ZRutrwWP-lkp@intel.com>
References: <20241113-refactor-blk-affinity-helpers-v4-7-dd3baa1e267f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-7-dd3baa1e267f@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_163706_248697_6FF892AD 
X-CRM114-Status: GOOD (  15.24  )
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

[auto build test ERROR on c9af98a7e8af266bae73e9d662b8341da1ec5824]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/driver-core-bus-add-irq_get_affinity-callback-to-bus_type/20241113-223232
base:   c9af98a7e8af266bae73e9d662b8341da1ec5824
patch link:    https://lore.kernel.org/r/20241113-refactor-blk-affinity-helpers-v4-7-dd3baa1e267f%40kernel.org
patch subject: [PATCH v4 07/10] scsi: hisi_sas: use blk_mq_hctx_map_queues to map queues
config: i386-buildonly-randconfig-006-20241114 (https://download.01.org/0day-ci/archive/20241114/202411140822.ZRutrwWP-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140822.ZRutrwWP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140822.ZRutrwWP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:7:
   In file included from drivers/scsi/hisi_sas/hisi_sas.h:11:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:3375:45: error: use of undeclared identifier 'COQ_IRQ_INDEX'
    3375 |                 cq->irq_no = hisi_hba->irq_map[queue_no + COQ_IRQ_INDEX];
         |                                                           ^
   1 warning and 1 error generated.


vim +/COQ_IRQ_INDEX +3375 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c

  3322	
  3323	/*
  3324	 * There is a limitation in the hip06 chipset that we need
  3325	 * to map in all mbigen interrupts, even if they are not used.
  3326	 */
  3327	static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
  3328	{
  3329		struct platform_device *pdev = hisi_hba->platform_dev;
  3330		struct device *dev = &pdev->dev;
  3331		int irq, rc = 0;
  3332		int i, phy_no, fatal_no, queue_no;
  3333	
  3334		for (i = 0; i < HISI_SAS_PHY_INT_NR; i++) {
  3335			irq = hisi_hba->irq_map[i + 1]; /* Phy up/down is irq1 */
  3336			rc = devm_request_irq(dev, irq, phy_interrupts[i], 0,
  3337					      DRV_NAME " phy", hisi_hba);
  3338			if (rc) {
  3339				dev_err(dev, "irq init: could not request phy interrupt %d, rc=%d\n",
  3340					irq, rc);
  3341				rc = -ENOENT;
  3342				goto err_out;
  3343			}
  3344		}
  3345	
  3346		for (phy_no = 0; phy_no < hisi_hba->n_phy; phy_no++) {
  3347			struct hisi_sas_phy *phy = &hisi_hba->phy[phy_no];
  3348	
  3349			irq = hisi_hba->irq_map[phy_no + 72];
  3350			rc = devm_request_irq(dev, irq, sata_int_v2_hw, 0,
  3351					      DRV_NAME " sata", phy);
  3352			if (rc) {
  3353				dev_err(dev, "irq init: could not request sata interrupt %d, rc=%d\n",
  3354					irq, rc);
  3355				rc = -ENOENT;
  3356				goto err_out;
  3357			}
  3358		}
  3359	
  3360		for (fatal_no = 0; fatal_no < HISI_SAS_FATAL_INT_NR; fatal_no++) {
  3361			irq = hisi_hba->irq_map[fatal_no + 81];
  3362			rc = devm_request_irq(dev, irq, fatal_interrupts[fatal_no], 0,
  3363					      DRV_NAME " fatal", hisi_hba);
  3364			if (rc) {
  3365				dev_err(dev, "irq init: could not request fatal interrupt %d, rc=%d\n",
  3366					irq, rc);
  3367				rc = -ENOENT;
  3368				goto err_out;
  3369			}
  3370		}
  3371	
  3372		for (queue_no = 0; queue_no < hisi_hba->cq_nvecs; queue_no++) {
  3373			struct hisi_sas_cq *cq = &hisi_hba->cq[queue_no];
  3374	
> 3375			cq->irq_no = hisi_hba->irq_map[queue_no + COQ_IRQ_INDEX];
  3376			rc = devm_request_threaded_irq(dev, cq->irq_no,
  3377						       cq_interrupt_v2_hw,
  3378						       cq_thread_v2_hw, IRQF_ONESHOT,
  3379						       DRV_NAME " cq", cq);
  3380			if (rc) {
  3381				dev_err(dev, "irq init: could not request cq interrupt %d, rc=%d\n",
  3382						cq->irq_no, rc);
  3383				rc = -ENOENT;
  3384				goto err_out;
  3385			}
  3386			cq->irq_mask = irq_get_affinity_mask(cq->irq_no);
  3387		}
  3388	err_out:
  3389		return rc;
  3390	}
  3391	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

