Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAC0D637DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 03:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9uJRWlyV+JH6U5oeeBUECQrcjz3cwGUXt+kWU90Dc44=; b=lVOupymqsuS7nJ/RQWOYKnzi0W
	F7wE+dPLshSyBYh2SP6umOIOgStBhLfwBP20QCmBP9gF6mqPLVt4S/oEhBOzy2IwK2Ri8Y7arW2Tb
	uSp+YLTcZoQoWyF/tKVyIo1WZTMleN0iWBDpdbUvgr6wYrHk5KrCCPpXTQiOIlZFRXmQ1eTOWbCEU
	z4U5ExlU1W+WmaqsaANQH7JyyfJcC/un5h0/SoQANX7G0t8eHb9iMqo4+5xWYaxm+f2n7M/PeYCfW
	DNqlpswUhEALQ2P5UYkLYmmDHPnNcfyzcMeJZ0qwVohBc0zc3G6BTRvMzSTntCloUaxqFrMak4RZU
	sGHt5DWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBQXM-00000008frj-2FtC;
	Thu, 14 Nov 2024 03:28:52 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBQXI-00000008fqs-1qcd
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 03:28:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731554928; x=1763090928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WRmD6xgMQVcZGar6UbZFdLyY+n+NhE4mcrGrT24Lf5g=;
  b=X9cwWtiMuFGtLxV/ybnLLUI5L6xbjj9xxLxeBge90BQ1VM4Q7YAh0h7s
   J/8rSTa1OeiDoFd+QpQ24/KaERDY4jytBlPKL4b0t5b+vGXdYq4MvEULT
   g557EvyG+MCc0mN9hUIdgfdxj/flRgw3kikDI1HB7z+bVU7NNuxRnIfew
   iMyOQOECCPmxm/L75KY3v+OkT5L5IKvCvQutTi5Ymtbc/AkcNQt6OTA0v
   sHM+Lx+3MK3jCocZ8yaQ5gjAwaft1wFfC+S6LGwqWlrQN4CoYtJx/7JTt
   S6+iFXUj9pNcAfeTIzOdWwGVWSSKQyV52JBBpINzXCmp4LxhL+zlKxMg/
   A==;
X-CSE-ConnectionGUID: waKuegqORlqli6G9PGsySg==
X-CSE-MsgGUID: DuPzb0biRmKk+N9Cnr8ssw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="34340466"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="34340466"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 19:28:44 -0800
X-CSE-ConnectionGUID: eYVuJ0dCT9i9IwTujQ6flQ==
X-CSE-MsgGUID: ftVVDwGAQzyRGL6uJAEMCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="118887845"
Received: from lkp-server01.sh.intel.com (HELO b014a344d658) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 19:28:39 -0800
Received: from kbuild by b014a344d658 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBQX6-000053-0e;
	Thu, 14 Nov 2024 03:28:36 +0000
Date: Thu, 14 Nov 2024 11:28:13 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v4 07/10] scsi: hisi_sas: use blk_mq_hctx_map_queues to
 map queues
Message-ID: <202411141102.q2IPCJ7K-lkp@intel.com>
References: <20241113-refactor-blk-affinity-helpers-v4-7-dd3baa1e267f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-7-dd3baa1e267f@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_192848_520834_B754D8D5 
X-CRM114-Status: GOOD (  18.39  )
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
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20241114/202411141102.q2IPCJ7K-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411141102.q2IPCJ7K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411141102.q2IPCJ7K-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c: In function 'interrupt_init_v2_hw':
>> drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:3375:59: error: 'COQ_IRQ_INDEX' undeclared (first use in this function); did you mean 'CQ0_IRQ_INDEX'?
    3375 |                 cq->irq_no = hisi_hba->irq_map[queue_no + COQ_IRQ_INDEX];
         |                                                           ^~~~~~~~~~~~~
         |                                                           CQ0_IRQ_INDEX
   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:3375:59: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c: At top level:
   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:3624:36: warning: 'sas_v2_acpi_match' defined but not used [-Wunused-const-variable=]
    3624 | static const struct acpi_device_id sas_v2_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~


vim +3375 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c

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

