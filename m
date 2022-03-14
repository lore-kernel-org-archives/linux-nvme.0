Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D00C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 13:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4t3zXSW2V82PQ376HaI0Cz2osgUKR4bCNazR5WSurCQ=; b=Z5LxW3izLWFG4kOMUnXyCnskXJ
	EVmWPk56Z95MSCd+Za6ajHb8loasGmHQesGPe2Qz3xDwbWD7qVRKyI9/iVDLcRPMURnn5ZV5syN0A
	wzba4hFd9bqtWMvy2GQ7FrI9GwyfycCYpfqalELHhzg2/AvPL6S13sTlFa71f0eIUth5pCw03hXi4
	PChs3GMPqQlmhHqFmnvMwOgmluNBaZx1l1bFlTe10hlD+OltzK8pvBj/y3bcWsmcnFtzeyR7x6TF3
	cRWUf2BTU48MNPing0cLxjOTWCFyGDm5RzQOnHvpPWk9rptxPR9WbtRT61tSYr5W20mKHXNMnDFH1
	tMKnNM4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTkyE-005Yce-Cq; Mon, 14 Mar 2022 13:42:46 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTky4-005Yb1-07
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 13:42:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647265355; x=1678801355;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=aacI74wwqN/aeyfGaWh3Gx6D8H+2LpqSt0z0AD8uybQ=;
 b=ng7agKmfCjOVwVmPqF7gUKYcELFWNkO/07bvv5SMszq8ytg5LTmcPpqh
 c2XwmJ3Xk/3BlKZNba10Mp9Chp6/A8XJNYcAzww/2l76L92MerdW+VjFh
 5YsIJItFSzpHlK1HIiZJeUfYbkp3WPHXpl23Lfuo3W1uge6zEzouRk5ha
 rCC2BMt/IY0JnXncSXgtS3hd+sL31mo/qqayTAdFyRB20mP+0jwwdRd3o
 8g5lrT1cbIpiF4gZzg6WRGLgxIuzxelIhhFHJ/6Ki+II6vJm3ujx8bXbZ
 5IRKcCgVUlj23a2EkJ2EzX4JYHaF1oR2Ixbt2nw3rOUDFXX77eFiFlq2t g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342454839"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; d="scan'208";a="342454839"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 06:42:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; d="scan'208";a="612887094"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by fmsmga004.fm.intel.com with ESMTP; 14 Mar 2022 06:42:34 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nTky1-0009tw-AJ; Mon, 14 Mar 2022 13:42:33 +0000
Date: Mon, 14 Mar 2022 21:42:23 +0800
From: kernel test robot <lkp@intel.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.18 12/12] discovery.c:undefined reference to
 `nvmet_get_feat_kato'
Message-ID: <202203142144.HC6i8FxB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_064236_078533_7FE9C71C 
X-CRM114-Status: GOOD (  10.87  )
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

tree:   git://git.infradead.org/nvme.git nvme-5.18
head:   0ad57fcd030f0bda79a3b6c2fb8fc29b871d9538
commit: 0ad57fcd030f0bda79a3b6c2fb8fc29b871d9538 [12/12] nvmet: open code nvmet_get_feat_kato()
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220314/202203142144.HC6i8FxB-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-5.18
        git checkout 0ad57fcd030f0bda79a3b6c2fb8fc29b871d9538
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/nvme/target/discovery.o: in function `nvmet_execute_disc_get_features':
>> discovery.c:(.text+0x144): undefined reference to `nvmet_get_feat_kato'
   discovery.c:(.text+0x144): relocation truncated to fit: R_NIOS2_CALL26 against `nvmet_get_feat_kato'
>> nios2-linux-ld: discovery.c:(.text+0x154): undefined reference to `nvmet_get_feat_async_event'
   discovery.c:(.text+0x154): relocation truncated to fit: R_NIOS2_CALL26 against `nvmet_get_feat_async_event'
   `adc3xxx_i2c_remove' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

