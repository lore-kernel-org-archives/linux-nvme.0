Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6C1E77188
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 01:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LyBVzdx6qjl1nBYRx5h6heEx/LGj74t0PCtX7bQuelo=; b=aJAQ5jDiAoqUV8+GEAQa1osHFI
	Oxc7DkFYu43MpLacI7f7n99QR7A8t8n3rKTmnE9buCCthcLtuWOyB5y9O2WooDtklCGppJC3XEKN2
	BLH1uKU/Z/iy+dmvHHyfgMdZebtdKYBz57TVLSgNDn55BtrfJMSoYIoPMH2HVCJAqtiMqSpfXymUr
	BsqchnbG4dnZ4ZKGS3/Y6klczmwDVPpHiNispAcoKOzWitwy1oB5kNs0Ourx93dcVMk9plGvWjXFp
	29+9i95IPiPJ/hlBC5VHkLOGgJCfsDeQ1rYTHCD0AyufwF4zww2VUQrLLTPWmdEYYE56zHpo79jCM
	PfJ4vu3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVhWJ-0000000AL0l-04Tp;
	Thu, 09 Jan 2025 01:39:35 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVhU9-0000000AKeV-1HcY
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 01:37:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736386641; x=1767922641;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KEMwPMPL8k1q3gQKYDnAz2PHPmdJsxCzMYAj95m/jzA=;
  b=JF6Ahwlty/dlWANl/VmS4G2rY+WZv/P1VYPQvlF30+t0TvwoupNynuLQ
   hvwHaf6xSyn0zCa90IsujUD3KS5rTaf9DqwHDNnWWymD9LVWDqzDhlJeT
   IJeFyiE7RnypL8DhpNEQsjYT16V/HTid+9g1ET8vJ/7LxLR2ugXipHUkX
   QmR56wAulz6yMJisJdNDzYLTkwvDKfIqs5Px3KV3kAe2z4NawehVVbiY3
   qC1VZhKdsK+NQzN3y17yOnmO1oWEshE2pljO2PL1CxJMfMT7IgQRjw560
   mO5g1VgCfA3gdpCvS22KG0GNQfGg0ay0xlVqXMWxBDOABbEpeG+fNTs/k
   Q==;
X-CSE-ConnectionGUID: C2NzesOARyeeNz/3QtQmGQ==
X-CSE-MsgGUID: XOBqrw8FSJuJVNT3vANPHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36858108"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="36858108"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 17:37:20 -0800
X-CSE-ConnectionGUID: senC9nACRriCMVVKFCDAGg==
X-CSE-MsgGUID: X0c68r+AQvSUNgLxWDR51g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108375630"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Jan 2025 17:37:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVhU4-000GtR-03;
	Thu, 09 Jan 2025 01:37:16 +0000
Date: Thu, 9 Jan 2025 09:36:26 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-6.14 2/36] drivers/nvme/host/tcp.c:1583:18:
 warning: variable 'n' set but not used
Message-ID: <202501090934.Dhw69M6j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_173721_686975_1A88EDBA 
X-CRM114-Status: GOOD (  13.39  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.14
head:   b9973aa4d0507c4969ad87763b535edb77b7dceb
commit: bd0f5c10310122f4f1d9468467a59a6f69e46f92 [2/36] nvme-tcp: Fix I/O queue cpu spreading for multiple controllers
config: s390-randconfig-001-20250109 (https://download.01.org/0day-ci/archive/20250109/202501090934.Dhw69M6j-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501090934.Dhw69M6j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501090934.Dhw69M6j-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/host/tcp.c: In function 'nvme_tcp_set_queue_io_cpu':
>> drivers/nvme/host/tcp.c:1583:18: warning: variable 'n' set but not used [-Wunused-but-set-variable]
    1583 |         int cpu, n = 0, min_queues = INT_MAX, io_cpu;
         |                  ^
--
>> drivers/nvme/host/tcp.c:1578: warning: Function parameter or struct member 'queue' not described in 'nvme_tcp_set_queue_io_cpu'
>> drivers/nvme/host/tcp.c:1578: warning: expecting prototype for Track the number of queues assigned to each cpu using a global per(). Prototype was for nvme_tcp_set_queue_io_cpu() instead


vim +/n +1583 drivers/nvme/host/tcp.c

  1567	
  1568	/**
  1569	 * Track the number of queues assigned to each cpu using a global per-cpu
  1570	 * counter and select the least used cpu from the mq_map. Our goal is to spread
  1571	 * different controllers I/O threads across different cpu cores.
  1572	 *
  1573	 * Note that the accounting is not 100% perfect, but we don't need to be, we're
  1574	 * simply putting our best effort to select the best candidate cpu core that we
  1575	 * find at any given point.
  1576	 */
  1577	static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
> 1578	{
  1579		struct nvme_tcp_ctrl *ctrl = queue->ctrl;
  1580		struct blk_mq_tag_set *set = &ctrl->tag_set;
  1581		int qid = nvme_tcp_queue_id(queue) - 1;
  1582		unsigned int *mq_map;
> 1583		int cpu, n = 0, min_queues = INT_MAX, io_cpu;
  1584	
  1585		if (wq_unbound)
  1586			goto out;
  1587	
  1588		if (nvme_tcp_default_queue(queue)) {
  1589			mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
  1590			n = qid;
  1591		} else if (nvme_tcp_read_queue(queue)) {
  1592			mq_map = set->map[HCTX_TYPE_READ].mq_map;
  1593			n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT];
  1594		} else if (nvme_tcp_poll_queue(queue)) {
  1595			mq_map = set->map[HCTX_TYPE_POLL].mq_map;
  1596			n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
  1597					ctrl->io_queues[HCTX_TYPE_READ];
  1598		}
  1599		if (WARN_ON(!mq_map))
  1600			goto out;
  1601	
  1602		/* Search for the least used cpu from the mq_map */
  1603		io_cpu = WORK_CPU_UNBOUND;
  1604		for_each_online_cpu(cpu) {
  1605			int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
  1606	
  1607			if (mq_map[cpu] != qid)
  1608				continue;
  1609			if (num_queues < min_queues) {
  1610				io_cpu = cpu;
  1611				min_queues = num_queues;
  1612			}
  1613		}
  1614		if (io_cpu != WORK_CPU_UNBOUND) {
  1615			queue->io_cpu = io_cpu;
  1616			atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
  1617			set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
  1618		}
  1619	out:
  1620		dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
  1621			qid, queue->io_cpu);
  1622	}
  1623	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

