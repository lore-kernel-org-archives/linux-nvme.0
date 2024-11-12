Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC90D597B0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 22:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CJMpEAedxAMtoahEHN+PXSFSse4R9UwgGwRRftxeWHc=; b=2U6x2vTmwziuBVYg7SzKbt7uG8
	Ujs4uHnzzs/sslbX+R4Owwvt2x0oLn29eU4v9kL6k1bcnTlxgN+xXgCOr2FkXu0HfmwlEjaD3SqAY
	jTwRu4zNeHQfvffejdi9weHn+5WzwMajKFQCBLkfEukuFryvD88vsTJIGgrvjbmdFYCGIS+x3yLGs
	dvT8Yji+fMNh/4QZCrEIbM4RzEkvIBCB7fIqRAbgGNuzAWaSDdfKOSBH1MKQwec+Q9w/eVaLJX5pq
	HQX8da8qptjuqSMU9YglE1pLmnhtzWHYlHq286HdXVsZcIGDDd4dhT2nO5FihRNtGAzma7FfKHWdC
	E+6b1rfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAz3o-000000056NQ-1dfb;
	Tue, 12 Nov 2024 22:08:32 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAz3l-000000056MW-1fHq
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 22:08:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731449309; x=1762985309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bwOLoyFxYfjUqtJNi/9ZCqz09dTnm3t/9bGtqoLlI8U=;
  b=IVwNhomQF4zWvejcrdwszuAZZGj5KqtQ/UmeU88Yw7IJ0RjbOHxFqm1v
   49CTwAyzSKjw+vliZjwNP3L/nXX/cqTLnxz7bJfwUkPjPWfwy3gpchnTR
   P/m2vH4I59QnoULZBzWDNBe5aQeGMW7T6BeGEuVwm0HgxrXE5oZqHq7BP
   dsIqY4o1SkbxPbOXO2Wf0l+X2M/neD7xmC6mhtSaB8gyPBvSFSDBH9LUr
   qukDURu/Vfum2vAV876J8t+lC97simAyWSK+sVOHcgCyMH19dVOr443Jx
   2lNPmnPpMXcBGg5ePayPlBPeO/52hGqXMbj32RaInN7kSbGwfvrDQfYoV
   g==;
X-CSE-ConnectionGUID: V/N2vReiRmmWMeOHqNMobA==
X-CSE-MsgGUID: Ef6Cnk0eRpChN9xND/x8Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42722543"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="42722543"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 14:08:27 -0800
X-CSE-ConnectionGUID: QGh9vjHLSpKorf74bKXSXg==
X-CSE-MsgGUID: sKP0TcqbSXmgHwe8OkVCnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="91712794"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Nov 2024 14:08:16 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAz3W-0001lf-1j;
	Tue, 12 Nov 2024 22:08:14 +0000
Date: Wed, 13 Nov 2024 06:07:51 +0800
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v3 3/8] virtio: hookup irq_get_affinity callback
Message-ID: <202411130521.UOBdW8Rv-lkp@intel.com>
References: <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_140829_505256_80AE414A 
X-CRM114-Status: GOOD (  12.50  )
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

[auto build test WARNING on c9af98a7e8af266bae73e9d662b8341da1ec5824]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/driver-core-bus-add-irq_get_affinity-callback-to-bus_type/20241112-213257
base:   c9af98a7e8af266bae73e9d662b8341da1ec5824
patch link:    https://lore.kernel.org/r/20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8%40kernel.org
patch subject: [PATCH v3 3/8] virtio: hookup irq_get_affinity callback
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241113/202411130521.UOBdW8Rv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241113/202411130521.UOBdW8Rv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411130521.UOBdW8Rv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio.c:389: warning: Function parameter or struct member 'irq_veq' not described in 'virtio_irq_get_affinity'
>> drivers/virtio/virtio.c:389: warning: Excess function parameter 'irq_vec' description in 'virtio_irq_get_affinity'


vim +389 drivers/virtio/virtio.c

   379	
   380	/**
   381	 * virtio_irq_get_affinity - get IRQ affinity mask for device
   382	 * @_d: ptr to dev structure
   383	 * @irq_vec: interrupt vector number
   384	 *
   385	 * Return the CPU affinity mask for @_d and @irq_vec.
   386	 */
   387	static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
   388							     unsigned int irq_veq)
 > 389	{
   390		struct virtio_device *dev = dev_to_virtio(_d);
   391	
   392		if (!dev->config->get_vq_affinity)
   393			return NULL;
   394	
   395		return dev->config->get_vq_affinity(dev, irq_veq);
   396	}
   397	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

