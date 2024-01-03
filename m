Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3C1C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 08:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=enGqEKS87FcQlzOhzPE96NfFgKhMQmdVJATL0Zok2dc=; b=O8D9SJNVIv2QVtn9xD6Ef9d9tB
	qlMx3f9qhXF/HQmaELnUrnp+Q9aQ2Pvx3g//FDsc08U7GVwa9esoZVjxJWZiUJzSEuUtJIf0GpYFh
	st5hlFe3Oi33to0vXRqaBjo3199sRLw3kKu/YPSkAsiWSIYo3htYaRd7oRC0RgmOtHuPKzDBOaWMo
	I5qxOd9+0kXN9GVX7jQijb21QLykWWU5D3B4/A9Tzt/fQMcBS4eY81v+RIMtYffv2OHOqdHyPWHEG
	wD511UUBsqYL4mJEmCnjlf5VosG0qIkXX6Q8hdoWTzlSGKfEKCMUP4+EIqG42SAyQFAvZmbZtcjnS
	oOjcmVVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKwwX-00A7os-0I;
	Wed, 03 Jan 2024 08:49:41 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKwwU-00A7o9-2t
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 08:49:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704271778; x=1735807778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V46QIVu/w6IKzB/axNhw4sdC3a/BRufG9OsVwZWmjuY=;
  b=fpbstYOqCnQf3xutm5xocHss6RCmVL05MAGAZeu8wim0QDiigISGMm2v
   wI6OIYUnbPBJ+Itfg+sW/Ab3PO+6ajEtUN1R6LVYe/P3ROFGBxIqbT+cC
   8v037vvPqgM7rvmbQiogzNx4rmOYdvtJoA1FBjvy7FLJh9q1+ELYFoiHx
   Nv2g6uHrIg9imj+fRsnENtX/qiLOCJLTDcRFO0VsIKL0ubO0sUjD7DQf8
   KJosHEnlkfXBul9Ywf19fZV7trHDcby2hmboZXcyGXdOADcEsgw0cubVh
   F1jjHN8fEJSOFb27LBfLsBsb6ytQymY4gF4H9xYkFjiyRDre5y+V8VhZX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="483165849"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="483165849"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:49:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="808774486"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="808774486"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2024 00:49:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKwwM-000Lra-1q;
	Wed, 03 Jan 2024 08:49:30 +0000
Date: Wed, 3 Jan 2024 16:48:45 +0800
From: kernel test robot <lkp@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Liu Song <liusong@linux.alibaba.com>
Subject: [linux-nvme:nvme-6.8 4/16] ld.lld: error: undefined symbol:
 nvme_ns_head_ops
Message-ID: <202401031629.T2JS4GwS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_004938_994710_93E60046 
X-CRM114-Status: UNSURE (   9.17  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.8
head:   3b99fc0cd3a7e44fb294d9f6c13173f3dadf4136
commit: 44bc827e396809faa6a4e2dc9bd5f148373ce88b [4/16] nvme: introduce nvme_disk_is_ns_head helper
config: arm-randconfig-001-20240103 (https://download.01.org/0day-ci/archive/20240103/202401031629.T2JS4GwS-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project baf8a39aaf8b61a38b5b2b5591deb765e42eb00b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240103/202401031629.T2JS4GwS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401031629.T2JS4GwS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: nvme_ns_head_ops
   >>> referenced by sysfs.c
   >>>               drivers/nvme/host/sysfs.o:(nvme_ns_attrs_are_visible) in archive vmlinux.a
   >>> referenced by sysfs.c
   >>>               drivers/nvme/host/sysfs.o:(nvme_ns_attrs_are_visible) in archive vmlinux.a
   >>> referenced by sysfs.c
   >>>               drivers/nvme/host/sysfs.o:(uuid_show) in archive vmlinux.a
   >>> referenced 15 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

