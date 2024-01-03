Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756EDC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 11:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oviuIdbwpHiU2ahIm/k37qo7aWVIyhuMpnfFeXXXwGk=; b=HOaQB2GKrYLcQaPgBVeDcyAMF4
	kwndJX+ErVNiQNjbzm6RJxYUPyVV1mKzBOhG3ZOG0j72I631OqBQmA9NHd+pI6REhTctVg2QaTG04
	fXlXoGhhPYflPwqlJ8GpHqpc1HlphI7kwvY3/WHbmQsLAHpiZ61FeDB711pRfE4iusGr07W0oviCe
	yk0ENUFY718dHRzYpyG1lIyBzC2HX9sBjulde6WeUfHqabDI6ahutk8Ur0wfUE4EYgv69sYjRdEJs
	DOnIQ0uogiO8FSJKNULtjTo/8gkgxxnqWv75B8tVDRjHvlfbimLbiOLhFGRZllHH6EX4TWG4Zmtwd
	qYfTPqow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKzMT-00AVeV-1Q;
	Wed, 03 Jan 2024 11:24:37 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKzMQ-00AVdm-0O
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 11:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704281074; x=1735817074;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hRjpOoUZZkcnKGVmrvB0UgnjF4/yqv+HzeHwo9bglBA=;
  b=Jc3HEgJ7r92d077sa8VBJZqyNi/TpajsbkXURPdKnggo4W2JaGMp7njz
   4nMdLPWR2gngmF//Hx/v3DzIOqzKy4Y/VGlNbCaHNAP95adqJD/VuheEJ
   /n9Nr8h4CgSzfEI3kwXbZukzXOsxRfhDvXQxEcFIQrLyWckxyWcIT54ZJ
   qzmP9WCT1bpHvF6ugKd+xw+MfQ7u9De6ej6UAdIV0IJJBhhsA7v+TkHEK
   G0lPRND2K0P6V2JyGQ18Ubec9LQoCHTn0qjdqWgFBAam8TPwEKTIvagq7
   /h21Rn9V99mjKBXaO6Wt32l3ROH0jB8P9ubjZZvy/OzgcuFZJ1/INf1r7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463398422"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="463398422"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="729762883"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="729762883"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2024 03:24:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKzMA-000M1K-0I;
	Wed, 03 Jan 2024 11:24:18 +0000
Date: Wed, 3 Jan 2024 19:23:59 +0800
From: kernel test robot <lkp@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Liu Song <liusong@linux.alibaba.com>
Subject: [linux-nvme:nvme-6.8 4/16] drivers/nvme/host/sysfs.c:42: undefined
 reference to `nvme_ns_head_ops'
Message-ID: <202401031943.0N72Tkji-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_032434_199510_77857C86 
X-CRM114-Status: GOOD (  10.80  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.8
head:   3b99fc0cd3a7e44fb294d9f6c13173f3dadf4136
commit: 44bc827e396809faa6a4e2dc9bd5f148373ce88b [4/16] nvme: introduce nvme_disk_is_ns_head helper
config: i386-randconfig-015-20240103 (https://download.01.org/0day-ci/archive/20240103/202401031943.0N72Tkji-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240103/202401031943.0N72Tkji-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401031943.0N72Tkji-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/nvme/host/sysfs.o: in function `dev_to_ns_head':
>> drivers/nvme/host/sysfs.c:42: undefined reference to `nvme_ns_head_ops'
>> ld: drivers/nvme/host/sysfs.c:42: undefined reference to `nvme_ns_head_ops'
>> ld: drivers/nvme/host/sysfs.c:42: undefined reference to `nvme_ns_head_ops'
>> ld: drivers/nvme/host/sysfs.c:42: undefined reference to `nvme_ns_head_ops'
>> ld: drivers/nvme/host/sysfs.c:42: undefined reference to `nvme_ns_head_ops'
   ld: drivers/nvme/host/sysfs.o:drivers/nvme/host/sysfs.c:42: more undefined references to `nvme_ns_head_ops' follow


vim +42 drivers/nvme/host/sysfs.c

    37	
    38	static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
    39	{
    40		struct gendisk *disk = dev_to_disk(dev);
    41	
  > 42		if (nvme_disk_is_ns_head(disk))
    43			return disk->private_data;
    44		return nvme_get_ns_from_dev(dev)->head;
    45	}
    46	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

